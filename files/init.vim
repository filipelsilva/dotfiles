" Settings {{{
syntax on
filetype plugin indent on
set nomodeline hidden nocompatible

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

" Undo settings
set undofile undolevels=10000 undodir=$HOME/.vim-undo

" Indentation settings
set autoindent copyindent shiftround smarttab
set noexpandtab tabstop=4 softtabstop=4 shiftwidth=4

" Visual settings
set nowrap number relativenumber showcmd showtabline=0 laststatus=0

" Other settings
set mouse=a colorcolumn=80 scrolloff=5 updatetime=100

" Terminal with no numbers
if has('nvim')
	autocmd TermOpen * setlocal nonumber norelativenumber
endif
" }}}

" Keymaps {{{

"<leader> key bind
let mapleader = " "

" Replace word under cursor (',': wherever | ';': word only)
nnoremap , :%s/<c-r><c-w>//g<left><left>
vnoremap , "zy<esc>:%s/<c-r>z//g<left><left>
nnoremap ; :%s/\<<c-r><c-w>\>//g<left><left>
vnoremap ; "zy<esc>:%s/\<<c-r>z\>//g<left><left>

" Copy/Paste from other programs
vnoremap <C-y> "*y :let @+=@*<CR>
vnoremap <C-d> "*d :let @+=@*<CR>
nnoremap <C-p> <Esc>"+p
inoremap <C-p> <Esc>"+p

" Move blocks of code
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Run line as command, output here
noremap Q !!$SHELL<CR>

" Open $SHELL in splits
if has('nvim')
	noremap <silent> <leader>t :vsplit term://$SHELL<CR>i
	noremap <silent> <leader>T :split term://$SHELL<CR>i
else
	noremap <silent> <leader>t :vertical terminal<CR>
	noremap <silent> <leader>T :terminal<CR>
endif

" Quickly edit/reload the vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

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

" Shortcuts to use blackhole register
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

" Functions {{{

" TrimWhitespace {{{
function! TrimWhitespace()
	let l:save = winsaveview()
	keeppatterns %s/\s\+$//e
	call winrestview(l:save)
endfunction

command! TrimWhitespace call TrimWhitespace()
" }}}
" }}}

" Colorscheme {{{
set t_Co=256
set background=dark

if (has("nvim"))
	let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif
if (has("termguicolors"))
	set termguicolors
endif

"let g:gruvbox_italic = 1
"let g:gruvbox_italicize_strings = 1
"let g:gruvbox_invert_selection = 0
"let g:gruvbox_sign_column = 'dark0'
"let g:gruvbox_number_column = 'dark0'
"let g:gruvbox_color_column = 'dark0_soft'
"colorscheme gruvbox
colorscheme off 
" }}}

" Plugins {{{

" Minpac {{{
command! PackUpdate source $MYVIMRC | call PackInit() | call minpac#update()
command! PackClean  source $MYVIMRC | call PackInit() | call minpac#clean()

function! PackInit() abort
	packadd minpac
	call minpac#init()
	call minpac#add('k-takata/minpac', {'type': 'opt'})

	call minpac#add('vim-scripts/yaifa.vim')        " Indentation detector
	call minpac#add('junegunn/fzf.vim')             " Fuzzy finder
	call minpac#add('lifepillar/vim-mucomplete')    " Completion plugin
	call minpac#add('mhinz/vim-signify')            " Show repo differences
	call minpac#add('gruvbox-community/gruvbox')    " Colorscheme
	call minpac#add('pbrisbin/vim-colors-off')    	" Colorscheme

endfunction
" }}}

" Fzf
set runtimepath+=$HOME/.fzf
nnoremap <silent> <leader>f <cmd>Files<CR>
nnoremap <silent> <leader>r <cmd>Rg<CR>
nnoremap <silent> <leader>j <cmd>Buffers<CR>
let g:fzf_action = {'ctrl-t':'tab split', 'ctrl-s':'split', 'ctrl-v':'vsplit'}
let g:fzf_layout = {'window': {'width': 0.9, 'height': 0.7, 'border':'sharp'}}

" Signify
nmap <leader>sn <plug>(signify-next-hunk)
nmap <leader>sp <plug>(signify-prev-hunk)
" }}}
