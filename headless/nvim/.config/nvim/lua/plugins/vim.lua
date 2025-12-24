return {
	-- Indentation detector
	"tpope/vim-sleuth",

	-- Surround stuff
	{
		"tpope/vim-surround",
		dependencies = {
			"tpope/vim-repeat",
		},
	},

	-- Session stuff
	"tpope/vim-obsession",

	-- Word stuff
	"tpope/vim-abolish",

	-- Git stuff
	{
		"tpope/vim-fugitive",
		config = function()
			vim.cmd([[
				" Add git branch to statusline
				set statusline=%<%f\ %h%m%r%{FugitiveStatusline()}%=%-14.(%l,%c%V%)\ %P

				" Auto-clean fugitive buffers
				autocmd BufReadPost fugitive://* set bufhidden=delete

				" .. goes to parent on Fugitive tree/blob views
				autocmd User fugitive if fugitive#buffer().type() =~# '^\%(tree\|blob\)$' | nnoremap <buffer> .. :edit %:h<CR> | endif
			]])
		end,
	},

	-- Undo tree
	"mbbill/undotree",

	-- Navigate between vim/neovim and tmux
	"christoomey/vim-tmux-navigator",
}
