return {
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		dependencies = {
			{ "nvim-lua/plenary.nvim", branch = "master" },
			{
				"zbirenbaum/copilot.lua",
				config = function()
					local ok_copilot, copilot = pcall(require, "copilot")

					if not ok_copilot then
						return
					end

					copilot.setup({
						suggestion = { enabled = false },
						panel = { enabled = false },
					})
				end,
			},
		},
		build = "make tiktoken",
		opts = {
			mappings = {
				reset = {
					normal = "",
					insert = "",
				},
			}
		},
	},
}
