" Settings {{{
syntax on
filetype plugin indent on
set nomodeline hidden nocompatible encoding=utf-8 fileformats=unix,dos,mac
set mouse=a scrolloff=5 updatetime=100 ttimeoutlen=0 shortmess=filmnrwxaoOtT

" Cursor always terminal default
set guicursor=

" Folds (marker = 3*'{')
set foldmethod=marker

" Search settings
set ignorecase smartcase nohlsearch incsearch

" Splits like 'normal' editors
set splitbelow splitright

" Completion menu settings
set wildmenu wildmode=longest:full,full completeopt=menuone,noinsert,noselect

" Backspace settings
set backspace=indent,eol,start

" Undo, swap/backup files settings
set undofile undolevels=10000
set undodir=$HOME/.nvim-tmp/undo//
set directory=$HOME/.nvim-tmp/swp//
set backupdir=$HOME/.nvim-tmp/backup//

" Indentation settings
set autoindent copyindent shiftround smarttab
set noexpandtab tabstop=4 softtabstop=4 shiftwidth=4

" Visual settings
set ruler showcmd linebreak laststatus=0 showtabline=0
set fillchars+=vert:│ colorcolumn=80 hlsearch

" Grep function
set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
set grepformat=%f:%l:%c:%m,%f:%l:%m

" Spell settings
set spelllang=en,pt

" Remove trailing whitespaces automatically
autocmd BufWritePre * :%s/\s\+$//e
" }}}

" Functions {{{

" Setup LSPs {{{
lua << EOF
function setup_servers()
	require'lspinstall'.setup()
	local servers = require'lspinstall'.installed_servers()
	for _, server in pairs(servers) do
		require'lspconfig'[server].setup{}
	end
end
EOF
" }}}
" }}}

" Keymaps {{{

"<leader> key bind
let mapleader = "\<space>"

" Completion
inoremap <expr> <tab>   pumvisible() ? "\<c-n>" : "\<tab>"
inoremap <expr> <s-Tab> pumvisible() ? "\<c-p>" : "\<s-tab>"

" Toggle numbers
nnoremap <silent> <leader>n :set invnumber invrelativenumber<cr>

" Toggle spell
nnoremap <silent> <leader>o :set invspell<cr>

" Buffer jumping
nnoremap <silent> gb :bnext<cr>
nnoremap <silent> gB :bprev<cr>

" Buffer jumping part 2: jump to last edited buffer
nnoremap <C-k> <C-^>
inoremap <C-k> <esc><C-^>

" Replace word under cursor (',': wherever | ';': word only)
nnoremap <leader>s :%s/<c-r><c-w>//g<left><left>
vnoremap <leader>s "zy<esc>:%s/<c-r>z//g<left><left>
nnoremap <leader>S :%s/\<<c-r><c-w>\>//g<left><left>
vnoremap <leader>S "zy<esc>:%s/\<<c-r>z\>//g<left><left>

" Easier paste from register in Insert mode
inoremap <c-v> <c-r><c-p>0

" Move blocks of code
vnoremap J :m '>+1<cr>gv=gv
vnoremap K :m '<-2<cr>gv=gv

" Run line as command, output here
noremap Q !!$SHELL<cr>

" Disable highlighting
nnoremap <silent> <leader>, :nohlsearch<cr>

" Open $SHELL in splits
noremap <silent> <leader>t :vsplit term://$SHELL<cr>i
noremap <silent> <leader>T :split term://$SHELL<cr>i

" Quickly edit/reload the vimrc file
nmap <silent> <leader>e :e $MYVIMRC<cr>
nmap <silent> <leader>E :so $MYVIMRC<cr>

" Shortcuts to use blackhole register
nnoremap <leader><leader>d "_d
vnoremap <leader><leader>d "_d
nnoremap <leader><leader>D "_D
vnoremap <leader><leader>D "_D
nnoremap <leader><leader>c "_c
vnoremap <leader><leader>c "_c
nnoremap <leader><leader>C "_C
vnoremap <leader><leader>C "_C
nnoremap <leader><leader>x "_x
vnoremap <leader><leader>x "_x
nnoremap <leader><leader>X "_X
vnoremap <leader><leader>X "_X

" Make . to work with visually selected lines
vnoremap . :normal.<cr>

" Copy/Paste to other programs
nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>d "+d
vnoremap <leader>d "+d
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
vnoremap <leader>P "+P

" Copy the whole working file
nnoremap <leader>Y gg"+yG

" Output the current syntax group
nnoremap <f10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<cr>
" }}}

" Colorscheme {{{
if !has("nvim")
	set cursorline
	set cursorlineopt=number
endif

colorscheme color

set t_Co=256
set background=dark
" }}}

" Plugins {{{
function! PackInit() abort
	packadd minpac
	call minpac#init()
	call minpac#add('k-takata/minpac', {'type': 'opt'})

	call minpac#add('timakro/vim-yadi')
	call minpac#add('neovim/nvim-lspconfig')
	call minpac#add('kabouzeid/nvim-lspinstall')
	call minpac#add('nvim-lua/completion-nvim')
	call minpac#add('nvim-lua/popup.nvim')
	call minpac#add('nvim-lua/plenary.nvim')
	call minpac#add('nvim-telescope/telescope.nvim')
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
setup_servers()

require'lspinstall'.post_install_hook = function()
	setup_servers()
	vim.cmd("bufdo e")
end
EOF
" }}}
