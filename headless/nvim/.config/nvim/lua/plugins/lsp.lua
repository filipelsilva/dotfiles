return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"j-hui/fidget.nvim",
		"creativenull/efmls-configs-nvim",
	},
	config = function()
		local ok_cmp, cmp = pcall(require, "blink.cmp")
		if not ok_cmp then
			return
		end

		local ok, lspconfig = pcall(require, "lspconfig")
		if not ok then
			return
		end

		local ok_fzf_lua, fzf_lua = pcall(require, "fzf-lua")
		if not ok_fzf_lua then
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
		local custom_capabilities =
			vim.tbl_deep_extend("force", vim.lsp.protocol.make_client_capabilities(), cmp.get_lsp_capabilities(), {
				offsetEncoding = { "utf-16" },
				general = {
					positionEncodings = { "utf-16" },
				},
			})

		-- LSP on_attach function to define settings and keybinds only if a LSP exists
		local custom_on_attach = function(client, bufnr)
			vim.api.nvim_set_option_value("omnifunc", "v:lua.vim.lsp.omnifunc", { buf = bufnr })

			local opts = { noremap = true, silent = true, buffer = bufnr }

			vim.keymap.set("n", "gD", fzf_lua.lsp_declarations, opts)
			vim.keymap.set("n", "gd", fzf_lua.lsp_definitions, opts)
			vim.keymap.set("n", "gI", fzf_lua.lsp_implementations, opts)
			vim.keymap.set("n", "gr", fzf_lua.lsp_references, opts)
			vim.keymap.set("n", "gtd", fzf_lua.lsp_typedefs, opts)
			vim.keymap.set("n", "gA", fzf_lua.lsp_code_actions, opts)
			vim.keymap.set("n", "gS", fzf_lua.lsp_document_symbols, opts)
			vim.keymap.set("n", "gW", fzf_lua.lsp_workspace_diagnostics, opts)

			vim.keymap.set("n", "<Leader>gD", vim.lsp.buf.declaration, opts)
			vim.keymap.set("n", "<Leader>gd", vim.lsp.buf.definition, opts)
			vim.keymap.set("n", "<Leader>gI", vim.lsp.buf.implementation, opts)
			vim.keymap.set("n", "<Leader>gr", vim.lsp.buf.references, opts)
			vim.keymap.set("n", "<Leader>gtd", vim.lsp.buf.type_definition, opts)
			vim.keymap.set("n", "<Leader>gA", vim.lsp.buf.code_action, opts)

			vim.keymap.set("n", "gs", vim.lsp.buf.rename, opts)
			vim.keymap.set("n", "gK", vim.lsp.buf.signature_help, opts)
			vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
			vim.keymap.set("n", "gl", function()
				vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = 0 }), { bufnr = 0 })
			end, opts)

			vim.keymap.set("n", "[d", function()
				vim.diagnostic.jump({ count = -vim.v.count1 })
			end, opts)
			vim.keymap.set("n", "]d", function()
				vim.diagnostic.jump({ count = vim.v.count1 })
			end, opts)
			vim.keymap.set("n", "[D", function()
				vim.diagnostic.jump({ count = -math.huge })
			end, opts)
			vim.keymap.set("n", "]D", function()
				vim.diagnostic.jump({ count = math.huge })
			end, opts)
			vim.keymap.set("n", "[e", function()
				vim.diagnostic.jump({ count = -vim.v.count1, severity = vim.diagnostic.severity.ERROR })
			end, opts)
			vim.keymap.set("n", "]e", function()
				vim.diagnostic.jump({ count = vim.v.count1, severity = vim.diagnostic.severity.ERROR })
			end, opts)
			vim.keymap.set("n", "[E", function()
				vim.diagnostic.jump({ count = -math.huge, severity = vim.diagnostic.severity.ERROR })
			end, opts)
			vim.keymap.set("n", "]E", function()
				vim.diagnostic.jump({ count = math.huge, severity = vim.diagnostic.severity.ERROR })
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

		-- Hover borders
		vim.o.winborder = "solid"

		-- Set diagnostic options
		vim.diagnostic.config({
			jump = {
				float = true,
			},
		})

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
			efm_languages[lang] = vim.tbl_deep_extend("force", config, { {
				lintOnSave = true,
			} })
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
			server.capabilities = vim.tbl_deep_extend("force", {}, custom_capabilities, server.capabilities or {})
			server.on_attach = custom_on_attach
			server.offset_encoding = "utf-16"
			lspconfig[server_name].setup(server)
		end
	end,
}
