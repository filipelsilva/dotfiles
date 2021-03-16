" Plugins {{{
call plug#begin()
Plug 'itchyny/lightline.vim' " Status line
Plug 'mike-hearn/base16-vim-lightline' " Theme for lightline
Plug 'sheerun/vim-polyglot' " Language packs
Plug 'dense-analysis/ale' " While no better alternative arrives, linter
Plug 'lifepillar/vim-mucomplete' " Completion
Plug 'mhinz/vim-signify' " Show repo differences
Plug 'tpope/vim-fugitive' " Git wrapper
Plug 'tpope/vim-surround' " Do surroundings
Plug 'tpope/vim-commentary' " Comment stuff
Plug 'tpope/vim-abolish' " Change word structures
Plug 'aklt/vim-substitute' " Shortcuts to substitution
Plug 'psliwka/vim-smoothie' " Smooth scrolling
Plug 'mhinz/vim-startify' " Start menu for vim
Plug 'roryokane/detectindent' " Detect default identation
Plug 'jiangmiao/auto-pairs' " Close brackets
Plug 'dhruvasagar/vim-table-mode' " Tables in vim
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim' " Fuzzy finder
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
set pastetoggle=<F2>
set splitbelow
set splitright
set showtabline=1
set mouse=a
set colorcolumn=80,100
filetype plugin indent on
syntax on
set wildmode=longest:full,full
set wildmenu
set ruler
set showcmd
set scrolloff=5
set signcolumn=yes
set number
set relativenumber
set laststatus=2
set noshowmode
set undodir=/home/$USER/.vim-undo
set undofile
set undolevels=10000
set tabstop=4
set softtabstop=4
set noexpandtab
set shiftwidth=4
set shiftround
set smarttab
set nowrap
" }}}

" Keymaps {{{

"<leader> key bind
let mapleader = " "

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

" Esc in terminal or in Fzf windows
tnoremap <expr> <Esc> (&filetype == "fzf") ? "<Esc>" : "<c-\><c-n>"

" Easy window navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Shortcuts to use blackhole register {{{
nnoremap <leader>d "_d
vnoremap <leader>d "_d
nnoremap <leader>D "_D
vnoremap <leader>D "_D
nnoremap <leader>c "_c
vnoremap <leader>c "_c
nnoremap <leader>C "_C
vnoremap <leader>C "_C
nnoremap <leader>x "_x
vnoremap <leader>x "_x
nnoremap <leader>X "_X
vnoremap <leader>X "_X
" }}}
" }}}

" Functions {{{
function! LightlineFilename()
  let filename = expand('%:t') !=# '' ? expand('%:t') : '[No Name]'
  let modified = &modified ? ' [+]' : ''
  return filename . modified
endfunction

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

" Plugin Configurations {{{

" Fzf {{{
nnoremap <silent> <leader>f <cmd>Files<cr>
nnoremap <silent> <leader>g <cmd>Rg<cr>
nnoremap <silent> <leader>b <cmd>Buffers<cr>
nnoremap <silent> <leader>t <cmd>BTags<cr>
nnoremap <silent> <leader>l <cmd>Lines<cr>
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
			\             [ 'readonly', 'gitbranch' ] ],
			\   'right': [ [ 'lineinfo' ], [ 'percent' ],
			\             [ 'binary', 'fileformat', 'fileencoding', 'filetype' ] ]
			\ },
			\ 'component_function': {
			\   'gitbranch': 'FugitiveHead',
			\	'filename': 'LightlineFilename',
			\ },
			\ 'separator': { 'left': '', 'right': '' },
			\ 'subseparator': { 'left': '', 'right': '' }
			\ }
" }}}

" MuComplete
set completeopt=menuone,noinsert,noselect
"let g:mucomplete#enable_auto_at_startup = 1

" Signify
set updatetime=100
nmap <leader>sn <plug>(signify-next-hunk)
nmap <leader>sp <plug>(signify-prev-hunk)

" Startify
let g:startify_fortune_use_unicode = 1

" Table Mode
let g:table_mode_map_prefix = '<C-t>'

"" DetectIndent
"augroup DetectIndent
"   autocmd!
"   autocmd BufReadPost * DetectIndent
"augroup END
"" }}}
