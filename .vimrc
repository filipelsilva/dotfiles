call plug#begin()
Plug 'tpope/vim-fugitive'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-gitgutter'
Plug 'itchyny/lightline.vim'
Plug 'scrooloose/nerdtree'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-surround'
Plug 'w0rp/ale'
Plug 'jiangmiao/auto-pairs'
Plug 'vim-scripts/peaksea'
Plug 'ayu-theme/ayu-vim'
Plug 'psliwka/vim-smoothie'
Plug 'mhinz/vim-startify'
Plug 'NLKNguyen/papercolor-theme'
Plug 'rhysd/open-pdf.vim'
Plug 'brooth/far.vim'
call plug#end()

" Make lightline work with vim-fugitive
let g:lightline = {
    \ 'colorscheme': 'powerline',
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

" NERDTree and Files shortcuts
map <C-o> :NERDTreeToggle<CR>
nnoremap <C-p> :Files<CR>
let g:NERDTreeWinPos = "right" " NERDTree on the right

" Leader key map
let mapleader = ","

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

" Colorscheme
set t_Co=256
set background=dark
colorscheme PaperColor

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
nnoremap . :

" Quickly edit/reload the vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>
