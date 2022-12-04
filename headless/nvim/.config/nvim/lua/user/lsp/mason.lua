local ok_mason, mason = pcall(require, "mason")
local ok_mason_lspconfig, mason_lspconfig = pcall(require, "mason-lspconfig")
local ok_lspconfig, lspconfig = pcall(require, "lspconfig")

if not ok_mason or not ok_mason_lspconfig or not ok_lspconfig then
	return
end

mason.setup()

-- Lspconfig
local custom_on_attach = require("user.lsp.handlers").on_attach
local custom_capabilities = require("user.lsp.handlers").capabilities

mason_lspconfig.setup_handlers({
	function(server_name) -- Default handler
		lspconfig[server_name].setup({
			on_attach = custom_on_attach,
			capabilities = custom_capabilities,
		})
	end,
	["sumneko_lua"] = function()
		lspconfig.sumneko_lua.setup({
			on_attach = custom_on_attach,
			capabilities = custom_capabilities,
			settings = { Lua = { diagnostics = { globals = { "vim" } } } }
		})
	end,
})
