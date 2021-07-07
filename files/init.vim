source $HOME/dotfiles/files/defaults.vim

function! PackInit() abort
	packadd minpac
	call minpac#init()
	call minpac#add('k-takata/minpac', {'type': 'opt'})

	call minpac#add('timakro/vim-yadi')
	call minpac#add('nvim-lua/popup.nvim')
	call minpac#add('nvim-lua/plenary.nvim')
	call minpac#add('nvim-telescope/telescope.nvim')
	call minpac#add('nvim-lua/completion-nvim')
	call minpac#add('neovim/nvim-lspconfig')
	call minpac#add('kabouzeid/nvim-lspinstall')
endfunction

command! PackUpdate source $MYVIMRC | call PackInit() | call minpac#update()
command! PackClean  source $MYVIMRC | call PackInit() | call minpac#clean()

" DetectIndent
autocmd BufRead * DetectIndent

" Telescope
nnoremap <leader>f <cmd>Telescope find_files<cr>
nnoremap <leader>r <cmd>Telescope live_grep<cr>
nnoremap <leader>j <cmd>Telescope buffers<cr>

" Completion
autocmd BufEnter * lua require'completion'.on_attach()

" LSP
lua << EOF
function setup_servers()
	require'lspinstall'.setup()
	local servers = require'lspinstall'.installed_servers()
	for _, server in pairs(servers) do
		require'lspconfig'[server].setup{}
	end
end

setup_servers()

require'lspinstall'.post_install_hook = function()
	setup_servers()
	vim.cmd("bufdo e")
end
EOF
