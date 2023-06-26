vim.opt.termguicolors = true

vim.opt.mouse = 'a'
vim.opt.cursorline = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.shortmess:append 'cI'
vim.opt.showmode = false
vim.opt.showcmd = false
vim.opt.laststatus = 3
vim.opt.signcolumn = 'no'
vim.opt.confirm = true

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.completeopt = { 'menuone', 'noinsert', 'noselect' }
vim.opt.wildmode = { 'longest:full', 'full' }

-- indentation
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.shiftwidth = 2
vim.opt.softtabstop = -1

vim.g.mapleader = ' '
vim.g.maplocalleader = ','

vim.g.loaded_python3_provider = 0
vim.g.html_indent_autotags = 'html,head,body'

local rlb = vim.api.nvim_create_augroup('rlb', { clear = true })
vim.keymap.set('n', '<Leader>q', [[ :pclose | cclose | lclose | helpclose<CR> ]])
vim.keymap.set('n', '<Leader>[', vim.diagnostic.goto_prev)
vim.keymap.set('n', '<Leader>]', vim.diagnostic.goto_next)
vim.keymap.set('n', '\\', ':noh<CR>')
vim.keymap.set('c', 'bn', '<CR>')
vim.keymap.set('c', 'bp', '<CR>')

local trim = function() vim.cmd [[ :%s/\s\+$//e ]] end
vim.api.nvim_create_autocmd('BufWritePre', { group = rlb, pattern = '*', callback = trim })
vim.keymap.set('n', '<Leader>t', trim)

-- disable comment continuations
vim.api.nvim_create_autocmd('FileType', {
  group = rlb,
  pattern = '*',
  callback = function()
    vim.opt.formatoptions:remove { 'c', 'r', 'o' }
  end,
})

local function tabsize(n)
  return function()
    vim.opt.tabstop = n
    vim.opt.shiftwidth = n
  end
end

-- vim.api.nvim_create_autocmd('FileType', { group = rlb, pattern = { 'c', 'ocaml', 'lua' }, callback = tabsize(2) })
vim.api.nvim_create_autocmd('FileType', { group = rlb, pattern = 'go', callback = tabsize(4) })

-- bootstrap package manager
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system {
    'git', 'clone', '--filter=blob:none', '--single-branch',
    'https://github.com/folke/lazy.nvim.git', lazypath,
  }
end
vim.opt.runtimepath:prepend(lazypath)

require('lazy').setup('plugins', {
  ui = {
    icons = {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})
