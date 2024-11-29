return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"j-hui/fidget.nvim",
		"creativenull/efmls-configs-nvim",
	},
	config = function()
		local ok_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
		if not ok_cmp then
			return
		end

		local ok, lspconfig = pcall(require, "lspconfig")
		if not ok then
			return
		end

		local ok_fidget, fidget = pcall(require, "fidget")
		if not ok_fidget then
			return
		end

		local ok_efmls, efmls_configs = pcall(require, "efmls-configs.defaults")
		if not ok_efmls then
			return
		end

		-- Update capabilities of LSP to support snippets
		local custom_capabilities = vim.tbl_deep_extend(
			"force",
			vim.lsp.protocol.make_client_capabilities(),
			cmp_nvim_lsp.default_capabilities()
		)

		-- Update capabilities to support utf-16
		custom_capabilities = vim.tbl_deep_extend(
			"force",
			custom_capabilities,
			{
				offsetEncoding = { "utf-16" },
				general = {
					positionEncodings = { "utf-16" },
				},
			}
		)

		-- LSP on_attach function to define settings and keybinds only if a LSP exists
		local custom_on_attach = function(client, bufnr)
			vim.api.nvim_set_option_value("omnifunc", "v:lua.vim.lsp.omnifunc", { buf = bufnr })

			local opts = { noremap = true, silent = true, buffer = bufnr }

			vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
			vim.keymap.set("n", "gI", vim.lsp.buf.implementation, opts)
			vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
			vim.keymap.set("n", "gtd", vim.lsp.buf.type_definition, opts)
			vim.keymap.set("n", "gK", vim.lsp.buf.signature_help, opts)
			vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
			vim.keymap.set("n", "gl", function()
				vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = 0 }), { bufnr = 0 })
			end, opts)
			vim.keymap.set("n", "gA", vim.lsp.buf.code_action, opts)
			vim.keymap.set("n", "gs", vim.lsp.buf.rename, opts)
			vim.keymap.set("n", "[e", function()
				vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })
			end, opts)
			vim.keymap.set("n", "]e", function()
				vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })
			end, opts)

			vim.api.nvim_create_user_command("Format", function()
				vim.lsp.buf.format()
			end, {})
		end

		-- Auto format on write with efm
		local lsp_fmt_group = vim.api.nvim_create_augroup("LspFormattingGroup", {})
		vim.api.nvim_create_autocmd("BufWritePost", {
			group = lsp_fmt_group,
			callback = function(ev)
				local efm = vim.lsp.get_clients({ name = "efm", bufnr = ev.buf })
				if vim.tbl_isempty(efm) then
					return
				end
				vim.lsp.buf.format({
					name = "efm",
					async = false,
					timeout_ms = 10000,
					bufnr = ev.buf,
				})
			end,
		})

		-- Loading spinners
		fidget.setup({})

		-- Custom LSP options {{{
		local efm_languages = efmls_configs.languages()
		efm_languages = vim.tbl_extend("force", efm_languages, {
			go = {
				require("efmls-configs.formatters.gofumpt"),
				require("efmls-configs.formatters.goimports"),
				require("efmls-configs.linters.golint"),
			},
		})
		for lang, config in pairs(efm_languages) do
			-- Add settings to all tools
			efm_languages[lang] = vim.tbl_deep_extend("force", config, {{
				lintOnSave = true,
			}})
		end

		local servers = {
			efm = {
				filetypes = vim.tbl_keys(efm_languages),
				settings = {
					languages = efm_languages,
					rootMarkers = { ".git/" },
				},
				init_options = {
					documentFormatting = true,
					documentRangeFormatting = true,
					hover = true,
					documentSymbol = true,
					codeAction = true,
					completion = true,
				},
			},
			lua_ls = {
				settings = {
					Lua = {
						runtime = { version = "LuaJIT" },
						diagnostics = {
							globals = { "vim" },
						},
						workspace = {
							checkThirdParty = false,
							library = {
								"${3rd}/luv/library",
								unpack(vim.api.nvim_get_runtime_file("", true)),
							},
						},
						completion = {
							callSnippet = "Replace",
						},
						telemetry = {
							enable = false,
						},
					},
				},
			},
		}
		-- }}}

		local ensure_installed = {
			"bashls",
			"clangd",
			"cssls",
			"dockerls",
			"efm",
			"gopls",
			"html",
			"jdtls",
			"lua_ls",
			"nil_ls",
			"pyright",
			"rust_analyzer",
			"terraformls",
			"texlab",
			"ts_ls",
			"vimls",
		}

		-- Setup LSPs
		for _, server_name in ipairs(ensure_installed) do
			local server = servers[server_name] or {}
			server.capabilities = vim.tbl_deep_extend(
				"force",
				{},
				custom_capabilities,
				server.capabilities or {}
			)
			server.on_attach = custom_on_attach
			server.offset_encoding = "utf-16"
			lspconfig[server_name].setup(server)
		end
	end
}
