local status_ok, signature = pcall(require, "lsp_signature")
if not status_ok then
	return
end

signature.setup({
	bind = true,
	hint_enable = true,
	hint_prefix = "-> ",
	handler_opts = {
		border = "none"
	},
	hint_scheme = "String",
	padding = " ",
})
