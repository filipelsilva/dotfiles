M = {}

local ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not ok then
	return
end

-- Update capabilities of LSP to support snippets
M.capabilities = cmp_nvim_lsp.default_capabilities()

-- LSP on_attach function to define settings and keybinds only if a LSP exists
M.on_attach = function(client, bufnr)
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

	local opts = { noremap = true, silent = true, buffer = bufnr }
	vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
	vim.keymap.set("n", "<Leader>a", function() vim.lsp.buf.code_action() end, opts)
	vim.keymap.set("n", "<Leader>k", function() vim.lsp.buf.hover() end, opts)
	vim.keymap.set("n", "<Leader>s", function() vim.lsp.buf.rename() end, opts)
	vim.keymap.set("n", "[e", function() vim.diagnostic.goto_prev() end, opts)
	vim.keymap.set("n", "]e", function() vim.diagnostic.goto_next() end, opts)
end

return M
