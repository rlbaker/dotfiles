scriptencoding utf-8

call plug#begin(stdpath('data') . '/plugged')

Plug 'morhetz/gruvbox'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'ntpeters/vim-better-whitespace'

Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'

Plug 'dense-analysis/ale'

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'ocaml/vim-ocaml'

call plug#end()

set termguicolors
set cmdheight=1                           " Bottom command line height
set cursorline cursorcolumn               " Display a crosshair over the cursor
set expandtab                             " Expand tabs to spaces
set hidden                                " Don't force save when moving between buffers
set ignorecase smartcase                  " Case insensitive search unless caps
set mouse=a                               " Enable mouse interaction
set nobackup nowritebackup noswapfile     " Disable backups
set noerrorbells                          " Disable all bells
set noshowmode                            " Already displaying mode in airline
set shiftwidth=4 softtabstop=4 tabstop=4  " 4 space indents
set shortmess=aIc                         " Shorten messages
set showcmd                               " Show status for running commands
set splitbelow splitright                 " Splitting behavior
set whichwrap=<,>,[,],h,l                 " Configure line wrapping
set smartindent
set completeopt=noselect,noinsert,menuone

let g:gruvbox_contrast_dark = 'hard'
let g:gruvbox_sign_column = 'bg2'
colorscheme gruvbox

" Disable arrow keys for movement
inoremap <up>     <NOP>
inoremap <down>   <NOP>
inoremap <left>   <NOP>
inoremap <right>  <NOP>
noremap  <up>     <NOP>
noremap  <down>   <NOP>

noremap  <Left>  :bp<CR>
noremap  <Right> :bn<CR>

nnoremap <leader>b :Buffers<CR>
nnoremap <leader>f :Files<CR>
nnoremap <leader>m :Marks<CR>
nnoremap <leader>l :Lines<CR>
nnoremap <leader>w :Windows<CR>

let g:maplocalleader = ','

let g:fzf_layout = { 'down': '~20%' }

augroup rlb_global
  au!
  au WinLeave * set nocursorline nocursorcolumn
  au WinEnter * set cursorline cursorcolumn
augroup END

let g:ale_linters_explicit = 1
let g:ale_linters = {
\ 'sh': ['shellcheck'],
\}
