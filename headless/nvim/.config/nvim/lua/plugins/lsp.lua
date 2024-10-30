return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"j-hui/fidget.nvim",
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

		fidget.setup({})

		-- Custom LSP options {{{
		local servers = {
			nixd = {
				nixpkgs = {
					expr = "import <nixpkgs> {}",
				},
				formatting = {
					command = { "alejandra" }, -- or nixfmt or nixpkgs-fmt
				},
			},
			lua_ls = {
				settings = {
					Lua = {
						runtime = { version = "LuaJIT" },
						diagnostics = {
							-- Get the language server to recognize the `vim` global
							globals = { "vim" },
						},
						workspace = {
							checkThirdParty = false,
							-- Tells lua_ls where to find all the Lua files that you have loaded
							-- for your neovim configuration.
							library = {
								"${3rd}/luv/library",
								unpack(vim.api.nvim_get_runtime_file('', true)),
							},
							-- If lua_ls is really slow on your computer, you can try this instead:
							-- library = { vim.env.VIMRUNTIME },
						},
						completion = {
							callSnippet = "Replace",
						},
						-- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
						-- diagnostics = { disable = { 'missing-fields' } },
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
			"dockerls",
			"gopls",
			"html",
			"jdtls",
			"lua_ls",
			"nixd",
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
