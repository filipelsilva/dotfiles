" Settings {{{
syntax enable
filetype plugin indent on

set omnifunc=syntaxcomplete#Complete
set nomodeline nocompatible hidden confirm
set encoding=utf-8 fileformats=unix,dos,mac
set updatetime=100 ttimeoutlen=0
set mouse=a

if !has("nvim")
	" Set mouse mode
	set ttymouse=xterm2
	" Enable matchit (extends the use of %)
	runtime macros/matchit.vim
	" Enable :Man <search>
	runtime ftplugin/man.vim
endif

" K under cursor uses :Man
set keywordprg=:Man

" Folds (marker = 3*'{')
set foldmethod=marker

" Search settings
set ignorecase smartcase incsearch hlsearch

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
set autoindent copyindent shiftround smarttab breakindent
set noexpandtab tabstop=4 softtabstop=4 shiftwidth=4

" Visual settings
set ruler showcmd linebreak laststatus=0 scrolloff=5 colorcolumn=80
set shortmess=filmnrwxaoOtT fillchars+=vert:│ guicursor=

" Spell settings
set spelllang=en,pt

" Diff options
set diffopt=filler,internal,algorithm:histogram,indent-heuristic

" Make gf (follow file) work with file_name=/path/to/file
set isfname-==

" Don't use octal for <C-x> and <C-a>
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

" <Leader> key bind
let mapleader = "\<Space>"

" Easier completion menus
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Easier navigation
nnoremap <C-h> <C-w><C-h>
nnoremap <C-j> <C-w><C-j>
nnoremap <C-k> <C-w><C-k>
nnoremap <C-l> <C-w><C-l>
tnoremap <C-h> <C-\><C-n><C-w><C-h>
tnoremap <C-j> <C-\><C-n><C-w><C-j>
tnoremap <C-k> <C-\><C-n><C-w><C-k>
tnoremap <C-l> <C-\><C-n><C-w><C-l>

" Toggle numbers
nnoremap <silent> <Leader>n :set invnumber invrelativenumber<CR>

" Toggle spell
nnoremap <silent> <Leader>o :set invspell<CR>

" Buffer jumping
nnoremap <silent> gb :bnext<CR>
nnoremap <silent> gB :bprev<CR>

" Buffer jumping part 2: jump to last edited buffer in insert mode
inoremap <C-^> <Esc><C-^>

" Replace word under cursor (',': wherever | ';': word only)
nnoremap <Leader>s :%s/<C-r><C-w>//g<Left><Left>
vnoremap <Leader>s "zy<Esc>:%s/<C-r>z//g<Left><Left>
nnoremap <Leader>S :%s/\<<C-r><C-w>\>//g<Left><Left>
vnoremap <Leader>S "zy<Esc>:%s/\<<C-r>z\>//g<Left><Left>

" Make Y work like D and C
nnoremap Y y$

" Center cursor when searching or joining lines (zz: center, zv: open folds)
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap J mzJ`z

" Undo break points (add or remove more, according to needs)
inoremap , ,<C-g>u
inoremap . .<C-g>u
inoremap ! !<C-g>u
inoremap ? ?<C-g>u

" Add <number>[jk] to jumplists
nnoremap <expr> j (v:count > 5 ? "m'" . v:count : "") . 'j'
nnoremap <expr> k (v:count > 5 ? "m'" . v:count : "") . 'k'

" Move blocks of code
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Make . to work with visually selected lines
vnoremap . :normal.<CR>

" Run line as command, output here
noremap Q !!$SHELL<CR>

" Disable highlighting
nnoremap <silent> <Leader>, :nohlsearch<CR>

" Open $SHELL in splits
if has("nvim")
	noremap <silent> <Leader>t :vsplit term://$SHELL<CR>i
	noremap <silent> <Leader>T :split term://$SHELL<CR>i
else
	noremap <silent> <Leader>t :vertical terminal<CR>
	noremap <silent> <Leader>T :terminal<CR>
endif

" Escape terminal mode with <Esc> and send Esc to terminal with <C-v><Esc>
tnoremap <Esc> <C-\><C-n>
tnoremap <C-v><Esc> <Esc>

" Quickly edit/reload the vimrc file
nmap <silent> <Leader>e :e $MYVIMRC<CR>
nmap <silent> <Leader>E :so $MYVIMRC<CR>

" Shortcuts to use blackhole register
nnoremap <Leader><Leader>d "_d
vnoremap <Leader><Leader>d "_d
nnoremap <Leader><Leader>D "_D
vnoremap <Leader><Leader>D "_D
nnoremap <Leader><Leader>c "_c
vnoremap <Leader><Leader>c "_c
nnoremap <Leader><Leader>C "_C
vnoremap <Leader><Leader>C "_C
nnoremap <Leader><Leader>x "_x
vnoremap <Leader><Leader>x "_x
nnoremap <Leader><Leader>X "_X
vnoremap <Leader><Leader>X "_X

" Copy/Paste to/from the clipboard
nnoremap <Leader>y "+y
vnoremap <Leader>y "+y
nnoremap <Leader>Y "+y$
vnoremap <Leader>Y "+y$
nnoremap <Leader>d "+d
vnoremap <Leader>d "+d
nnoremap <Leader>D "+D
vnoremap <Leader>D "+D
nnoremap <Leader>p "+p
vnoremap <Leader>p "+p
nnoremap <Leader>P "+P
vnoremap <Leader>P "+P

" Copy the whole working file to the clipboard
nnoremap <Leader><Leader>y <Cmd>%yank+<CR>

" Output the current syntax group
nnoremap <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>
" }}}
