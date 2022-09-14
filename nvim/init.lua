local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end

local packer = require('packer')
local use = packer.use
packer.startup(function()
    use 'wbthomason/packer.nvim'
    use 'dstein64/vim-startuptime'
    use 'ellisonleao/gruvbox.nvim'
    use 'tpope/vim-fugitive'
    use 'tpope/vim-commentary'
    use { 'nvim-telescope/telescope.nvim', requires = {{'nvim-lua/plenary.nvim'}}}
    use { 'nvim-treesitter/nvim-treesitter', run = function() require('nvim-treesitter.install').update({ with_sync = true }) end, }
    use { 'neovim/nvim-lspconfig' }
    use 'ziglang/zig.vim'
end)

vim.opt.completeopt = {'menuone', 'noinsert', 'noselect'}
vim.opt.confirm = true
vim.opt.cursorline = true
vim.opt.expandtab = true
vim.opt.hidden = true
vim.opt.ignorecase = true
vim.opt.mouse = 'a'
vim.opt.shiftwidth = 0
vim.opt.shortmess:append 'cI'
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.softtabstop = -1
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.tabstop = 4
vim.opt.signcolumn = 'no'
vim.opt.wildmode = {'longest:full', 'full'}
vim.opt.termguicolors = true
vim.opt.background = 'dark'
vim.g.mapleader = ' '
vim.g.maplocalleader=','
vim.g.html_indent_autotags = 'html,head,body'
vim.g.gruvbox_sign_column = 'bg1'
vim.g.gruvbox_invert_tabline = 1
vim.g.zig_fmt_autosave = 0

require('gruvbox').setup({
  italic = false,
  overrides = {
    SignColumn = { bg = '#504945' }         
  }
})
vim.cmd [[colorscheme gruvbox]]

--- disable comment continuations
vim.api.nvim_create_autocmd('FileType', {pattern='*', command='set formatoptions-=cro'})

--- compile packer configuration after saving init.lua
vim.api.nvim_create_autocmd('BufWritePost', { pattern={'init.lua'}, command='PackerCompile' })

local opts = { noremap=true, silent=true }
function merge(...) return vim.tbl_extend('force', ...) end

--- close all helper windows
vim.keymap.set('n', '<Leader>q', ':pclose <Bar> cclose <Bar> lclose <Bar> helpclose<CR>', opts)

-- telescope config
local tele = require('telescope.builtin')
vim.keymap.set('n', '<Leader>f', '', merge(opts, { callback=tele.find_files }))
vim.keymap.set('n', '<Leader><Leader>', '', merge(opts, { callback=tele.buffers}))
vim.keymap.set('n', '<Leader>/', '', merge(opts, { callback=tele.live_grep }))

local lspconfig = require('lspconfig')
-- vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
-- vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
-- vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
-- vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)
local on_attach = function(client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  vim.api.nvim_win_set_option(0, 'signcolumn', 'yes')

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = merge(opts, { buffer=bufnr })
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<Leader>r', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<Leader>=', vim.lsp.buf.format, bufopts)
  -- vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  -- vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  -- vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  -- vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
end

lspconfig['zls'].setup { on_attach = on_attach }

require'nvim-treesitter.configs'.setup {
  highlight = { enable = true },
  ensure_installed = {
      'bash', 'c', 'cmake', 'cpp', 'css',
      'fish', 'go', 'gomod', 'gowork', 'html',
      'javascript', 'json', 'lua', 'make', 'ninja',
      'python', 'toml', 'yaml', 'zig'
  },
}
