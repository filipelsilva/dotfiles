set nocompatible

" <leader> key bind
let mapleader = ","

call plug#begin()
Plug 'tpope/vim-fugitive'
Plug 'sheerun/vim-polyglot'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-gitgutter'
Plug 'itchyny/lightline.vim'
Plug 'scrooloose/nerdtree'
Plug 'mg979/vim-visual-multi'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-surround'
Plug 'w0rp/ale'
Plug 'tpope/vim-endwise'
Plug 'psliwka/vim-smoothie'
Plug 'mhinz/vim-startify'
Plug 'NLKNguyen/papercolor-theme'
Plug 'rhysd/open-pdf.vim'
Plug 'brooth/far.vim'
Plug 'roryokane/detectindent'
Plug 'joshdick/onedark.vim'
Plug 'sainnhe/gruvbox-material'
Plug 'lifepillar/vim-gruvbox8'
Plug 'shinchu/lightline-gruvbox.vim'
call plug#end()

" Detect Identation
augroup DetectIndent
   autocmd!
   autocmd BufReadPost *  DetectIndent
augroup END

" Make lightline work with vim-fugitive
let g:lightline = {
    \ 'colorscheme': 'gruvbox_material',
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ],
    \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
    \ },
    \ 'component_function': {
    \   'gitbranch': 'FugitiveHead'
    \ },
	\ }

" Lightline workaround
set laststatus=2
set noshowmode

" To copy with mouse without line numbers: Ctrl+CLICK

" NERDTree and Files
map <C-o> :NERDTreeToggle<CR>
nnoremap <C-p> :Files<CR>
let g:NERDTreeWinPos = "right" " NERDTree on the right
let NERDTreeMinimalUI = 1
"let NERDTreeShowHidden=1 " Show hidden files

" coc.nvim jump to definition
nmap <leader>gd <Plug>(coc-definition)
nmap <leader>gr <Plug>(coc-references)

" coc.nvim integration with tab
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

"" Force background
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

syntax on
"let g:onedark_terminal_italics = 1
"colorscheme onedark

set background=dark
let g:gruvbox_material_background = 'hard'

colorscheme gruvbox-material

" Transparency
"hi Normal guibg=NONE ctermbg=NONE 

" Tabs = 4 spaces
set tabstop=4
set softtabstop=0 noexpandtab
set shiftwidth=4
set shiftround
set smarttab

" Sidebar with numbers
set number
set relativenumber

" Useful stuff
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

" Lenght marker
set colorcolumn=80,100

" Easy window navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Quickly edit/reload the vimrc file
nmap <silent> <leader>ev :e ~/.vimrc<CR>
nmap <silent> <leader>sv :so ~/.vimrc<CR>
