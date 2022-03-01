-- boostrap packer

local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

-- packages
local packer = require('packer')
local use = packer.use
packer.startup(function()
  use 'wbthomason/packer.nvim'
  use 'dstein64/vim-startuptime'
  use 'gruvbox-community/gruvbox'
  use 'ntpeters/vim-better-whitespace'
  use 'tpope/vim-fugitive'
  use 'tpope/vim-commentary'
  use 'neovim/nvim-lspconfig'
end)

-- gruvbox config
vim.o.termguicolors = true
vim.g.gruvbox_sign_column = 'bg2'
vim.g.gruvbox_invert_tabline = 1
vim.cmd [[colorscheme gruvbox]]

--- vim-better-whitespace
vim.g.better_whitespace_enabled = 1
vim.g.strip_whitespace_on_save = 1
vim.g.strip_whitespace_confirm = 0

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings, see `:help vim.lsp.*` for documentation on available functions
  local opts = { noremap=true, silent=true }
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'g=', '<Cmd>lua vim.lsp.buf.formatting_sync(nil, 3000)<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'gR', '<Cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', 'gr', '<Cmd>lua vim.lsp.buf.references()<CR>', opts)
end

-- lspconfig
require('lspconfig').gopls.setup {
  cmd = {"gopls", "serve"},
  on_attach = on_attach,
  flags = { debounce_text_changes = 1000 },
  settings = {
    gopls = {
      gofumpt = true,
      linksInHover = false,
      staticcheck = true,
    }
  }
}

function go_organize_imports()
  vim.lsp.buf.formatting_sync(nil, 3000)

  local params = vim.lsp.util.make_range_params()
  params.context = {only = {"source.organizeImports"}}
  local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 3000)
  for _, res in pairs(result or {}) do
    for _, r in pairs(res.result or {}) do
      if r.edit then
        vim.lsp.util.apply_workspace_edit(r.edit)
      else
        vim.lsp.buf.execute_command(r.command)
      end
    end
  end
end
