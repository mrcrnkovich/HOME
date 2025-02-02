syntax on
set nocompatible
set path+=**
set number
set relativenumber
set encoding=utf-8
set completeopt=longest,noinsert,menuone,noselect

let mapleader = ","

set nowrap
set textwidth=80
set formatoptions=tcqrn1
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set noshiftround

set scrolloff=4
set backspace=indent,eol,start
set matchpairs+=<:> 

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
set hlsearch
set incsearch
set ignorecase
set smartcase
set incsearch
set showmatch

nnoremap <Leader>v :vsplit<CR>
nnoremap <Leader>- :split<CR>

nnoremap <Leader>q :copen<CR>
nnoremap [q :cnext<CR>
nnoremap ]q :cprevious<CR>
nnoremap [Q :cnewer<CR>
nnoremap ]Q :cprevious<CR>

nnoremap [b :bnext<CR>
nnoremap ]b :bprevious<CR>

nnoremap <Leader>r :reg<CR>
nnoremap <Leader>b :files<CR>:b
nnoremap <Leader>m :marks<CR>

map <Leader><space> :let @/=''<cr> " clear search

" inoremap jj <ESC>
nmap <Leader>t :Vexplore<CR>
nmap <Leader>f :FZF<CR>
nmap <Leader>s :grep 

filetype plugin indent on
set omnifunc=syntaxcomplete#Complete

" Visualize tabs and newlines
" Use your leader key + l to toggle on/off
set listchars=tab:▸\ ,eol:¬
map <leader>l :set list!<CR> " Toggle tabs and EOL

" Default GUI Colours
let s:foreground = "#cccccc"
let s:background = "#2d2d2d"
let s:selection = "#515151"
let s:line = "#393939"
let s:comment = "#999999"
let s:red = "#f2777a"
let s:orange = "#f99157"
let s:yellow = "#ffcc66"
let s:green = "#99cc99"
let s:aqua = "#66cccc"
let s:blue = "#6699cc"
let s:purple = "#cc99cc"
let s:window = "#4d5057"

hi clear
syntax reset

let g:colors_name = "Tomorrow-Night-Eighties"

    " Sets the highlighting for the given group
fun <SID>X(group, fg, bg, attr)
    if a:fg != ""
        exec "hi " . a:group . " guifg=" . a:fg
    endif
    if a:bg != ""
        exec "hi " . a:group . " guibg=" . a:bg
    endif
    if a:attr != ""
        exec "hi " . a:group . " gui=" . a:attr
    endif
endfun

" Vim Highlighting
call <SID>X("Normal", s:foreground, s:background, "")
call <SID>X("LineNr", s:selection, "", "")
call <SID>X("NonText", s:selection, "", "")
call <SID>X("SpecialKey", s:selection, "", "")
call <SID>X("Search", s:background, s:yellow, "")
call <SID>X("TabLine", s:window, s:foreground, "reverse")
call <SID>X("TabLineFill", s:window, s:foreground, "reverse")
call <SID>X("StatusLine", s:window, s:yellow, "reverse")
call <SID>X("StatusLineNC", s:window, s:foreground, "reverse")
call <SID>X("VertSplit", s:window, s:window, "none")
call <SID>X("Visual", "", s:selection, "")
call <SID>X("Directory", s:blue, "", "")
call <SID>X("ModeMsg", s:green, "", "")
call <SID>X("MoreMsg", s:green, "", "")
call <SID>X("Question", s:green, "", "")
call <SID>X("WarningMsg", s:red, "", "")
call <SID>X("MatchParen", "", s:selection, "")
call <SID>X("Folded", s:comment, s:background, "")
call <SID>X("FoldColumn", "", s:background, "")
call <SID>X("CursorLine", "", s:line, "none")
call <SID>X("CursorColumn", "", s:line, "none")
call <SID>X("PMenu", s:foreground, s:selection, "none")
call <SID>X("PMenuSel", s:foreground, s:selection, "reverse")
call <SID>X("SignColumn", "", s:background, "none")
call <SID>X("ColorColumn", "", s:line, "none")
call <SID>X("vimCommand", s:red, "", "none")

" Standard Highlighting
"	call <SID>X("Comment", s:comment, "", "")
call <SID>X("Todo", s:comment, s:background, "")
call <SID>X("Title", s:comment, "", "")
call <SID>X("Identifier", s:red, "", "none")
call <SID>X("Statement", s:foreground, "", "")
call <SID>X("Conditional", s:foreground, "", "")
call <SID>X("Repeat", s:foreground, "", "")
call <SID>X("Structure", s:purple, "", "")
call <SID>X("Function", s:blue, "", "")
call <SID>X("Constant", s:orange, "", "")
call <SID>X("Keyword", s:orange, "", "")
call <SID>X("String", s:green, "", "")
call <SID>X("Special", s:foreground, "", "")
call <SID>X("PreProc", s:purple, "", "")
call <SID>X("Operator", s:aqua, "", "none")
call <SID>X("Type", s:blue, "", "none")
call <SID>X("Define", s:purple, "", "none")
call <SID>X("Include", s:blue, "", "")

" C Highlighting
call <SID>X("cType", s:yellow, "", "")
call <SID>X("cStorageClass", s:purple, "", "")
call <SID>X("cConditional", s:purple, "", "")
call <SID>X("cRepeat", s:purple, "", "")

" Lua Highlighting
call <SID>X("luaStatement", s:purple, "", "")
call <SID>X("luaRepeat", s:purple, "", "")
call <SID>X("luaCondStart", s:purple, "", "")
call <SID>X("luaCondElseif", s:purple, "", "")
call <SID>X("luaCond", s:purple, "", "")
call <SID>X("luaCondEnd", s:purple, "", "")

" Go Highlighting
call <SID>X("goDirective", s:purple, "", "")
call <SID>X("goDeclaration", s:purple, "", "")
call <SID>X("goStatement", s:purple, "", "")
call <SID>X("goConditional", s:purple, "", "")
call <SID>X("goConstants", s:orange, "", "")
call <SID>X("goTodo", s:yellow, "", "")
call <SID>X("goDeclType", s:blue, "", "")
call <SID>X("goBuiltins", s:purple, "", "")
call <SID>X("goRepeat", s:purple, "", "")
call <SID>X("goLabel", s:purple, "", "")

delf <SID>X
set background=light
