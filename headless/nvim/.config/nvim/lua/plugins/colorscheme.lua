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

		local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
		if not status_ok then
			return
		end
	end
}
