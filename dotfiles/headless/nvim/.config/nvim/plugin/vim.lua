vim.pack.add({
	-- Indentation detector
	"https://github.com/tpope/vim-sleuth",

	-- Enable dot-repeat for some plugins
	"https://github.com/tpope/vim-repeat",

	-- Surround stuff
	"https://github.com/tpope/vim-surround",

	-- Session stuff
	"https://github.com/tpope/vim-obsession",

	-- Word stuff
	"https://github.com/tpope/vim-abolish",

	-- Git stuff
	"https://github.com/tpope/vim-fugitive",

	-- Navigate between vim/neovim and tmux
	"https://github.com/christoomey/vim-tmux-navigator",
})

vim.cmd([[
	" Add git branch to statusline
	set statusline=%<%f\ %h%m%r%{FugitiveStatusline()}%=%-14.(%l,%c%V%)\ %P

	" Auto-clean fugitive buffers
	autocmd BufReadPost fugitive://* set bufhidden=delete

	" .. goes to parent on Fugitive tree/blob views
	autocmd User fugitive if fugitive#buffer().type() =~# '^\%(tree\|blob\)$' | nnoremap <buffer> .. :edit %:h<CR> | endif
]])
