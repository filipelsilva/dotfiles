vim.pack.add({
	"https://github.com/nvim-treesitter/nvim-treesitter",
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

local ok, treesitter = pcall(require, "nvim-treesitter")
local ok_context, context = pcall(require, "treesitter-context")

if not ok or not ok_context then
	return
end

treesitter.setup({
	install_dir = vim.fn.stdpath("data") .. "/site"
})

treesitter.install("unstable")

vim.api.nvim_create_autocmd("FileType", {
	pattern = treesitter.get_installed(),
	callback = function()
		vim.treesitter.start()
	end,
})

context.setup({
	enable = true,
	multiwindow = true,
	max_lines = 5,
	trim_scope = "outer",
})
