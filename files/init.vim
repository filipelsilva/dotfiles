" <leader> key bind
let mapleader = ","

" Plugins {{{
call plug#begin()
Plug 'sheerun/vim-polyglot' " Language packs
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' } " Completion
Plug 'pechorin/any-jump.vim' " Code inspections/references
Plug 'airblade/vim-gitgutter' " Show git differences
Plug 'itchyny/lightline.vim' " Tabline
"Plug 'hoob3rt/lualine.nvim' " Tabline (TRY ON NEOVIM 0.5.0)
Plug 'preservim/tagbar' " Class outline viewer
Plug 'preservim/nerdcommenter' " Do comments
Plug 'tpope/vim-fugitive' " Git wrapper
Plug 'tpope/vim-eunuch' " UNIX commands in vim
Plug 'tpope/vim-surround' " Do surroundings
Plug 'tpope/vim-abolish' " Change word structures
Plug 'tpope/vim-endwise' " End structures
Plug 'mg979/vim-visual-multi' " Multiple cursors
Plug 'w0rp/ale' " Linter
Plug 'psliwka/vim-smoothie' " Smooth scrolling
Plug 'kassio/neoterm' " Terminal shortcuts
Plug 'mhinz/vim-startify' " Start menu for vim
Plug 'brooth/far.vim' " Find and Replace
Plug 'roryokane/detectindent' " Detect default identation
Plug 'rstacruz/vim-closer' " Close brackets (pair with vim-endwise)
Plug 'mbbill/undotree' " Undo menu
Plug 'godlygeek/tabular' " Format columns
Plug 'dyng/ctrlsf.vim' "Async finder
" Fuzzy finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" NERDTree
Plug 'preservim/nerdtree' "File explorer
Plug 'tiagofumo/vim-nerdtree-syntax-highlight' " Syntax highlighting
" Themes
Plug 'chriskempson/base16-vim'
Plug 'shinchu/lightline-gruvbox.vim'
"Plug 'NLKNguyen/papercolor-theme'
"Plug 'sainnhe/gruvbox-material'
"Plug 'shinchu/lightline-gruvbox.vim'
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
set nocompatible
set nomodeline
set foldenable
set foldmethod=marker
set hidden
set nowrap
set autoindent
set copyindent
set showmatch
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
set scrolloff=5
set ruler
set showcmd

" Quickly edit/reload the vimrc file
nmap <silent> <leader>ev :e ~/.config/nvim/init.vim<CR>
nmap <silent> <leader>sv :so ~/.config/nvim/init.vim<CR>

" Undo across exits
set undodir=~/.vim-undo
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

" Detect Identation
augroup DetectIndent
   autocmd!
   autocmd BufReadPost *  DetectIndent
augroup END

" Make lightline work with vim-fugitive
let g:lightline = {
    \ 'colorscheme': 'gruvbox',
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ],
    \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
    \ },
    \ 'component_function': {
    \   'gitbranch': 'FugitiveHead'
    \ },
	\ }

" Lualine
"lua << EOF
"local lualine = require('lualine')
"lualine.status()
"lualine.theme = 'gruvbox'
"EOF

"" NERDTree
map <C-o> :NERDTreeToggle<CR>
let g:NERDTreeWinPos = "right" " NERDTree on the right
let NERDTreeMinimalUI = 1
let NERDTreeShowHidden = 1 " Show hidden files
let g:NERDTreeStatusline = ""
" Close window if NERDTree is the last one
autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let g:NERDTreeHighlightFolders = 1
let g:NERDTreeHighlightFoldersFullName = 1

" Fzf
nnoremap <C-p> :Files<CR>
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit'
  \}
nnoremap <C-p> :Files<CR>

" CtrlSF
nmap     <C-F>f <Plug>CtrlSFPrompt
vmap     <C-F>f <Plug>CtrlSFVwordPath
vmap     <C-F>F <Plug>CtrlSFVwordExec
nmap     <C-F>n <Plug>CtrlSFCwordPath
nmap     <C-F>p <Plug>CtrlSFPwordPath
nnoremap <C-F>o :CtrlSFOpen<CR>
nnoremap <C-F>t :CtrlSFToggle<CR>
inoremap <C-F>t <Esc>:CtrlSFToggle<CR>

" Gundo.vim
nnoremap <F5> :UndotreeToggle<CR>

"" Tagbar
" Focus the panel when opening it
let g:tagbar_autofocus = 1
" Highlight the active tag
let g:tagbar_autoshowtag = 1
" Make panel vertical and place on the right
let g:tagbar_position = 'botright vertical'
" Mapping to open and close the panel
nmap <F8> :TagbarToggle<CR>

" Tab complete
let g:deoplete#enable_at_startup = 1

call deoplete#custom#option({
   \ 'auto_complete_popup': 'manual',
   \ })
inoremap <silent><expr> <TAB>
   \ pumvisible() ? "\<C-n>" :
   \ <SID>check_back_space() ? "\<Tab>" :
   \ deoplete#complete()
function! s:check_back_space() abort
let col = col('.') - 1
return !col || getline('.')[col - 1]  =~# '\s'
endfunction
" }}}
