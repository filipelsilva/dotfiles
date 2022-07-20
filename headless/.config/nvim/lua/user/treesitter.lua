local status_ok, treesitter_configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
	return
end

treesitter_configs.setup({
	-- Enabled languages {{{
	ensure_installed = {
		"bash",
		"c",
		"cpp",
		"dockerfile",
		"go",
		"go",
		"html",
		"java",
		"javascript",
		"json",
		"json",
		"lua",
		"make",
		"markdown",
		"nix",
		"python",
		"rust",
		"toml",
		"typescript",
		"vim"
	},
	-- }}}
	sync_install = true,
	highlight = {
		enable = true,
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
