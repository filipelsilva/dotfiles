return {
	"yetone/avante.nvim",
	event = "VeryLazy",
	version = false,
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"stevearc/dressing.nvim",
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		"github/copilot.vim",
		{
			"HakonHarnes/img-clip.nvim",
			event = "VeryLazy",
			opts = {
				default = {
					embed_image_as_base64 = false,
					prompt_for_file_name = false,
					drag_and_drop = {
						insert_mode = true,
					},
				},
			},
		},
	},
	-- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
	build = "make",
	opts = {
		provider = "copilot",
		auto_suggestions_provider = "copilot",
		providers = {
			copilot = {
				endpoint = "https://api.githubcopilot.com",
				model = "gpt-4.1",
			},
		},
		selector = {
			provider = "fzf_lua",
		},
		behaviour = {
			enable_token_counting = false,
		},
	},
}
