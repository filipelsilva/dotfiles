" Plugins {{{
call plug#begin()
Plug 'lifepillar/vim-mucomplete' " Completion plugin
Plug 'jiangmiao/auto-pairs' " Close brackets
Plug 'tpope/vim-surround' " Do surroundings
Plug 'tpope/vim-commentary' " Comment stuff
Plug 'mhinz/vim-signify' " Show repo differences
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim' " Fuzzy finder
Plug 'gruvbox-community/gruvbox'
call plug#end()
" }}}

" Colorschemes {{{
set t_Co=256

if (has("nvim"))
	let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif
if (has("termguicolors"))
	set termguicolors
endif

let g:gruvbox_italic = 1
let g:gruvbox_sign_column = 'dark0'
let g:gruvbox_color_column = 'dark0_soft'
colorscheme gruvbox
" }}}

" Settings {{{
syntax on
filetype plugin indent on
set nomodeline hidden nocompatible

" Cursor always terminal default
set guicursor=

" Folds (marker = 3*'{')
set foldmethod=marker " Folds

" Search settings
set ignorecase smartcase nohlsearch incsearch

" Splits like 'normal' editors
set splitbelow splitright

" Completion menu settings
set wildmenu wildmode=longest:full,full
set completeopt=menuone,noinsert,noselect

" Undo settings
set undofile undolevels=10000 undodir=$HOME/.vim-undo

" Indentation settings
set autoindent copyindent tabstop=4 softtabstop=4 noexpandtab shiftwidth=4 shiftround smarttab

" Visual settings
set nowrap number relativenumber showtabline=0 laststatus=0

" Other settings
set mouse=a colorcolumn=80 scrolloff=5 updatetime=100

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
vnoremap j gj
vnoremap k gk

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
nnoremap <silent> <leader>t <cmd>BTags<CR>
nnoremap <silent> <leader>b <cmd>Buffers<CR>
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
	autocmd FileType fzf exe 'setlocal nonumber norelativenumber'
augroup END
autocmd! FileType fzf set laststatus=0
			\| autocmd BufLeave <buffer> set laststatus=1
" }}}

" Signify
nmap <leader>sn <plug>(signify-next-hunk)
nmap <leader>sp <plug>(signify-prev-hunk)
" }}}
