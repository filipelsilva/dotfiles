local ok, treesitter = pcall(require, "nvim-treesitter.configs")

if not ok then
	return
end

treesitter.setup({
	ensure_installed = {
		"bash",
		"c",
		"cpp",
		"dockerfile",
		"git_config",
		"git_rebase",
		"gitattributes",
		"gitcommit",
		"gitignore",
		"go",
		"html",
		"java",
		"javascript",
		"json",
		"lua",
		"make",
		"markdown",
		"nix",
		"python",
		"query",
		"ruby",
		"rust",
		"terraform",
		"toml",
		"typescript",
		"vim"
	},
	sync_install = true,
	highlight = {
		enable = true,
		disable = { "markdown" },
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

local ok_context, context = pcall(require, "treesitter-context")

if not ok_context then
	return
end

context.setup()
