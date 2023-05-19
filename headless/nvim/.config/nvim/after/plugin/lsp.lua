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

	vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
	vim.keymap.set("n", "<Leader>a", function() vim.lsp.buf.code_action() end, opts)
	vim.keymap.set("n", "<Leader>k", function() vim.lsp.buf.hover() end, opts)
	vim.keymap.set("n", "<Leader>s", function() vim.lsp.buf.rename() end, opts)
	vim.keymap.set("n", "[e", function() vim.diagnostic.goto_prev() end, opts)
	vim.keymap.set("n", "]e", function() vim.diagnostic.goto_next() end, opts)
end

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
	"texlab",
	"tsserver",
	"vimls"
}

local ok, lspconfig = pcall(require, "lspconfig")

if not ok then
	return
end

local custom_luals_settings = {
	Lua = {
		runtime = {
			version = "LuaJIT",
		},
		diagnostics = {
			-- Get the language server to recognize the `vim` global
			globals = {"vim"},
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

for _, server in ipairs(servers) do
	lspconfig[server].setup({
		on_attach = custom_on_attach,
		capabilities = custom_capabilities,
		settings = server == "lua_ls" and custom_luals_settings or {},
	})
end

vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("coq_maps", {}),
	pattern = "coq",
	callback = function()
		vim.keymap.set("n", "<Leader>;", function() vim.cmd([[CoqToLine]]) end, { noremap = true, silent = true })
	end,
})
