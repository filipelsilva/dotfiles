source $HOME/dotfiles/files/defaults.vim

" Plugins {{{
function! PackInit() abort
	packadd minpac
	call minpac#init()
	call minpac#add('k-takata/minpac', {'type': 'opt'})

	" Identation detector
	call minpac#add('timakro/vim-yadi')

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
	call minpac#add('nvim-telescope/telescope-fzf-native.nvim', {'do': 'make'})

	" Telescope
	call minpac#add('nvim-telescope/telescope.nvim')

	" Lsp and autoinstall
	call minpac#add('neovim/nvim-lspconfig')
	call minpac#add('kabouzeid/nvim-lspinstall')

	" Completion sources
	call minpac#add('hrsh7th/vim-vsnip')
	call minpac#add('hrsh7th/cmp-vsnip')
	call minpac#add('hrsh7th/cmp-buffer')
	call minpac#add('hrsh7th/cmp-path')
	call minpac#add('hrsh7th/cmp-nvim-lsp')

	" Completion
	call minpac#add('hrsh7th/nvim-cmp')

	" Treesitter
	call minpac#add('nvim-treesitter/nvim-treesitter')
	call minpac#add('nvim-treesitter/playground')

endfunction

command! PackUpdate source $MYVIMRC | call PackInit() | call minpac#update()
command! PackClean  source $MYVIMRC | call PackInit() | call minpac#clean()
" }}}

" Colorscheme
set background=dark
set termguicolors
colorscheme gruvbox8_hard

" DetectIndent
augroup DetectIndent
	autocmd!
	autocmd BufRead * DetectIndent
augroup END

" Fzf
set runtimepath+=$HOME/.fzf
let g:fzf_action = {'ctrl-t': 'tab split', 'ctrl-s': 'split', 'ctrl-v': 'vsplit'}
let g:fzf_layout = {'window': {'width': 0.9, 'height': 0.7}}
nnoremap <silent> <expr> <Leader>f (len(system('git rev-parse')) ? ':Files' : ':GFiles')."\<CR>"
nnoremap <silent> <Leader>r <Cmd>Rg<CR>
nnoremap <silent> <Leader>j <Cmd>Buffers<CR>
tnoremap <expr> <Esc> (&filetype == "fzf") ? "<Esc>" : "<C-\><C-n>"
tnoremap <expr> <C-j> (&filetype == "fzf") ? "<C-n>" : "<C-j>"
tnoremap <expr> <C-k> (&filetype == "fzf") ? "<C-p>" : "<C-k>"

" Telescope {{{
lua << EOF
local actions = require('telescope.actions')
require('telescope').setup {
	defaults = {
		mappings = {
			i = {
				["<c-s>"] = actions.select_horizontal,
				["<c-x>"] = false,
			},
			n = {
				["<c-s>"] = actions.select_horizontal,
				["<c-x>"] = false,
			},
		},
	},
	extensions = {
		fzf = {
			fuzzy = true,
			override_generic_sorter = true,
			override_file_sorter = true,
			case_mode = "smart_case",
		},
	},
}
require('telescope').load_extension('fzf')
EOF
nnoremap <silent> <expr> <leader>F (len(system('git rev-parse')) ? ':Telescope find_files hidden=true' : ':Telescope git_files hidden=true')."\<cr>"
nnoremap <silent> <leader>R <cmd>Telescope live_grep<cr>
nnoremap <silent> <leader>J <cmd>Telescope buffers<cr>
" }}}

" LSP {{{
lua << EOF
-- Snippet support
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

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
local cmp = require'cmp'
cmp.setup({
	snippet = {
		expand = function(args)
			vim.fn["vsnip#anonymous"](args.body)
		end,
	},
	mapping = {
		['<C-p>'] = cmp.mapping.select_prev_item(),
		['<C-n>'] = cmp.mapping.select_next_item(),
		['<C-y>'] = cmp.mapping.confirm({ select = true }),
		['<CR>'] = cmp.mapping.confirm({ select = true }),
	},
	sources = {
		{ name = 'nvim_lsp' },
		{ name = 'vsnip' },
		{ name = 'buffer' },
		{ name = 'path' },
	},
})
EOF
imap <expr> <Tab>   pumvisible() ? "<C-n>" : vsnip#jumpable(1)  ? "<Plug>(vsnip-jump-next)" : "<Tab>"
imap <expr> <S-Tab> pumvisible() ? "<C-p>" : vsnip#jumpable(-1) ? "<Plug>(vsnip-jump-prev)" : "<S-Tab>"
smap <expr> <Tab>   vsnip#jumpable(1)  ? "<Plug>(vsnip-jump-next)" : "<Tab>"
smap <expr> <S-Tab> vsnip#jumpable(-1) ? "<Plug>(vsnip-jump-prev)" : "<S-Tab>"
" }}}

" Treesitter {{{
lua << EOF
require'nvim-treesitter.configs'.setup{
	-- ensure_installed = "maintained",
	highlight = {
		enable = false,
		additional_vim_regex_highlighting = false,
	},
	incremental_selection = {
		enable = false,
	},
	indent = {
		enable = false,
	},
}
EOF
" }}}
