call plug#begin(stdpath('data') . '/plugged')
Plug 'dylanaraps/wal.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-surround'

Plug 'rust-lang/rust.vim'
call plug#end()

colorscheme wal

let mapleader = ","

set mouse=a
set showcmd
set number relativenumber
set hidden
set nowrap
set undofile
set timeoutlen=300

set ignorecase
set smartcase

" restore cursor position
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" delete all trailing whitespaces on save
autocmd BufWritePre * %s/\s\+$//e

autocmd BufRead *.rs :setlocal tags=./rusty-tags.vi;/

autocmd FileType c nnoremap <Leader>i ggdG:r ~/.local/share/file_templates/cf_template.c<cr>ggdd5Ga
autocmd FileType cpp nnoremap <Leader>i ggdG:r ~/.local/share/file_templates/cf_template.cpp<cr>ggdd10Ga

autocmd FileType c nnoremap <Leader>c :terminal gcc -Og -g -Wall -Wextra "%" -lm && ./a.out<cr>
autocmd FileType cpp nnoremap <Leader>c :terminal g++ -Og -g -Wall -Wextra "%" -lm && ./a.out<cr>
autocmd FileType c,cpp nnoremap <Leader>r :terminal ./a.out<cr>
autocmd FileType c,cpp set colorcolumn=80
autocmd FileType rust set colorcolumn=100

map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

nnoremap <Leader>m :make<cr>
map <Leader>n :cn<cr>
map <Leader>p :cp<cr>

nnoremap <silent> <cr> :noh<cr><cr>

" toggle paste mode
nnoremap <F2> :set paste! nopaste?<cr>

inoremap <C-space> <C-n>

nnoremap <C-f> :FZF<cr>

map <C-p> :bp<cr>
map <C-n> :bn<cr>
map <C-b> :b#<cr>
