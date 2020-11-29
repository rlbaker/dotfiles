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

set cmdheight=1                           " Bottom command line height
set completeopt=noselect,noinsert,menuone " Completion menu settings
set cursorline cursorcolumn               " Display a crosshair over the cursor
set expandtab                             " Expand tabs to spaces
set hidden                                " Don't force save when moving between buffers
set ignorecase smartcase                  " Case insensitive search unless caps
set mouse=a                               " Enable mouse interaction
set nobackup nowritebackup noswapfile     " Disable backups
set noshowmode                            " Already displaying mode in airline
set shortmess=aIc                         " Shorten messages
set smartindent
set splitbelow splitright                 " Splitting behavior
set tabstop=4 shiftwidth=0 softtabstop=-1 " 4 space indents
set termguicolors                         " Enable truecolor

let g:maplocalleader = ','

let g:gruvbox_contrast_dark = 'hard'
let g:gruvbox_sign_column = 'dark0'
colorscheme gruvbox

" Disable arrow keys for movement
inoremap <Up>    <Nop>
inoremap <Down>  <Nop>
inoremap <Left>  <Nop>
inoremap <Right> <Nop>
noremap  <Up>    <Nop>
noremap  <Down>  <Nop>

noremap <silent> <Left>  :bp<CR>
noremap <silent> <Right> :bn<CR>

nnoremap <silent> <Leader>b :Buffers<CR>
nnoremap <silent> <Leader>f :Files<CR>
nnoremap <silent> <Leader>m :Marks<CR>
nnoremap <silent> <Leader>l :Lines<CR>
nnoremap <silent> <Leader>w :Windows<CR>

let g:fzf_layout = { 'down': '~20%' }

augroup rlb_global
  autocmd!
  autocmd WinEnter * set cursorline cursorcolumn
  autocmd WinLeave * set nocursorline nocursorcolumn
  autocmd ColorScheme,BufEnter,BufWinEnter * call s:FixNeovimCursorLine()

  autocmd FileType vim setlocal tabstop=2
  autocmd FileType fish,go,ocaml,sh setlocal signcolumn=yes
  autocmd FileType go,ocaml call s:LSPSetup()
augroup END

function! s:FixNeovimCursorLine()
  highlight CursorLine ctermfg=white
endfunction

let g:better_whitespace_enabled = 1
let g:strip_whitespace_on_save = 1
let g:strip_whitespace_confirm = 0

let airline#extensions#whitespace#enabled = 0
let g:airline#extensions#ale#enabled = 1

let g:ale_virtualtext_cursor = 1
let g:ale_sign_column_always = 1
let g:ale_linters_explicit = 1

let g:ale_linters = {
\  'fish': ['fish'],
\  'go': ['gopls-custom'],
\  'ocaml': ['ocamllsp'],
\  'sh': ['shellcheck'],
\}

let g:ale_fix_on_save = 1
let g:ale_fixers = {
\  'go': ['goimports'],
\  'ocaml': ['ocamlformat'],
\}

function! s:LSPSetup() abort
  setlocal omnifunc=ale#completion#OmniFunc
  nmap <buffer><silent> K <Plug>(ale_hover)
  nmap <buffer><silent> gd <Plug>(ale_go_to_definition)
  nmap <buffer><silent> gr <Plug>(ale_find_references)
endfunction

function! s:FindOCamlProjectRoot(buffer) abort
  let l:dune_project = ale#path#FindNearestFile(a:buffer, 'dune-project')
  if !empty(l:dune_project)
    return fnamemodify(l:dune_project, ':h')
  endif

  let l:dune_file = ale#path#FindNearestFile(a:buffer, 'dune')
  if !empty(l:dune_file)
    return fnamemodify(l:dune_file, ':h')
  endif

  let l:buffer_file = fnamemodify(bufname(a:buffer), ':p')
  return fnameescape(l:buffer_file)
endfunction

call ale#linter#Define('ocaml', {
\  'name': 'ocamllsp',
\  'lsp': 'stdio',
\  'executable': 'ocamllsp',
\  'command': 'ocamllsp',
\  'project_root': function('s:FindOCamlProjectRoot'),
\})

call ale#linter#Define('go', {
\  'name': 'gopls-custom',
\  'lsp': 'stdio',
\  'initialization_options': { 'staticcheck': v:true, },
\  'executable': {b -> ale#Var(b, 'go_gopls_executable')},
\  'command': function('ale_linters#go#gopls#GetCommand'),
\  'project_root': function('ale_linters#go#gopls#FindProjectRoot'),
\})
