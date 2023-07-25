vim.g.mapleader = ' '
vim.g.maplocalleader = ','

vim.g.zig_fmt_autosave = 0
vim.g.loaded_python3_provider = 0
vim.g.html_indent_autotags = 'html'

-- bootstrap package manager
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system {
    'git', 'clone', '--filter=blob:none', '--single-branch',
    'https://github.com/folke/lazy.nvim.git', lazypath,
  }
end
vim.opt.runtimepath:prepend(lazypath)

require('lazy').setup('plugins')

local opt = vim.opt
opt.completeopt = { 'menu', 'menuone', 'noinsert', 'noselect' }
opt.confirm = true
opt.cursorline = true
opt.expandtab = true
opt.ignorecase = true
opt.laststatus = 3
opt.mouse = 'a'
opt.shiftwidth = 2
opt.shortmess:append { W = true, I = true, c = true, C = true }
opt.showcmd = false
opt.showmode = false
opt.signcolumn = 'no'
opt.smartcase = true
opt.smartindent = true
opt.softtabstop = -1
opt.splitbelow = true
opt.splitkeep = 'screen'
opt.splitright = true
opt.termguicolors = true
opt.wildmode = { 'longest:full', 'full' }

local rlb = vim.api.nvim_create_augroup('rlb', { clear = true })
vim.keymap.set('n', '<Leader>q', [[ :pclose | cclose | lclose | helpclose<CR> ]])
vim.keymap.set('n', '<Leader>[', vim.diagnostic.goto_prev)
vim.keymap.set('n', '<Leader>]', vim.diagnostic.goto_next)
vim.keymap.set('n', '\\', ':noh<CR>')
vim.keymap.set('v', '<Leader>y', '"+y') -- copy to clipboard
vim.keymap.set('n', '<Leader>p', '"+p') -- paste from clipboard
vim.keymap.set('c', 'bn', '<CR>')
vim.keymap.set('c', 'bp', '<CR>')
vim.keymap.set('i', '<C-Space>', '<C-X><C-O>')

local trim = function() vim.cmd [[ :%s/\s\+$//e ]] end
vim.api.nvim_create_autocmd('BufWritePre', { group = rlb, pattern = '*', callback = trim })
vim.keymap.set('n', '<Leader>t', trim)

-- disable comment continuations
vim.api.nvim_create_autocmd('FileType', {
  group = rlb,
  pattern = '*',
  callback = function() vim.opt.formatoptions:remove { 'c', 'r', 'o' } end,
})

local function tabsize(n)
  return function()
    vim.opt.tabstop = n
    vim.opt.shiftwidth = n
  end
end
vim.api.nvim_create_autocmd('FileType', { group = rlb, pattern = 'go', callback = tabsize(4) })

vim.cmd [[colorscheme everforest]]
vim.api.nvim_set_hl(0, 'MatchParen', { fg = '#FF0000' })
