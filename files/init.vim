source $HOME/dotfiles/files/defaults.vim

function! PackInit() abort
	packadd minpac
	call minpac#init()
	call minpac#add('k-takata/minpac', {'type': 'opt'})

	" Indentation detector
	call minpac#add('timakro/vim-yadi')

	" Colorscheme
	call minpac#add('lifepillar/vim-gruvbox8')

	" Telescope requirements
	call minpac#add('nvim-lua/popup.nvim')
	call minpac#add('nvim-lua/plenary.nvim')

	" Make Telescope use fuzzy finder, like FZF
	call minpac#add('nvim-telescope/telescope-fzy-native.nvim')

	" Telescope
	call minpac#add('nvim-telescope/telescope.nvim')

	" Lsp and completion
	call minpac#add('neoclide/coc.nvim', {'branch': 'release'})

	" Treesitter
	call minpac#add('nvim-treesitter/nvim-treesitter')

endfunction

command! PackUpdate source $MYVIMRC | call PackInit() | call minpac#update()
command! PackClean  source $MYVIMRC | call PackInit() | call minpac#clean()

" DetectIndent
autocmd BufRead * DetectIndent

" Colorscheme
set background=dark
set termguicolors
colorscheme gruvbox8_hard
hi Normal guifg=#c5c8c6

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
	},
	extensions = {
		fzf_native = {
			fuzzy = true,
			override_generic_sorter = true,
			override_file_sorter = true,
			case_mode = "smart_case",
		},
	},
}
require('telescope').load_extension('fzy_native')
EOF
nnoremap <silent> <expr> <leader>f (len(system('git rev-parse')) ? ':Telescope find_files hidden=true' : ':Telescope git_files hidden=true')."\<cr>"
nnoremap <silent> <leader>r <cmd>Telescope live_grep<cr>
nnoremap <silent> <leader>j <cmd>Telescope buffers<cr>

" Completion
inoremap <expr> <cr>    pumvisible() ? "\<c-y>" : "\<c-g>u\<cr>"
