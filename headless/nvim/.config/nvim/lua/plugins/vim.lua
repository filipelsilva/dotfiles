return {
	-- Indentation detector
	"tpope/vim-sleuth",

	-- Surround stuff
	{
		"tpope/vim-surround",
		dependencies = {
			"tpope/vim-repeat"
		}
	},

	-- Git stuff
	"tpope/vim-fugitive",

	-- Session stuff
	"tpope/vim-obsession",

	-- Undo tree
	"mbbill/undotree",

	-- Navigate between vim/neovim and tmux
	"christoomey/vim-tmux-navigator",

	-- Fzf
	"junegunn/fzf.vim",
	dependencies = {
		{
			"junegunn/fzf",
			build = ":call fzf#install()"
		}
	}
}
