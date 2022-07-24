local mason_status_ok, mason = pcall(require, "mason")
if not mason_status_ok then
	return
end

local mason_lspconfig_status_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lspconfig_status_ok then
	return
end

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
	return
end

-- Settings {{{
mason.setup({
	ui = {
		icons = {
			package_installed = "[INSTALLED]",
			package_pending = "[PENDING]",
			package_uninstalled = "[UNINSTALLED]",
		},
	},
})
-- }}}

-- Lspconfig {{{
local custom_on_attach = require("user.lsp.handlers").on_attach
local custom_capabilities = require("user.lsp.handlers").capabilities

mason_lspconfig.setup()
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
-- }}}
