local treesitter_status_ok, treesitter = pcall(require, "nvim-treesitter.configs")
if not treesitter_status_ok then
	return
end

treesitter.setup({
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
