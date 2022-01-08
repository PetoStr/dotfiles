call plug#begin(stdpath('data') . '/plugged')
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-surround'

" https://sharksforarms.dev/posts/neovim-rust/
" Collection of common configurations for the Nvim LSP client
Plug 'neovim/nvim-lspconfig'
" Extensions to built-in LSP, for example, providing type inlay hints
Plug 'nvim-lua/lsp_extensions.nvim'
" Autocompletion framework for built-in LSP
Plug 'nvim-lua/completion-nvim'

" https://github.com/simrat39/rust-tools.nvim#installation
Plug 'simrat39/rust-tools.nvim'
" Optional dependencies
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
" Debugging (needs plenary from above as well)
Plug 'mfussenegger/nvim-dap'

Plug 'rust-lang/rust.vim'
call plug#end()

let mapleader = ","

set background=dark
set clipboard=unnamedplus
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

autocmd FileType c nnoremap <Leader>i ggdG:r ~/.local/share/file_templates/cf_template.c<cr>ggdd5Ga
autocmd FileType cpp nnoremap <Leader>i ggdG:r ~/.local/share/file_templates/cf_template.cpp<cr>ggdd10Ga

autocmd FileType c nnoremap <Leader>c :terminal gcc -Og -g -Wall -Wextra "%" -lm && ./a.out<cr>
autocmd FileType cpp nnoremap <Leader>c :terminal g++ -Og -g -Wall -Wextra "%" -lm && ./a.out<cr>
autocmd FileType c,cpp nnoremap <Leader>r :terminal ./a.out<cr>
autocmd FileType c,cpp set colorcolumn=80
autocmd FileType rust set colorcolumn=100

" disable automatic comment insertion
autocmd BufEnter * set fo-=c fo-=r fo-=o

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

nnoremap <Leader>f :FZF<cr>

map <C-p> :bp<cr>
map <C-n> :bn<cr>
map <leader>b :b#<cr>

" Set completeopt to have a better completion experience
" :help completeopt
" menuone: popup even when there's only one match
" noinsert: Do not insert text until a selection is made
" noselect: Do not select, force user to select one from the menu
set completeopt=menuone,noinsert,noselect

" Avoid showing extra messages when using completion
set shortmess+=c

inoremap <expr> <C-space>  pumvisible() ? "\<C-n>" : "\<C-space>"
inoremap <expr> <CS-space> pumvisible() ? "\<C-p>" : "\<CS-space>"

imap <C-space> <Plug>(completion_smart_tab)
imap <CS-space> <Plug>(completion_smart_s_tab)

autocmd FileType rust nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
autocmd FileType rust nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
autocmd FileType rust nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
autocmd FileType rust nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
autocmd FileType rust nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
autocmd FileType rust nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
autocmd FileType rust nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
autocmd FileType rust nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
autocmd FileType rust nnoremap <silent> gd    <cmd>lua vim.lsp.buf.declaration()<CR>
autocmd FileType rust nnoremap <silent> ga    <cmd>lua vim.lsp.buf.code_action()<CR>

" Set updatetime for CursorHold
" 300ms of no cursor movement to trigger CursorHold
set updatetime=300
" Show diagnostic popup on cursor hold
autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics()

" Goto previous/next diagnostic warning/error
nnoremap <silent> g[ <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap <silent> g] <cmd>lua vim.lsp.diagnostic.goto_next()<CR>

" have a fixed column for the diagnostics to appear in
" this removes the jitter when warnings/errors flow in
set signcolumn=yes

" Enable type inlay hints
autocmd CursorMoved,InsertLeave,BufEnter,BufWinEnter,TabEnter,BufWritePost *
 \ lua require'lsp_extensions'.inlay_hints{ prefix = '', highlight = "Comment", enabled = {"TypeHint", "ChainingHint", "ParameterHint"} }

highlight SignColumn ctermbg=black

lua << EOF
-- nvim_lsp object
local nvim_lsp = require'lspconfig'

-- function to attach completion when setting up lsp
local on_attach = function(client)
    require'completion'.on_attach(client)
end

-- Enable rust_analyzer
nvim_lsp.rust_analyzer.setup({ on_attach=on_attach })

-- Enable diagnostics
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = true,
    signs = true,
    update_in_insert = true,
  }
)

require('rust-tools').setup({})
EOF
