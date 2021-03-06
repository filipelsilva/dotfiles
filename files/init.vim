" <leader> key bind
let mapleader = ","

" Plugins {{{
call plug#begin()
if has('nvim-0.5.0')
	Plug 'hoob3rt/lualine.nvim' " Status line
	Plug 'mkitt/tabline.vim'
else
	Plug 'itchyny/lightline.vim' " Status line
	Plug 'shinchu/lightline-gruvbox.vim' " Lightline theme
endif
Plug 'sheerun/vim-polyglot' " Language packs
Plug 'lifepillar/vim-mucomplete' " Completion
Plug 'pechorin/any-jump.vim' " Code inspections/references
Plug 'airblade/vim-gitgutter' " Show git differences
Plug 'preservim/tagbar' " Class outline viewer
Plug 'preservim/nerdcommenter' " Do comments
Plug 'tpope/vim-fugitive' " Git wrapper
Plug 'tpope/vim-eunuch' " UNIX commands in vim
Plug 'tpope/vim-surround' " Do surroundings
Plug 'tpope/vim-abolish' " Change word structures
Plug 'mg979/vim-visual-multi' " Multiple cursors
Plug 'w0rp/ale' " Linter
Plug 'psliwka/vim-smoothie' " Smooth scrolling
Plug 'kassio/neoterm' " Terminal shortcuts
Plug 'mhinz/vim-startify' " Start menu for vim
Plug 'brooth/far.vim' " Find and Replace
Plug 'roryokane/detectindent' " Detect default identation
Plug 'jiangmiao/auto-pairs' " Close brackets
Plug 'mbbill/undotree' " Undo menu
Plug 'easymotion/vim-easymotion' " Easier movement on vim
Plug 'junegunn/vim-easy-align' " Align by columns
" Fuzzy finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" File explorer
Plug 'preservim/nerdtree' "NERDtree
Plug 'tiagofumo/vim-nerdtree-syntax-highlight' " Syntax highlighting
" Themes
Plug 'chriskempson/base16-vim'
"Plug 'NLKNguyen/papercolor-theme'
"Plug 'sainnhe/gruvbox-material'
call plug#end()
" }}}

" Colors/Themes {{{

" Transparent background
"hi Normal guibg=NONE ctermbg=NONE 

" Force background
"autocmd ColorScheme * highlight Normal ctermbg=NONE guibg=NONE

" Colorscheme
set t_Co=256
highlight Comment cterm=italic gui=italic

if (has("nvim"))
	let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

if (has("termguicolors"))
	set termguicolors
endif

set background=dark

"let g:gruvbox_material_background = 'hard'
"colorscheme gruvbox-material
colorscheme base16-gruvbox-dark-pale
" }}}

" Settings {{{
"set guicursor=
set nocompatible
set nomodeline
set foldenable
set foldmethod=marker
set hidden
"set nowrap
set autoindent
set copyindent
"set showmatch
set ignorecase
set smartcase
set hlsearch
set incsearch
set pastetoggle=<F2>
nmap <silent> ,/ :nohlsearch<CR>
cmap w!! w !sudo tee % >/dev/null
nnoremap « :
set splitbelow
set splitright
set showtabline=1
set mouse=a
set colorcolumn=80,100 " Lenght marker
filetype plugin indent on
syntax on
set wildmode=longest:full,full
set wildmenu
"set scrolloff=5
set ruler
set showcmd

" Quickly edit/reload the vimrc file
nmap <silent> <leader>ev :e ~/.config/nvim/init.vim<CR>
nmap <silent> <leader>sv :so ~/.config/nvim/init.vim<CR>

" Undo across exits
set undodir=/home/$USER/.vim-undo
set undofile
set undolevels=10000

" Tabs = 4 spaces
set tabstop=4
set softtabstop=4 noexpandtab
set shiftwidth=4
set shiftround
set smarttab

" Sidebar with numbers
set number
set relativenumber

" Lightline workaround
set laststatus=2
set noshowmode
" }}}

" Keymaps {{{

" Easy window navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Go to tab by number
noremap <leader>1 1gt
noremap <leader>2 2gt
noremap <leader>3 3gt
noremap <leader>4 4gt
noremap <leader>5 5gt
noremap <leader>6 6gt
noremap <leader>7 7gt
noremap <leader>8 8gt
noremap <leader>9 9gt
noremap <leader>0 :tablast<cr>

" Shortcut to use blackhole register by default
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

" move vertically by visual line with j and k
nnoremap j gj
nnoremap k gk
" }}}

" Plugin Configurations {{{

" MuComplete
set completeopt+=menuone
"let g:mucomplete#enable_auto_at_startup = 1

"" Detect Identation
"augroup DetectIndent
"   autocmd!
"   autocmd BufReadPost *  DetectIndent
"augroup END

" Lualine
let g:lualine = {
	\'options' : {
	\  'theme' : 'gruvbox_material',
	\  'section_separators' : ['', ''],
	\  'component_separators' : ['', ''],
	\  'icons_enabled' : v:false,
	\},
	\'sections' : {
	\  'lualine_a' : [ ['mode', {'upper': v:true,},], ],
	\  'lualine_b' : [ ['filename', {'file_status': v:false,},], ],
	\  'lualine_c' : [ ['branch'], ],
	\  'lualine_x' : [ 'encoding', 'fileformat', 'filetype' ],
	\  'lualine_y' : [ 'progress' ],
	\  'lualine_z' : [ 'location' ],
	\},
	\'inactive_sections' : {
	\  'lualine_a' : [  ],
	\  'lualine_b' : [  ],
	\  'lualine_c' : [ 'filename' ],
	\  'lualine_x' : [ 'location' ],
	\  'lualine_y' : [  ],
	\  'lualine_z' : [  ],
	\},
	\'extensions' : [ 'fzf' ],
	\}
lua require("lualine").status()

" Make lightline work with vim-fugitive
let g:lightline = {
		\ 'colorscheme': 'gruvbox',
	\ 'active': {
	\   'left': [ [ 'mode', 'paste' ],
	\             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ],
	\   'right': [ [ 'lineinfo' ], [ 'percent' ],
	\             [ 'binary', 'fileformat', 'fileencoding', 'filetype' ] ]
	\ },
	\ 'component_function': {
	\   'gitbranch': 'FugitiveHead'
	\ },
	\ }

"" NERDTree
map <C-o> :NERDTreeToggle<CR>
let g:NERDTreeWinPos = "right" " NERDTree on the right
let NERDTreeMinimalUI = 1
"let NERDTreeShowHidden = 1 " Show hidden files
let g:NERDTreeStatusline = ""
" Close window if NERDTree is the last one
autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let g:NERDTreeHighlightFolders = 1
let g:NERDTreeHighlightFoldersFullName = 1

" Fzf
nnoremap <C-p> :Files<CR>
let g:fzf_action = {
	\'ctrl-t': 'tab split',
	\ 'ctrl-s': 'split',
	\ 'ctrl-v': 'vsplit'
	\}

" Undo Tree
nnoremap <F5> :UndotreeToggle<CR>

"" Vim-Easy-Align
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

"" Tagbar
" Focus the panel when opening it
let g:tagbar_autofocus = 1
" Highlight the active tag
let g:tagbar_autoshowtag = 1
" Make panel vertical and place on the right
let g:tagbar_position = 'botright vertical'
" Mapping to open and close the panel
nmap <F8> :TagbarToggle<CR>

" }}}
