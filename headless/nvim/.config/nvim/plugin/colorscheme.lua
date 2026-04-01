vim.pack.add({ "https://github.com/ellisonleao/gruvbox.nvim" })

vim.o.termguicolors = true

local ok, gruvbox = pcall(require, "gruvbox")
if not ok then
	return
end

gruvbox.setup({
	contrast = "hard",
})

vim.cmd.colorscheme("gruvbox")
