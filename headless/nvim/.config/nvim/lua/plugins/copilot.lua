return {
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		dependencies = {
			{ "nvim-lua/plenary.nvim", branch = "master" },
			{ "github/copilot.vim" },
		},
		build = "make tiktoken",
		opts = function()
			local select = require("CopilotChat.select")
			return {
				model = "claude-3.7-sonnet",
				agent = "copilot",
				mappings = {
					reset = {
						normal = "",
						insert = "<C-l>",
					},
				},
				context = {
					"git",
					"filenames",
					"buffers",
					"files",
					"quickfix",
				},

				selection = function(source)
					return select.visual(source) or select.buffer(source)
				end,

				show_help = false,
			}
		end,
	},
}
