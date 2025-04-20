return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
		"igorlfs/nvim-dap-view",
	},
	config = function()
		local ok, dap = pcall(require, "dap")
		local ok_ui, dapui = pcall(require, "dapui")
		local ok_view, dapview = pcall(require, "dap-view")
		if not ok or not ok_ui or not dapview then
			return
		end

		-- Keybinds
		vim.keymap.set("n", "<F1>", dap.continue)
		vim.keymap.set("n", "<F2>", dap.step_into)
		vim.keymap.set("n", "<F3>", dap.step_over)
		vim.keymap.set("n", "<F4>", dap.step_out)
		vim.keymap.set("n", "<F5>", dap.step_back)
		vim.keymap.set("n", "<F7>", dap.toggle_breakpoint)
		vim.keymap.set("n", "<F8>", dap.run_to_cursor)
		vim.keymap.set("n", "<F9>", dap.restart)
		vim.keymap.set("n", "<F10>", function()
			dapui.eval(nil, { enter = true })
		end)

		-- Pretty UI
		dapui.setup()
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

		-- Window UI
		dap.listeners.before.attach["dap-view-config"] = function()
			dapview.open()
		end
		dap.listeners.before.launch["dap-view-config"] = function()
			dapview.open()
		end
		dap.listeners.before.event_terminated["dap-view-config"] = function()
			dapview.close()
		end
		dap.listeners.before.event_exited["dap-view-config"] = function()
			dapview.close()
		end
	end,
}
