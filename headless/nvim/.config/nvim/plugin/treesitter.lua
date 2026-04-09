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
	callback = function(args)
		local lang = vim.treesitter.language.get_lang(args.match)
		if vim.list_contains(treesitter.get_installed(), lang) then
			vim.treesitter.start()
		end
	end,
})

context.setup({
	enable = true,
	multiwindow = true,
	max_lines = 5,
	trim_scope = "outer",
})
