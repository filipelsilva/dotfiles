" Plugins {{{
call plug#begin()
if has('nvim-0.5.0')
	Plug 'hoob3rt/lualine.nvim' " Status line
	Plug 'webdevel/tabulous' " Tabline (for now, is needed)
	Plug 'nvim-treesitter/nvim-treesitter' " Language packs
else
	Plug 'itchyny/lightline.vim' " Status line
	Plug 'shinchu/lightline-gruvbox.vim' " Lightline theme
	Plug 'sheerun/vim-polyglot' " Language packs
endif
Plug 'dense-analysis/ale' " While no better alternative arrives, linter
Plug 'lifepillar/vim-mucomplete' " Completion
Plug 'mhinz/vim-signify' " Show repo differences
Plug 'tpope/vim-fugitive' " Git wrapper
Plug 'tpope/vim-surround' " Do surroundings
Plug 'tpope/vim-commentary' " Comment stuff
Plug 'tpope/vim-abolish' " Change word structures
Plug 'mg979/vim-visual-multi' " Multiple cursors
Plug 'psliwka/vim-smoothie' " Smooth scrolling
Plug 'mhinz/vim-startify' " Start menu for vim
Plug 'roryokane/detectindent' " Detect default identation
Plug 'jiangmiao/auto-pairs' " Close brackets
Plug 'easymotion/vim-easymotion' " Easier movement on vim
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim' " Fuzzy finder
Plug 'preservim/nerdtree' " NERDtree
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
let mapleader = " " "<leader> key bind
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
set signcolumn=number
set number
set relativenumber
set laststatus=2
set noshowmode
set undodir=/home/$USER/.vim-undo
set undofile
set undolevels=10000
set tabstop=4
set softtabstop=4 noexpandtab
set shiftwidth=4
set shiftround
set smarttab
set nowrap
" }}}

" Keymaps {{{

" Quickly edit/reload the vimrc file
nmap <silent> <leader>ev :e ~/.config/nvim/init.vim<CR>
nmap <silent> <leader>sv :so ~/.config/nvim/init.vim<CR>

" Move vertically by visual line with j and k
nnoremap j gj
nnoremap k gk

" Terminal shortcuts
nnoremap <leader>t <cmd>terminal<cr>
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
fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

augroup stopwhitespace
	autocmd!
	autocmd BufWritePre * :call TrimWhitespace()
augroup END
" }}}

" Plugin Configurations {{{

" MuComplete
set completeopt=menuone,noinsert,noselect
"let g:mucomplete#enable_auto_at_startup = 1

" Tabulous
let tabulousCloseStr = ''
let tabulousLabelNameOptions = ':.'

" DetectIndent
"augroup DetectIndent
"   autocmd!
"   autocmd BufReadPost * DetectIndent
"augroup END

" Fzf {{{
let g:fzf_action = { 'ctrl-t':'tab split', 'ctrl-s':'split', 'ctrl-v':'vsplit' }
let g:fzf_layout = { 'right': '40%' }
let g:fzf_preview_window = ['up:50%']
nnoremap <silent> <leader>ff <cmd>Files<cr>
nnoremap <silent> <leader>fg <cmd>Rg<cr>
nnoremap <silent> <leader>fb <cmd>Buffers<cr>
nnoremap <silent> <leader>fh <cmd>Helptags<cr>
nnoremap <silent> <leader>fc <cmd>Commits<cr>
nnoremap <silent> <leader>ft <cmd>BTags<cr>
" No numbers in Fzf
augroup FzfNoNumbers
    autocmd!
    autocmd FileType fzf exe 'setlocal nonumber norelativenumber'
augroup END
" }}}

" Signify
set updatetime=100
nmap <leader>sn <plug>(signify-next-hunk)
nmap <leader>sp <plug>(signify-prev-hunk)

" Statuslines
if has('nvim-0.5.0')
	" Lualine {{{
	let g:lualine = {
				\'options' : {
				\  'theme' : 'gruvbox_material',
				\  'section_separators' : ['', ''],
				\  'component_separators' : ['', ''],
				\  'icons_enabled' : v:false,
				\},
				\'sections' : {
				\  'lualine_a' : [ ['mode', {'upper': v:true,},], ],
				\  'lualine_b' : [ ['filename', {'file_status': v:false,},], 'diff' ],
				\  'lualine_c' : [ 'branch' ],
				\  'lualine_x' : [ 'encoding', 'fileformat', 'filetype' ],
				\  'lualine_y' : [ 'progress' ],
				\  'lualine_z' : [ 'location' ],
				\},
				\'extensions' : [ 'fzf' ],
				\}
	" }}}
	lua require("lualine").status()
else
	" Lightline {{{
	let g:lightline = {
				\ 'colorscheme': 'gruvbox',
				\ 'active': {
				\   'left': [ [ 'mode', 'paste' ],
				\             [ 'filename', 'gitbranch', 'readonly', 'modified' ] ],
				\   'right': [ [ 'lineinfo' ], [ 'percent' ],
				\             [ 'binary', 'fileformat', 'fileencoding', 'filetype' ] ]
				\ },
				\ 'component_function': {
				\   'gitbranch': 'FugitiveHead',
				\ },
				\ }
	" }}}
endif

" NERDTree {{{
map <C-o> :NERDTreeToggle<CR>
let g:NERDTreeWinPos = "right" " NERDTree on the right
let NERDTreeMinimalUI = 1
"let NERDTreeShowHidden = 1 " Show hidden files
let g:NERDTreeStatusline = ""
" Close window if NERDTree is the last one
autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let g:NERDTreeHighlightFolders = 1
let g:NERDTreeHighlightFoldersFullName = 1
" }}}

" Treesitter {{{
if has('nvim-0.5.0')
lua << EOF
require'nvim-treesitter.configs'.setup {
	ensure_installed = "maintained", -- one of "all", "maintained" or a list of languages
	highlight = {
		enable = true,              -- false will disable the whole extension
		-- disable = { "c", "rust" },  -- list of language that will be disabled
	},
}
EOF
endif
" }}}
" }}}
