lua require('config')

set completeopt=menuone,noinsert,noselect
set confirm
set cursorline " cursorcolumn
set hidden
set ignorecase smartcase
set mouse=a
set shortmess+=cI
set signcolumn=yes
set smartindent expandtab
set splitbelow splitright
set tabstop=4 shiftwidth=0 softtabstop=-1
set wildmode=longest:full,full

let g:mapleader=' '
let g:maplocalleader=','

" close all helper windows
nnoremap <silent> <Leader>q :pclose <Bar> cclose <Bar> lclose <Bar> helpclose<CR>

" next/prev buffer
nnoremap <silent> <Leader>n :bn<CR>
nnoremap <silent> <Leader>p :bp<CR>

augroup rlb
  autocmd!

  " disable line highlight in terminal buffers
  autocmd TermEnter * set nocursorline " nocursorcolumn
  autocmd TermLeave * set cursorline " cursorcolumn

  autocmd FileType vim,lua set tabstop=2

  autocmd BufWritePre *.go :silent! lua go_organize_imports()

  autocmd BufWritePost config.lua PackerCompile
augroup END
