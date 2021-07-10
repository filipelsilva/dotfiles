source $HOME/dotfiles/files/defaults.vim

function! PackInit() abort
	packadd minpac
	call minpac#init()
	call minpac#add('k-takata/minpac', {'type': 'opt'})

	call minpac#add('timakro/vim-yadi')
	call minpac#add('junegunn/fzf.vim')
	call minpac#add('nvim-lua/completion-nvim')
	call minpac#add('neovim/nvim-lspconfig')
	call minpac#add('kabouzeid/nvim-lspinstall')
endfunction

command! PackUpdate source $MYVIMRC | call PackInit() | call minpac#update()
command! PackClean  source $MYVIMRC | call PackInit() | call minpac#clean()

" DetectIndent
autocmd BufRead * DetectIndent

" Fzf
set runtimepath+=$HOME/.fzf
let g:fzf_action = {'ctrl-t':'tab split', 'ctrl-s':'split', 'ctrl-v':'vsplit'}
let g:fzf_layout = {'window': {'width': 0.9, 'height': 0.7}}
nnoremap <silent> <expr> <leader>f (len(system('git rev-parse')) ? ':Files' : ':GFiles')."\<cr>"
nnoremap <silent> <leader>r <cmd>Rg<cr>
nnoremap <silent> <leader>j <cmd>Buffers<cr>

" Completion
autocmd BufEnter * lua require'completion'.on_attach()
inoremap <expr> <tab>   pumvisible() ? "\<c-n>" : "\<tab>"
inoremap <expr> <s-tab> pumvisible() ? "\<c-p>" : "\<s-tab>"

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
