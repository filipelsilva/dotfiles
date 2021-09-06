source $HOME/dotfiles/files/defaults.vim

" Plugins {{{
function! PackInit() abort
	packadd minpac
	call minpac#init()
	call minpac#add('k-takata/minpac', {'type': 'opt'})

	" Identation detector
	call minpac#add('tpope/vim-sleuth')

	" Comment stuff
	call minpac#add('tpope/vim-commentary')

	" Surround stuff
	call minpac#add('tpope/vim-surround')

	" Colorscheme
	call minpac#add('lifepillar/vim-gruvbox8')

	" Fzf
	call minpac#add('junegunn/fzf.vim')

	" Telescope requirements
	call minpac#add('nvim-lua/popup.nvim')
	call minpac#add('nvim-lua/plenary.nvim')

	" Make Telescope use fuzzy finder, like Fzf
	call minpac#add('nvim-telescope/telescope-fzy-native.nvim')

	" Telescope
	call minpac#add('nvim-telescope/telescope.nvim')

	" Lsp and autoinstall
	call minpac#add('neovim/nvim-lspconfig')
	call minpac#add('kabouzeid/nvim-lspinstall')

	" Snippets
	call minpac#add('hrsh7th/vim-vsnip')

	" Completion
	call minpac#add('hrsh7th/nvim-compe')

	" Treesitter
	call minpac#add('nvim-treesitter/nvim-treesitter')

endfunction

command! PackUpdate source $MYVIMRC | call PackInit() | call minpac#update()
command! PackClean  source $MYVIMRC | call PackInit() | call minpac#clean()
" }}}

" Colorscheme
set background=dark
set termguicolors
colorscheme gruvbox8_hard

" Fzf
set runtimepath+=$HOME/.fzf
let g:fzf_action = {'ctrl-t':'tab split', 'ctrl-s':'split', 'ctrl-v':'vsplit'}
let g:fzf_layout = {'window': {'width': 0.9, 'height': 0.7}}
nnoremap <silent> <expr> <leader>f (len(system('git rev-parse')) ? ':Files' : ':GFiles')."\<cr>"
nnoremap <silent> <leader>r <cmd>Rg<cr>
nnoremap <silent> <leader>j <cmd>Buffers<cr>
tnoremap <expr> <esc> (&filetype == "fzf") ? "<esc>" : "<c-\><c-n>"
tnoremap <expr> <c-j> (&filetype == "fzf") ? "<c-n>" : "<c-j>"
tnoremap <expr> <c-k> (&filetype == "fzf") ? "<c-p>" : "<c-k>"

" Telescope {{{
" lua << EOF
" local actions = require('telescope.actions')
" require('telescope').setup {
" 	defaults = {
" 		mappings = {
" 			i = {
" 				["<c-s>"] = actions.select_horizontal,
" 				["<c-x>"] = false,
" 			},
" 			n = {
" 				["<c-s>"] = actions.select_horizontal,
" 				["<c-x>"] = false,
" 			},
" 		},
" 	},
" 	extensions = {
" 		fzy_native = {
" 			fuzzy = true,
" 			override_generic_sorter = true,
" 			override_file_sorter = true,
" 			case_mode = "smart_case",
" 		},
" 	},
" }
" require('telescope').load_extension('fzy_native')
" EOF
" nnoremap <silent> <expr> <leader>f (len(system('git rev-parse')) ? ':Telescope find_files hidden=true' : ':Telescope git_files hidden=true')."\<cr>"
" nnoremap <silent> <leader>r <cmd>Telescope live_grep<cr>
" nnoremap <silent> <leader>j <cmd>Telescope buffers<cr>
" " }}}

" LSP {{{
lua << EOF
-- Snippet support
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- Server setup
function setup_servers()
	require'lspinstall'.setup()
	local servers = require'lspinstall'.installed_servers()
	for _, server in pairs(servers) do
		require'lspconfig'[server].setup{
			capabilities = capabilities,
		}
	end
end

setup_servers()

require'lspinstall'.post_install_hook = function()
	setup_servers()
	vim.cmd("bufdo e")
end
EOF
" }}}

" Completion {{{
lua << EOF
require'compe'.setup {
	enabled = true;
	autocomplete = true;
	debug = false;
	min_length = 1;
	preselect = 'enable';
	throttle_time = 80;
	source_timeout = 200;
	resolve_timeout = 800;
	incomplete_delay = 400;
	max_abbr_width = 100;
	max_kind_width = 100;
	max_menu_width = 100;
	documentation = {
		border = { '', '' ,'', ' ', '', '', '', ' ' },
		winhighlight = "NormalFloat:CompeDocumentation,FloatBorder:CompeDocumentationBorder",
		max_width = 120,
		min_width = 60,
		max_height = math.floor(vim.o.lines * 0.3),
		min_height = 1,
	};
	source = {
		path = true;
		buffer = true;
		calc = true;
		nvim_lsp = true;
		nvim_lua = true;
		vsnip = true;
	};
}
EOF
inoremap <silent> <expr> <cr> compe#confirm('<cr>')
inoremap <silent> <expr> <c-y> compe#confirm('<c-y>')
" }}}
