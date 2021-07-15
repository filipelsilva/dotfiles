source $HOME/dotfiles/files/defaults.vim

function! PackInit() abort
	packadd minpac
	call minpac#init()
	call minpac#add('k-takata/minpac', {'type': 'opt'})

	call minpac#add('timakro/vim-yadi')
	call minpac#add('nvim-lua/popup.nvim')
	call minpac#add('nvim-lua/plenary.nvim')
	call minpac#add('nvim-telescope/telescope.nvim')
	call minpac#add('nvim-telescope/telescope-fzy-native.nvim')
	call minpac#add('nvim-lua/completion-nvim')
	call minpac#add('neovim/nvim-lspconfig')
	call minpac#add('kabouzeid/nvim-lspinstall')
endfunction

command! PackUpdate source $MYVIMRC | call PackInit() | call minpac#update()
command! PackClean  source $MYVIMRC | call PackInit() | call minpac#clean()

" DetectIndent
autocmd BufRead * DetectIndent

" Telescope
lua << EOF
local actions = require('telescope.actions')
require('telescope').setup {
	defaults = {
		mappings = {
			i = {
				["<C-s>"] = actions.select_horizontal,
				["<C-x>"] = false,
			},
			n = {
				["<C-s>"] = actions.select_horizontal,
				["<C-x>"] = false,
			},
		},
	}
}
require('telescope').load_extension('fzy_native')
EOF
nnoremap <silent> <expr> <leader>f (len(system('git rev-parse')) ? ':Telescope find_files hidden=true' : ':Telescope git_files hidden=true')."\<cr>"
nnoremap <silent> <leader>r <cmd>Telescope live_grep<cr>
nnoremap <silent> <leader>j <cmd>Telescope buffers<cr>

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
