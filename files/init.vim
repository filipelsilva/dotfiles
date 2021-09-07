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

	" Completion sources
	call minpac#add('hrsh7th/vim-vsnip')
	call minpac#add('hrsh7th/cmp-buffer')
	call minpac#add('hrsh7th/cmp-path')
	call minpac#add('hrsh7th/cmp-nvim-lsp')

	" Completion
	call minpac#add('hrsh7th/nvim-cmp')

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

" DetectIndent
autocmd BufRead * DetectIndent

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
		fzy_native = {
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
" " }}}

" LSP {{{
lua << EOF
-- Snippet support
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
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
		['<c-p>'] = cmp.mapping.select_prev_item(),
		['<c-n>'] = cmp.mapping.select_next_item(),
		['<c-y>'] = cmp.mapping.confirm({ select = true }),
		['<cr>'] = cmp.mapping.confirm({ select = true }),
    },
    sources = {
		{ name = 'nvim_lsp' },
		{ name = 'buffer' },
		{ name = 'path' },
    },
})
EOF
" }}}
