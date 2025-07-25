vim.g.mapleader = ' '
vim.g.maplocalleader = ','

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.completeopt = { 'menu', 'menuone', 'noinsert', 'noselect' }
vim.opt.confirm = true
vim.opt.cursorline = true
vim.opt.ignorecase = true
vim.opt.laststatus = 3
vim.opt.mouse = 'a'
vim.opt.shortmess:append { W = true, I = true, c = true }
vim.opt.showcmd = false
vim.opt.showmode = false
vim.opt.signcolumn = 'no'
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.splitbelow = true
vim.opt.splitkeep = 'screen'
vim.opt.splitright = true
vim.opt.wildmode = { 'longest:full', 'full' }
vim.opt.switchbuf = { 'useopen', 'uselast' }
vim.opt.updatetime = 1000
vim.opt.timeout = true
vim.opt.timeoutlen = 500
vim.opt.foldenable = false
-- vim.opt.foldlevelstart = 99

vim.g.html_indent_autotags = 'html'

vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0

-- bootstrap lazy.nvim
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system {
    'git', 'clone', '--filter=blob:none', '--single-branch',
    'https://github.com/folke/lazy.nvim.git', lazypath,
  }
end
vim.opt.runtimepath:prepend(lazypath)

require('lazy').setup { { import = 'plugins' } }

vim.cmd.colorscheme('catppuccin-mocha')

vim.g.editorconfig = false

local rlb = vim.api.nvim_create_augroup('rlb', { clear = true })
vim.api.nvim_create_autocmd('FileType', { group = rlb, pattern = '*', command = [[ set fo-=cro ]] })
vim.api.nvim_create_autocmd('FileType', { group = rlb, pattern = 'go', command = [[ set noet ]] })
vim.api.nvim_create_autocmd('FileType',
  { group = rlb, pattern = 'lua,typescript,javascript,svelte', command = [[ set ts=2 sts=2 sw=2 ]] })

vim.diagnostic.config({
  underline = true,
  virtual_text = true,
  -- virtual_lines = { current_line = true },
})

local hover = vim.lsp.buf.hover
---@diagnostic disable-next-line: duplicate-set-field
vim.lsp.buf.hover = function() return hover({ border = 'rounded' }) end

local function cmd(s) return '<CMD>' .. s .. '<CR>' end

-- unbind default gr* mappings
pcall(vim.keymap.del, 'n', 'gra')
pcall(vim.keymap.del, 'n', 'gri')
pcall(vim.keymap.del, 'n', 'grn')
pcall(vim.keymap.del, 'n', 'grr')

local wk = require('which-key')
wk.add({
  { '<Leader><Leader>', function() Snacks.picker.buffers({ current = false }) end, desc = 'Buffer List' },
  { '<Leader>.', function() Snacks.picker.files() end, desc = 'List Files' },
  { '<Leader>D', function() Snacks.picker.diagnostics() end, desc = 'List All Diagnostics' },
  { '<Leader>d', function() Snacks.picker.diagnostics_buffer() end, desc = 'List Buffer Diagnostics' },
  { '<Leader>e', function() Snacks.explorer() end, desc = 'File Explorer' },
  { '<Leader>h', function() Snacks.picker.help() end, desc = 'Help' },
  { '<Leader>p', function() Snacks.picker() end, desc = 'Pickers' },
  { '<Leader>t', function() Snacks.picker.treesitter() end, desc = 'Treesitter' },
  { '<Leader>r', vim.cmd.checktime, desc = 'reload file' },
  { '<Leader>s', cmd('lua MiniTrailspace.trim()'), desc = 'Trim Trailing Whitespace' },
  { '\\', cmd('noh'), desc = 'Clear Search Highlights' },
  { '<C-;>', 'A;<Esc>', desc = 'Add Semicolon' },
  { 'gd', function() Snacks.picker.lsp_definitions() end, desc = 'LSP: Go to definition' },
  { 'gD', function() Snacks.picker.lsp_declarations() end, desc = 'LSP: Go to declaration' },
  { 'gy', function() Snacks.picker.lsp_type_definitions() end, desc = 'LSP: Go to type definition' },
  { 'gI', function() Snacks.picker.lsp_implementations() end, desc = 'LSP: Go to implementation' },
  { 'gr', function() Snacks.picker.lsp_references() end, desc = 'LSP: Show references', nowait = true },
  { 'gR', vim.lsp.buf.rename, desc = 'LSP: Rename' },
  { 'gs', function() Snacks.picker.lsp_symbols() end, desc = 'LSP: Find symbol in file' },
  { 'gS', function() Snacks.picker.lsp_workspace_symbols() end, desc = 'LSP: Find symbol in workspace' },
  { 'gn', function() Snacks.words.jump(1, true) end, desc = 'LSP: Next occurrence' },
  { 'gp', function() Snacks.words.jump(-1, true) end, desc = 'LSP: Previous occurrence' },
  { 'gF', function() vim.lsp.buf.format({ async = true }) end, desc = 'LSP: Format Document' },
  { 'g.', vim.lsp.buf.code_action, mode = { 'n', 'x' }, desc = 'LSP: Code actions' },
  { 'gh', vim.diagnostic.open_float, desc = 'Show Diagnostic' },
  { 'g]', function() vim.diagnostic.jump({ count = vim.v.count1 }) end, desc = 'Go to Next Diagnostic' },
  { 'g[', function() vim.diagnostic.jump({ count = -vim.v.count1 }) end, desc = 'Go to Prev Diagnostic' },
  {
    mode = 'i',
    { '<C-Space>', function() vim.lsp.completion.get() end, desc = 'Completion' },
    { '<C-;>', '<C-o>A;', desc = 'Add Semicolon' },
    { '<C-Enter>', '<C-y>', desc = 'Expand Completion' },
    { '<C-a>', vim.lsp.buf.code_action, desc = 'LSP: Code Actions' },
    { '<C-k>', vim.lsp.buf.signature_help, desc = 'Signature Help' },
  },
  {
    mode = { 't' },
    { '<Esc>', '<C-\\><C-n>', desc = 'Leave Terminal Input Mode' },
  },
})

-- vim.lsp.set_log_level "debug"
if vim.fn.has 'nvim-0.5.1' == 1 then
  require('vim.lsp.log').set_format_func(vim.inspect)
end
