return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
	},
	config = function()
		-- Keybinds
		local ok, dap = pcall(require, "dap")
		vim.keymap.set('n', '<F5>', dap.continue)
		vim.keymap.set('n', '<F6>', dap.toggle_breakpoint)
		vim.keymap.set('n', '<F10>', dap.step_over)
		vim.keymap.set('n', '<F11>', dap.step_into)
		vim.keymap.set('n', '<F12>', dap.step_out)

		-- Pretty UI
		local ok_ui, dapui = pcall(require, "dapui")
		if not ok or not ok_ui then
			return
		end

		dap.listeners.after.event_initialized["dapui_config"] = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated["dapui_config"] = function()
			dapui.close()
		end
		dap.listeners.before.event_exited["dapui_config"] = function()
			dapui.close()
		end

		-- Load .vscode/launch.json
		local ok_vscode, ext_vscode = pcall(require, "dap.ext.vscode")
		if not ok_vscode then
			return
		end

		ext_vscode.load_launchjs(nil, {})

		-- GO debug
		local ok_go, dap_go = pcall(require, "dap-go")
		if not ok_go then
			return
		end

		dap_go.setup()
	end
}
