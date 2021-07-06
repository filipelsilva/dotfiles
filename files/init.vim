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

" Tab completion {{{
function! TabComplete(shift)
	if (pumvisible())
		if (a:shift == 1)
			return "\<C-p>"
		else
			return "\<C-n>"
		endif
	endif
	let line = getline('.')
	let substr = strpart(line, -1, col('.'))
	let substr = matchstr(substr, "[^ \t]*$")
	if (strlen(substr) == 0)
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
let mapleader = "\<space>"

" Tab completion
inoremap <tab> <c-r>=TabComplete(0)<cr>
inoremap <s-tab> <c-r>=TabComplete(1)<cr>

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

" Esc in terminal or in Fzf windows
tnoremap <expr> <esc> (&filetype == "fzf") ? "<esc>" : "<c-\><c-n>"

" Fzf
nnoremap <silent> <leader>f <cmd>FzfFilesWrapper<cr>
nnoremap <silent> <leader>r <cmd>Rg<cr>
nnoremap <silent> <leader>j <cmd>Buffers<cr>
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
