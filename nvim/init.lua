vim.g.mapleader = ' '
vim.g.maplocalleader = ','

-- bootstrap package manager
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git', 'clone', '--filter=blob:none', '--single-branch',
    'https://github.com/folke/lazy.nvim.git', lazypath,
  }
end
vim.opt.runtimepath:prepend(lazypath)

require('lazy').setup('plugins', {
  ui = {
    icons = {
      cmd = '⌘', config = '🛠', event = '📅',
      ft = '📂', init = '⚙', keys = '🗝',
      plugin = '🔌', runtime = '💻', source = '📄',
      start = '🚀', task = '📌',
    }
  }
})


vim.opt.completeopt = { 'menuone', 'noinsert', 'noselect' }
vim.opt.confirm = true
vim.opt.cursorline = true
vim.opt.ignorecase = true
vim.opt.laststatus = 3
vim.opt.mouse = 'a'
vim.opt.shortmess:append 'cI'
vim.opt.signcolumn = 'no'
vim.opt.smartcase = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.wildmode = { 'longest:full', 'full' }

-- indentation
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.smartindent = true
vim.opt.softtabstop = -1
vim.opt.tabstop = 2

vim.g.html_indent_autotags = 'html,head,body'

--- disable comment continuations
vim.api.nvim_create_augroup('rlb', { clear = true })
vim.api.nvim_create_autocmd('FileType', {
  pattern = '*', group = 'rlb',
  callback = function()
    vim.opt.formatoptions:remove { 'c', 'r', 'o' }
  end
})

vim.api.nvim_create_autocmd('Filetype', {
  pattern = 'clojure', group = 'rlb',
  callback = function()
    vim.api.nvim_set_hl(0, '@symbol', { fg = '#d3869b' })
  end
})

vim.api.nvim_create_autocmd('Filetype', {
  pattern = 'lua', group = 'rlb',
  callback = function()
    vim.api.nvim_set_hl(0, '@constructor', { fg = '#d4be98' })
  end
})

vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = '*', group = 'rlb',
  command = [[%s/\s\+$//e]],
})

local opts = { noremap = true, silent = true }

--- close all helper windows
vim.keymap.set('n', '<Leader>q', function()
  vim.cmd('pclose')
  vim.cmd('cclose')
  vim.cmd('lclose')
  vim.cmd('helpclose')
end, opts)

local telescope = require('telescope.builtin')
vim.keymap.set('n', '<Leader><Leader>', '<C-6><CR>', opts)
vim.keymap.set('n', '<Leader>t', ':%s/\\s\\+$//e<CR>', opts) -- trim whitespace
vim.keymap.set('n', '<Leader>b', telescope.buffers, opts)
vim.keymap.set('n', '<Leader>.', telescope.find_files, opts)
vim.keymap.set('n', '<Leader>m', telescope.marks, opts)
vim.keymap.set('n', '<Leader>:', telescope.commands, opts)
vim.keymap.set('n', '<Leader>/', telescope.live_grep, opts)
vim.keymap.set('n', '<Leader>d', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '<Leader>D', telescope.diagnostics, opts)
vim.keymap.set('n', '<Leader>[', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', '<Leader>]', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<LocalLeader>/', telescope.current_buffer_fuzzy_find, opts)

require('lsp')
