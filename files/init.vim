" Settings {{{
syntax on
filetype plugin indent on
if !has("nvim") | set ttymouse=xterm2 | endif
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

" Undo settings
set undofile undolevels=10000
if has("nvim")
	set undodir=$HOME/.nvim-undo
else
	set undodir=$HOME/.vim-undo
endif

" Indentation settings
set autoindent copyindent shiftround smarttab
set noexpandtab tabstop=4 softtabstop=4 shiftwidth=4

" Visual settings
set ruler showcmd fillchars+=vert:│ colorcolumn=80 laststatus=0 showtabline=0

" Grep function
set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
set grepformat=%f:%l:%c:%m,%f:%l:%m
" }}}

" Functions {{{

" Tab completion {{{
function! TabComplete()
	if (pumvisible())
		return "\<C-n>"
	endif
	let line = getline('.')
	let substr = strpart(line, -1, col('.'))
	let substr = matchstr(substr, "[^ \t]*$")
	if (strlen(substr)==0)
		return "\<tab>"
	endif
	let has_slash = match(substr, '\/') != -1
	if (!has_slash)
		" Matching text
		return "\<C-x>\<C-p>"
	else
		" Matching files
		return "\<C-x>\<C-f>"
	endif
endfunction
" }}}

" TrimWhitespace {{{
function! TrimWhitespace()
	let l:save = winsaveview()
	keeppatterns %s/\s\+$//e
	call winrestview(l:save)
endfunction

command! TrimWhitespace call TrimWhitespace()
" }}}

" FzfFilesWrapper {{{
function! FzfFilesWrapper()
	if (exists(":Files"))
		if (system("git rev-parse --is-inside-work-tree") =~ "true")
			GFiles
		else
			Files
		endif
	else
		Explore
	endif
endfunction

command! FzfFilesWrapper call FzfFilesWrapper()
" }}}
" }}}

" Keymaps {{{

"<leader> key bind
let mapleader = " "

" Tab completion
inoremap <tab> <c-r>=TabComplete()<cr>

" Toggle numbers
nnoremap <silent> <leader>n :set invnumber invrelativenumber<cr>

" Buffer jumping
nnoremap <silent> gb :bn<cr>
nnoremap <silent> gB :bp<cr>

" Replace word under cursor (',': wherever | ';': word only)
nnoremap <leader>s :%s/<c-r><c-w>//g<left><left>
vnoremap <leader>s "zy<esc>:%s/<c-r>z//g<left><left>
nnoremap <leader>S :%s/\<<c-r><c-w>\>//g<left><left>
vnoremap <leader>S "zy<esc>:%s/\<<c-r>z\>//g<left><left>

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

" Copy to other programs
nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>Y gg"+yG

" esc in terminal or in Fzf windows
tnoremap <expr> <esc> (&filetype == "fzf") ? "<esc>" : "<c-\><c-n>"

" Fzf
nnoremap <silent> <leader>f <cmd>FzfFilesWrapper<cr>
nnoremap <silent> <leader>r <cmd>Rg<cr>
nnoremap <silent> <leader>j <cmd>Buffers<cr>

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

	call minpac#add('timakro/vim-yadi')		" Indentation detector
	call minpac#add('junegunn/fzf.vim')		" Fuzzy finder
endfunction

command! PackUpdate source $MYVIMRC | call PackInit() | call minpac#update()
command! PackClean  source $MYVIMRC | call PackInit() | call minpac#clean()

" DetectIndent
autocmd BufRead * DetectIndent

" Fzf
set runtimepath+=$HOME/.fzf
let g:fzf_action = {'ctrl-t':'tab split', 'ctrl-s':'split', 'ctrl-v':'vsplit'}
let g:fzf_layout = {'window': {'width': 0.9, 'height': 0.7}}
let g:fzf_preview_window = []
" }}}
