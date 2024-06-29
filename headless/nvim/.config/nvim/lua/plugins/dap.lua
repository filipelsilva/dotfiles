return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
	},
	config = function()
		local ok, dap = pcall(require, "dap")
		local ok_ui, dapui = pcall(require, "dapui")
		local ok_vscode, ext_vscode = pcall(require, "dap.ext.vscode")
		if not ok or not ok_ui or not ok_vscode then
			return
		end

		-- Load .vscode/launch.json
		ext_vscode.load_launchjs(nil, {})

		-- Keybinds
		vim.keymap.set("n", "<F1>", dap.continue)
		vim.keymap.set("n", "<F2>", dap.step_into)
		vim.keymap.set("n", "<F3>", dap.step_over)
		vim.keymap.set("n", "<F4>", dap.step_out)
		vim.keymap.set("n", "<F5>", dap.step_back)
		vim.keymap.set("n", "<F10>", dap.toggle_breakpoint)
		vim.keymap.set("n", "<F11>", dap.run_to_cursor)
		vim.keymap.set("n", "<F12>", dap.restart)
		vim.keymap.set("n", "<F9>", function()
			dapui.eval(nil, { enter = true })
		end)

		-- Pretty UI
		dap.listeners.before.attach.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.launch.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated.dapui_config = function()
			dapui.close()
		end
		dap.listeners.before.event_exited.dapui_config = function()
			dapui.close()
		end
	end
}
