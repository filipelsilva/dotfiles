" Settings {{{
syntax on
filetype plugin indent on
set omnifunc=syntaxcomplete#Complete
set nomodeline hidden nocompatible encoding=utf-8 fileformats=unix,dos,mac
set mouse=a scrolloff=5 updatetime=100 ttimeoutlen=0 shortmess=filmnrwxaoOtT
if !has("nvim")
	" Set mouse mode
	set ttymouse=xterm2
	" Enable matchit (extends the use of %)
	packadd! matchit
	" Enable :Man <search>
	runtime ftplugin/man.vim
endif

" K under cursor uses :Man
set keywordprg=:Man

" Folds (marker = 3*'{')
set foldmethod=marker

" Search settings
set ignorecase smartcase incsearch

" Splits like 'normal' editors
set splitbelow splitright

" Completion menu settings
set wildmenu wildmode=longest:full,full completeopt=menuone,noinsert,noselect

" Backspace settings
set backspace=indent,eol,start

" Undo, swap/backup files settings
set undofile undolevels=10000
if has("nvim")
	set undodir=$HOME/.nvim-tmp/undo//
	set directory=$HOME/.nvim-tmp/swp//
	set backupdir=$HOME/.nvim-tmp/backup//
else
	set undodir=$HOME/.vim-tmp/undo//
	set directory=$HOME/.vim-tmp/swp//
	set backupdir=$HOME/.vim-tmp/backup//
endif

" Indentation settings
set autoindent copyindent shiftround smarttab
set noexpandtab tabstop=4 softtabstop=4 shiftwidth=4

" Visual settings
set ruler showcmd linebreak laststatus=0 fillchars+=vert:│ colorcolumn=80
set guicursor=

" Spell settings
set spelllang=en,pt

" Make gf (follow file) work with file_name=/path/to/file
set isfname-==

" Don't use octal for <c-x> and <c-a>
set nrformats=bin,hex
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

" Keymaps {{{

" <leader> key bind
let mapleader = "\<space>"

" Easier completion menus
inoremap <expr> <tab>   pumvisible() ? "\<c-n>" : "\<tab>"
inoremap <expr> <s-tab> pumvisible() ? "\<c-p>" : "\<s-tab>"

" Easier navigation
nnoremap <c-h> <c-w>h
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l
tnoremap <c-h> <c-\><c-n><c-w>h
tnoremap <c-j> <c-\><c-n><c-w>j
tnoremap <c-k> <c-\><c-n><c-w>k
tnoremap <c-l> <c-\><c-n><c-w>l

" Toggle numbers
nnoremap <silent> <leader>n :set invnumber invrelativenumber<cr>

" Toggle spell
nnoremap <silent> <leader>o :set invspell<cr>

" Buffer jumping
nnoremap <silent> gb :bnext<cr>
nnoremap <silent> gB :bprev<cr>

" Buffer jumping part 2: jump to last edited buffer in insert mode
inoremap <c-^> <esc><c-^>

" Replace word under cursor (',': wherever | ';': word only)
nnoremap <leader>s :%s/<c-r><c-w>//g<left><left>
vnoremap <leader>s "zy<esc>:%s/<c-r>z//g<left><left>
nnoremap <leader>S :%s/\<<c-r><c-w>\>//g<left><left>
vnoremap <leader>S "zy<esc>:%s/\<<c-r>z\>//g<left><left>

" Make Y work like D and C
nnoremap Y y$

" Center cursor when searching or joining lines (zz: center, zv: open folds)
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap J mzJ`z

" Undo break points (add or remove more, according to needs)
inoremap , ,<c-g>u
inoremap . .<c-g>u
inoremap ! !<c-g>u
inoremap ? ?<c-g>u

" Add <number>[jk] to jumplists
nnoremap <expr> j (v:count > 5 ? "m'" . v:count : "") . 'j'
nnoremap <expr> k (v:count > 5 ? "m'" . v:count : "") . 'k'

" Move blocks of code
vnoremap J :m '>+1<cr>gv=gv
vnoremap K :m '<-2<cr>gv=gv

" Make . to work with visually selected lines
vnoremap . :normal.<cr>

" Run line as command, output here
noremap Q !!$SHELL<cr>

" Disable highlighting
nnoremap <silent> <leader>, :nohlsearch<cr>

" Open $SHELL in splits
if has("nvim")
	noremap <silent> <leader>t :vsplit term://$SHELL<cr>i
	noremap <silent> <leader>T :split term://$SHELL<cr>i
else
	noremap <silent> <leader>t :vertical terminal<cr>
	noremap <silent> <leader>T :terminal<cr>
endif

" Escape terminal mode with <esc> and send esc to terminal with <c-v><esc>
tnoremap <esc> <c-\><c-n>
tnoremap <c-v><esc> <esc>

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

" Copy/Paste to/from the clipboard
nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>Y "+y$
vnoremap <leader>Y "+y$
nnoremap <leader>d "+d
vnoremap <leader>d "+d
nnoremap <leader>D "+D
vnoremap <leader>D "+D
nnoremap <leader>p "+p
vnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>P "+P

" Copy the whole working file to the clipboard
nnoremap <leader><leader>y <cmd>%yank+<cr>

" Output the current syntax group
nnoremap <f10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<cr>
" }}}
