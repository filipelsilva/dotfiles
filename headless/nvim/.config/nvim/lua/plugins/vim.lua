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

	-- UNIX stuff
	"tpope/vim-eunuch",

	-- Async stuff
	{
		"tpope/vim-dispatch",
		config = function()
			vim.g.dispatch_no_maps = 1
			vim.keymap.set("n", "<Leader><Leader>d", "<Cmd>Dispatch!<CR>", { noremap = true })
			vim.keymap.set("n", "<Leader>d", ":Dispatch!<Space>", { noremap = true })
			vim.keymap.set("n", "<Leader><Leader>m", "<Cmd>Make!<CR>", { noremap = true })
			vim.keymap.set("n", "<Leader>m", ":Make!<Space>", { noremap = true })
		end,
	},

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
