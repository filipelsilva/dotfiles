return {
	"ellisonleao/gruvbox.nvim",
	config = function()
		vim.o.termguicolors = true

		local ok, gruvbox = pcall(require, "gruvbox")
		if not ok then
			return
		end

		gruvbox.setup({
			contrast = "hard",
		})

		local colorscheme = "gruvbox"

		vim.cmd.colorscheme(colorscheme)
	end,
}
