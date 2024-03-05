-- Update capabilities of LSP to support snippets
local ok_cmp_nvim_lsp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not ok_cmp_nvim_lsp then
	return
end

local custom_capabilities = vim.tbl_deep_extend(
	"force",
	vim.lsp.protocol.make_client_capabilities(),
	cmp_nvim_lsp.default_capabilities()
)

-- LSP on_attach function to define settings and keybinds only if a LSP exists
local custom_on_attach = function(client, bufnr)
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

	local opts = { noremap = true, silent = true, buffer = bufnr }

	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
	vim.keymap.set("n", "gI", vim.lsp.buf.implementation, opts)
	vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
	vim.keymap.set("n", "gtd", vim.lsp.buf.type_definition, opts)
	vim.keymap.set("n", "gK", vim.lsp.buf.signature_help, opts)
	vim.keymap.set("n", "<Leader>k", vim.lsp.buf.hover, opts)
	vim.keymap.set("n", "<Leader>a", vim.lsp.buf.code_action, opts)
	vim.keymap.set("n", "gs", vim.lsp.buf.rename, opts)
	vim.keymap.set("n", "[e", vim.diagnostic.goto_prev, opts)
	vim.keymap.set("n", "]e", vim.diagnostic.goto_next, opts)

	vim.api.nvim_create_augroup("LspAutocmd", { clear = true })
	vim.api.nvim_create_autocmd("BufWritePre", {
		group = "LspAutocmd",
		callback = function() vim.lsp.buf.format() end,
	})
end

-- Custom LSP options {{{
local servers = {
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

local ok, lspconfig = pcall(require, "lspconfig")
if not ok then
	return
end

local ok_mason, mason = pcall(require, "mason")
if not ok_mason then
	return
end

local ok_mason_lspconfig, mason_lspconfig = pcall(require, "mason-lspconfig")
if not ok_mason_lspconfig then
	return
end

local ok_fidget, fidget = pcall(require, "fidget")
if not ok_fidget then
	return
end

fidget.setup({})

mason.setup({
	PATH = "append", -- Use the system's LSPs if they exist
})

local ensure_installed = vim.tbl_keys(servers or {})
vim.list_extend(ensure_installed, {
	"bashls",
	"clangd",
	"dockerls",
	"gopls",
	"html",
	"jdtls",
	"lua_ls",
	"nil_ls",
	"pyright",
	"rust_analyzer",
	"terraformls",
	"texlab",
	"tsserver",
	"vimls",
})

mason_lspconfig.setup({
	ensure_installed = ensure_installed,
	handlers = {
		function(server_name)
			local server = servers[server_name] or {}
			server.capabilities = vim.tbl_deep_extend(
				"force",
				{},
				custom_capabilities,
				server.capabilities or {}
			)
			server.on_attach = custom_on_attach
			lspconfig[server_name].setup(server)
		end,
	},
})
