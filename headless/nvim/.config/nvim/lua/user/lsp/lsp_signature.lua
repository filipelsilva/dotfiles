local ok, signature = pcall(require, "lsp_signature")

if not ok then
	return
end

signature.setup({
	bind = true,
	handler_opts = { border = "none" },
	hint_enable = false,
	padding = " ",
})
