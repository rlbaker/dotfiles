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
vim.opt.wildmode = {'longest:full', 'full'}
vim.opt.termguicolors = true
vim.opt.signcolumn = 'yes'
vim.opt.background = 'dark'
vim.g.mapleader = ' '
vim.g.maplocalleader=','
vim.g.html_indent_autotags = 'html,head,body'
vim.g.gruvbox_sign_column = 'bg2'
vim.g.gruvbox_invert_tabline = 1

require("gruvbox").setup({ italic = false })
vim.cmd [[colorscheme gruvbox]]

--- disable comment continuations
vim.api.nvim_create_autocmd('FileType', {pattern='*', command='set formatoptions-=cro'})

--- compile packer configuration after saving init.lua
vim.api.nvim_create_autocmd('BufWritePost', { pattern={'init.lua'}, command='PackerCompile' })

--- close all helper windows
vim.api.nvim_set_keymap('n', '<Leader>q', ':pclose <Bar> cclose <Bar> lclose <Bar> helpclose<CR>', {noremap=true, silent=true})

-- telescope config
local tele = require'telescope.builtin'
vim.api.nvim_set_keymap('n', '<Leader>f', '', { callback=tele.find_files, noremap=true, silent=true })
vim.api.nvim_set_keymap('n', '<Leader><Leader>', '', { callback=tele.buffers, noremap=true, silent=true })
vim.api.nvim_set_keymap('n', '<Leader>/', '', { callback=tele.live_grep, noremap=true, silent=true })

local lspconfig = require('lspconfig')
local opts = { noremap=true, silent=true }
-- vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
-- vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
-- vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
-- vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  -- vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  -- vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  -- vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  -- vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  -- vim.keymap.set('n', '<space>wl', function()
  --   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  -- end, bufopts)
  -- vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  -- vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  -- vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  -- vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  -- vim.keymap.set('n', '<space>f', vim.lsp.buf.formatting, bufopts)
end

lspconfig['zls'].setup { on_attach = on_attach }

require'nvim-treesitter.configs'.setup {
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
    ensure_installed = {
        'bash',
        'c',
        'cmake',
        'cpp',
        'css',
        'fish',
        'go',
        'gomod',
        'gowork',
        'html',
        'javascript',
        'json',
        'lua',
        'make',
        'ninja',
        'python',
        'toml',
        'yaml',
        'zig'
    },
}
