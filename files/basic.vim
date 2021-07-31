" Settings {{{
syntax on
filetype plugin indent on
set omnifunc=syntaxcomplete#Complete
set nomodeline hidden nocompatible encoding=utf-8 fileformats=unix,dos,mac
set mouse=a scrolloff=5 updatetime=100 ttimeoutlen=0 shortmess=filmnrwxaoOtT
if !has("nvim") | set ttymouse=xterm2 | endif

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

" Indentation settings
set autoindent copyindent shiftround smarttab
set noexpandtab tabstop=4 softtabstop=4 shiftwidth=4

" Visual settings
set ruler showcmd linebreak laststatus=0 showtabline=0
set fillchars+=vert:│ colorcolumn=80 hlsearch
set number relativenumber cursorline

" Spell settings
set spelllang=en,pt
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

" Tab completion {{{
function! TabComplete()
	let line = getline('.')
	let substr = strpart(line, -1, col('.'))
	let substr = matchstr(substr, "[^ \t]*$")
	if (strlen(substr)==0)
		return "\<tab>"
	endif
	let has_period = match(substr, '\.') != -1
	let has_slash = match(substr, '\/') != -1
	if (!has_period && !has_slash)
		" Matching text
		return "\<c-x>\<c-p>"
	elseif ( has_slash )
		" Matching files
		return "\<c-x>\<c-f>"
	else
		" Omnicomplete
		return "\<c-x>\<c-o>"
	endif
endfunction
" }}}

" }}}

" Keymaps {{{

" <leader> key bind
let mapleader = "\<space>"

" Easier completion menus
inoremap <expr> <tab>   pumvisible() ? "\<c-n>" : "\<tab>"
inoremap <expr> <s-tab> pumvisible() ? "\<c-p>" : "\<s-tab>"

" Toggle numbers and cursorline
nnoremap <silent> <leader>n :set invnumber invrelativenumber invcursorline<cr>

" Toggle spell
nnoremap <silent> <leader>o :set invspell<cr>

" Buffer jumping
nnoremap <silent> gb :bnext<cr>
nnoremap <silent> gB :bprev<cr>

" Buffer jumping part 2: jump to last edited buffer
nnoremap <c-k> <c-^>
inoremap <c-k> <esc><c-^>

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
nnoremap <expr> k (v:count > 5 ? "m'" . v:count : "") . 'k'
nnoremap <expr> j (v:count > 5 ? "m'" . v:count : "") . 'j'

" Easier paste from register in Insert mode
inoremap <c-v> <c-r><c-p>0

" Move blocks of code
vnoremap K :m '<-2<cr>gv=gv
vnoremap J :m '>+1<cr>gv=gv

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

" Copy/Paste to other programs
nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>d "+d
vnoremap <leader>d "+d
nnoremap <leader>p "+p
vnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>P "+P

" Copy the whole working file
nnoremap <leader>Y gg"+yG

" Output the current syntax group
nnoremap <f10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<cr>
" }}}

" Colorscheme {{{
colorscheme default
set t_Co=256
set background=dark
" }}}
