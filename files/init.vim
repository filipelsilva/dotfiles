" Plugins {{{
call plug#begin()
Plug 'lifepillar/vim-mucomplete' " Completion plugin
Plug 'jiangmiao/auto-pairs' " Close brackets
Plug 'tpope/vim-surround' " Do surroundings
Plug 'tpope/vim-commentary' " Comment stuff
Plug 'tpope/vim-fugitive' " Git stuff
Plug 'mhinz/vim-signify' " Show repo differences
Plug 'mhinz/vim-startify' " Start menu for vim
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim' " Fuzzy finder
Plug 'itchyny/lightline.vim' " Status line
Plug 'mike-hearn/base16-vim-lightline' " Theme for lightline
Plug 'chriskempson/base16-vim' " Themes
call plug#end()
" }}}

" Colorschemes {{{
if (has("nvim"))
	let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif
if (has("termguicolors"))
	set termguicolors
endif

set t_Co=256
highlight Comment cterm=italic gui=italic
colorscheme base16-gruvbox-dark-pale
" }}}

" Settings {{{
syntax on
filetype plugin indent on
set guicursor=
set nocompatible
set nomodeline
set foldenable
set foldmethod=marker
set hidden
set autoindent
set copyindent
set ignorecase
set smartcase
set nohlsearch
set incsearch
set splitbelow
set splitright
set showtabline=1
set mouse=a
set colorcolumn=80,100
set wildmode=longest:full,full
set wildmenu
set completeopt=menuone,noinsert,noselect
set ruler
set showcmd
set scrolloff=5
set signcolumn=yes
set number
set relativenumber
set laststatus=2
set noshowmode
set undodir=$HOME/.vim-undo
set undofile
set undolevels=10000
set tabstop=4
set softtabstop=4
set noexpandtab
set shiftwidth=4
set shiftround
set smarttab
set nowrap
set updatetime=100
" }}}

" Keymaps {{{

"<leader> key bind
let mapleader = " "

" Replace word under cursor
nnoremap ;; :%s/\<<C-r><C-w>\>//g<Left><Left>
vnoremap ;; "zy<Esc>:%s/<C-r>z//g<Left><Left>

" Copy/Paste from other programs
vnoremap <C-y> "*y :let @+=@*<CR>
vnoremap <C-d> "*d :let @+=@*<CR>
"inoremap <C-p> <Esc>"+p
"nnoremap <C-p> <Esc>"+p

" Move blocks of code
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Run line as command, output here
noremap Q !!$SHELL<CR>

" Quickly edit/reload the vimrc file
nmap <silent> <leader>ev :e ~/.config/nvim/init.vim<CR>
nmap <silent> <leader>sv :so ~/.config/nvim/init.vim<CR>

" Move vertically by visual line with j and k
nnoremap j gj
nnoremap k gk

" See tabs and spaces
nnoremap <leader>w :set listchars=space:_,tab:>~ list<CR>

" Esc in terminal or in Fzf windows
tnoremap <expr> <Esc> (&filetype == "fzf") ? "<Esc>" : "<c-\><c-n>"

" Easy window navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Shortcuts to use blackhole register {{{
"nnoremap <leader>d "_d
"vnoremap <leader>d "_d
"nnoremap <leader>D "_D
"vnoremap <leader>D "_D
"nnoremap <leader>c "_c
"vnoremap <leader>c "_c
"nnoremap <leader>C "_C
"vnoremap <leader>C "_C
"nnoremap <leader>x "_x
"vnoremap <leader>x "_x
"nnoremap <leader>X "_X
"vnoremap <leader>X "_X
" }}}
" }}}

" Functions {{{

" Lightline filename without two spaces for modified {{{
function! LightlineFilename()
	let filename = expand('%:t') !=# '' ? expand('%:t') : '[No Name]'
	let modified = &modified ? ' [+]' : ''
	return filename . modified
endfunction
" }}}

" Whitespace remover on write {{{
function! TrimWhitespace()
	let l:save = winsaveview()
	keeppatterns %s/\s\+$//e
	call winrestview(l:save)
endfunction

augroup stopwhitespace
	autocmd!
	autocmd BufWritePre * :call TrimWhitespace()
augroup END
" }}}
" }}}

" Plugin Configurations {{{

" Fzf {{{
nnoremap <silent> <leader>f <cmd>Files<CR>
nnoremap <silent> <leader>g <cmd>Rg<CR>
nnoremap <silent> <leader>b <cmd>Buffers<CR>
nnoremap <silent> <leader>t <cmd>BTags<CR>
nnoremap <silent> <leader>l <cmd>Lines<CR>
nnoremap <silent> <leader>c <cmd>Commits<CR>
" Actions / Layouts
let g:fzf_layout = { 'down': '40%' }
let g:fzf_preview_window = ['right:50%']
let g:fzf_action = {
			\'ctrl-t':'tab split',
			\'ctrl-s':'split',
			\'ctrl-v':'vsplit'
			\}
" Strip down fzf buffer
augroup FzfNoNumbers
	autocmd!
	autocmd FileType fzf exe 'setlocal nonumber norelativenumber signcolumn=no'
augroup END
autocmd! FileType fzf set laststatus=0 noruler
			\| autocmd BufLeave <buffer> set laststatus=2 ruler
" }}}

" Lightline {{{
let g:lightline = {
			\ 'colorscheme': 'base16_gruvbox_dark_pale',
			\ 'active': {
			\   'left': [ [ 'mode', 'paste' ],
			\             [ 'filename' ],
			\             [ 'readonly' ] ],
			\   'right': [ [ 'lineinfo' ], [ 'percent' ],
			\             [ 'binary', 'fileformat', 'fileencoding', 'filetype' ] ]
			\ },
			\ 'component_function': {
			\	'filename': 'LightlineFilename',
			\ },
			\ 'separator': { 'Left': '', 'right': '' },
			\ 'subseparator': { 'Left': '', 'right': '' }
			\ }
" }}}

" Signify
nmap <leader>sn <plug>(signify-next-hunk)
nmap <leader>sp <plug>(signify-prev-hunk)

" Startify
let g:startify_fortune_use_unicode = 1
"" }}}
