-- Update capabilities of LSP to support snippets
local ok_cmp_nvim_lsp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not ok_cmp_nvim_lsp then
	return
end

local custom_capabilities = cmp_nvim_lsp.default_capabilities()

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

-- Managed servers
local servers = {
	"bashls",
	"clangd",
	"dockerls",
	"html",
	"gopls",
	"jdtls",
	"lua_ls",
	"pyright",
	"nil_ls",
	"rust_analyzer",
	"terraformls",
	"texlab",
	"tsserver",
	"vimls"
}

-- Custom LSP options {{{
local custom_luals_settings = {
	Lua = {
		runtime = {
			version = "LuaJIT",
		},
		diagnostics = {
			-- Get the language server to recognize the `vim` global
			globals = { "vim" },
		},
		workspace = {
			-- Make the server aware of Neovim runtime files
			library = vim.api.nvim_get_runtime_file("", true),
		},
		-- Do not send telemetry data containing a randomized but unique identifier
		telemetry = {
			enable = false,
		},
	},
}
-- }}}

local ok, lspconfig = pcall(require, "lspconfig")

if not ok then
	return
end

for _, server in ipairs(servers) do
	lspconfig[server].setup({
		on_attach = custom_on_attach,
		capabilities = custom_capabilities,
		settings = server == "lua_ls" and custom_luals_settings or {},
	})
end
