return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	dependencies = {
		"nvim-treesitter/nvim-treesitter-context",
	},
	config = function()
		local ok, treesitter = pcall(require, "nvim-treesitter.configs")
		local ok_context, context = pcall(require, "treesitter-context")

		if not ok or not ok_context then
			return
		end

		treesitter.setup({
			ensure_installed = "all",
			sync_install = false,
			highlight = {
				enable = true,
				disable = {},
				additional_vim_regex_highlighting = false,
			},
			incremental_selection = {
				enable = true,
			},
			indent = {
				enable = true,
			},
			playground = {
				enable = true,
			},
		})

		context.setup({
			enable = true,
			multiwindow = true,
			max_lines = 5,
			trim_scope = "outer",
		})
	end,
}
