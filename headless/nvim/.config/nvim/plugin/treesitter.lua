vim.pack.add({
	{
		src = "https://github.com/nvim-treesitter/nvim-treesitter",
		branch = "master",
	},
	"https://github.com/nvim-treesitter/nvim-treesitter-context",
})

vim.api.nvim_create_autocmd("PackChanged", {
	callback = function(ev)
		local name, kind = ev.data.spec.name, ev.data.kind
		if name == "nvim-treesitter" and kind == "update" then
			if not ev.data.active then
				vim.cmd.packadd("nvim-treesitter")
			end
			vim.cmd("TSUpdate")
		end
	end,
})

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
