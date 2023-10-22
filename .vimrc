syntax on
set nocompatible
set path+=**
set number
set relativenumber
set encoding=utf-8
set completeopt=longest,noinsert,menuone,noselect

let mapleader = ","

set modelines=0
set noerrorbells
set vb t_vb=
set hidden
set nowrap
set textwidth=80
set formatoptions=tcqrn1
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set noshiftround

" Cursor motion
set scrolloff=3
set backspace=indent,eol,start
set matchpairs+=<:> 

" Move up/down editor lines
nnoremap j gj
nnoremap k gk

" Quick window switching
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l
nmap <C-x> <C-w>x

set ttyfast
set nobackup
set noswapfile
set undodir=~/.vim/undodir
set undofile

" Status bar
set laststatus=2

" Last line
set showmode
set showcmd

" Searching
nnoremap / /\v
vnoremap / /\v
set hlsearch
set incsearch
set ignorecase
set smartcase
set incsearch
set showmatch

nnoremap <Leader>q :copen<CR>
nnoremap <Leader>r :reg<CR>
nnoremap <Leader>b :files<CR>:b
nnoremap <Leader>m :marks<CR>
map <leader><space> :let @/=''<cr> " clear search
inoremap jj <ESC>
" nmap <leader>t :Vexplore<CR>
" nmap <leader>f :Files<CR>
" nmap <leader>g :GFiles<CR>
nnoremap <Leader>s :Rg<CR>
filetype plugin indent on
set omnifunc=syntaxcomplete#Complete

" Visualize tabs and newlines
" Use your leader key + l to toggle on/off
set listchars=tab:▸\ ,eol:¬
map <leader>l :set list!<CR> " Toggle tabs and EOL
