call plug#begin(stdpath('data') . '/plugged')

Plug 'morhetz/gruvbox'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ntpeters/vim-better-whitespace'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'dense-analysis/ale'

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
set noshowmode                            " Already displaying mode in airline
set shiftwidth=4 softtabstop=4 tabstop=4  " 4 space indents
set shortmess=aIc                         " Shorten messages
set splitbelow splitright                 " Splitting behavior
set whichwrap=<,>,[,],h,l                 " Configure line wrapping
set smartindent
set completeopt=noselect,noinsert,menuone

let g:maplocalleader = ','

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

noremap  <left>  :bp<CR>
noremap  <right> :bn<CR>

nnoremap <leader>b :Buffers<CR>
nnoremap <leader>f :Files<CR>
nnoremap <leader>m :Marks<CR>
nnoremap <leader>l :Lines<CR>
nnoremap <leader>w :Windows<CR>

let g:fzf_layout = { 'down': '~20%' }

augroup rlb_global
  au!
  au WinLeave * set nocursorline nocursorcolumn
  au WinEnter * set cursorline cursorcolumn
augroup END

set omnifunc=ale#completion#OmniFunc

let g:airline#extensions#ale#enabled = 1
let g:ale_sign_column_always = 1
let g:ale_linters_explicit = 1
let g:ale_fix_on_save = 1

let g:ale_linters = {
\  '*': ['trim_whitespace'],
\  'sh': ['shellcheck'],
\  'go': ['gopls-custom'],
\  'ocaml': ['ocamllsp'],
\}

let g:ale_fixers = {
\  '*': ['trim_whitespace'],
\  'go': ['goimports'],
\}

function! GetOCamlRoot(buffer) abort
    let l:merlin_file = ale#path#FindNearestFile(a:buffer, '.merlin')

    return !empty(l:merlin_file) ? fnamemodify(l:merlin_file, ':h') : ''
endfunction

call ale#linter#Define('ocaml', {
\   'name': 'ocamllsp',
\   'lsp': 'stdio',
\   'executable': 'ocamllsp',
\   'command': '%e',
\   'project_root': function('GetOCamlRoot'),
\})

call ale#linter#Define('go', {
\  'name': 'gopls-custom',
\  'lsp': 'stdio',
\  'initialization_options': { 'staticcheck': v:true, },
\  'executable': {b -> ale#Var(b, 'go_gopls_executable')},
\  'command': function('ale_linters#go#gopls#GetCommand'),
\  'project_root': function('ale_linters#go#gopls#FindProjectRoot'),
\})


au FileType go,ocaml nmap <buffer><silent> K <Plug>(ale_hover)
au FileType go,ocaml nmap <buffer><silent> gd <Plug>(ale_go_to_definition)
au FileType go,ocaml nmap <buffer><silent> gr <Plug>(ale_go_to_definition)
