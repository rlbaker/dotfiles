local api = vim.api
local g = vim.g
local keymap = vim.keymap
local opt = vim.opt

g.mapleader = ' '
g.maplocalleader = ','

opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.expandtab = true
opt.completeopt = { 'menu', 'menuone', 'noinsert', 'noselect' }
opt.confirm = true
opt.cursorline = true
opt.ignorecase = true
opt.laststatus = 3
opt.mouse = 'a'
opt.shortmess:append { W = true, I = true, c = true, C = true }
opt.showcmd = false
opt.showmode = false
opt.signcolumn = 'no'
opt.smartcase = true
opt.smartindent = true
opt.splitbelow = true
opt.splitkeep = 'screen'
opt.splitright = true
opt.termguicolors = true
opt.wildmode = { 'longest:full', 'full' }

g.html_indent_autotags = 'html'
g.loaded_python3_provider = 0

keymap.set('n', '<Leader>q', [[ :pclose | cclose | lclose | helpclose<CR> ]])
keymap.set('n', '\\', ':noh<CR>')
keymap.set('i', '<C-Space>', '<C-X><C-O>')

keymap.set('n', '<Leader>.', '<Cmd>Telescope find_files<CR>')
keymap.set('n', '<Leader>/', '<Cmd>Telescope current_buffer_fuzzy_find<CR>')
keymap.set('n', '<Leader><Leader>', '<Cmd>Telescope buffers<CR>')
keymap.set('n', '<Leader>m', '<Cmd>Telescope marks<CR>')
keymap.set('n', '<Leader>r', '<Cmd>Telescope registers<CR>')

keymap.set('n', '<Leader>d', '<Cmd>Telescope diagnostics<CR>')
keymap.set('n', '<Leader>[', vim.diagnostic.goto_prev)
keymap.set('n', '<Leader>]', vim.diagnostic.goto_next)
keymap.set('t', '<Esc>', '<C-\\><C-n>')

keymap.set('i', '<C-;>', '<Esc>ms<S-A>;<Esc>`sa')
keymap.set('n', '<C-;>', '<S-A>;<Esc>')

-- bootstrap package manager
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.uv.fs_stat(lazypath) then
    vim.fn.system {
        'git', 'clone', '--filter=blob:none', '--single-branch',
        'https://github.com/folke/lazy.nvim.git', lazypath,
    }
end
opt.runtimepath:prepend(lazypath)
require('lazy').setup('plugins')

api.nvim_create_augroup('rlb', { clear = true })
api.nvim_create_autocmd('FileType', { group = 'rlb', pattern = '*', command = [[set formatoptions-=cro]] })
api.nvim_create_autocmd('FileType', { group = 'rlb', pattern = 'go', command = [[set noexpandtab]] })
