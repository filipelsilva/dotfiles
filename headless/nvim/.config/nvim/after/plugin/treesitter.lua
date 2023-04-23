local ok, treesitter = pcall(require, "nvim-treesitter.configs")

if not ok then
	return
end

treesitter.setup({
	ensure_installed = "all",
	sync_install = true,
	highlight = {
		enable = true,
		disable = {
			"markdown"
		},
		additional_vim_regex_highlighting = false,
	},
	incremental_selection = {
		enable = true,
	},
	indent = {
		enable = false,
	},
	playground = {
		enable = true,
	},
})
