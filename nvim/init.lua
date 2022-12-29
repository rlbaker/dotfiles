vim.g.mapleader = ' '
vim.g.maplocalleader=','

-- bootstrap package manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone",
    "--filter=blob:none", "--single-branch",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.runtimepath:prepend(lazypath)

require("lazy").setup('plugins', {
  ui = {
    icons = {
      cmd = "⌘", config = "🛠", event = "📅",
      ft = "📂", init = "⚙", keys = "🗝",
      plugin = "🔌", runtime = "💻", source = "📄",
      start = "🚀", task = "📌",
    }
  }
})

vim.opt.completeopt = {'menuone', 'noinsert', 'noselect'}
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
vim.opt.wildmode = {'longest:full', 'full'}

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
  group = 'rlb',
  pattern = '*',
  callback = function()
    vim.opt.formatoptions:remove { 'c', 'r', 'o' }
  end
})

local opts = { noremap = true, silent = true }

--- close all helper windows
vim.keymap.set('n', '<Leader>q', function()
  vim.cmd('pclose')
  vim.cmd('cclose')
  vim.cmd('lclose')
  vim.cmd('helpclose')
end, opts)

vim.keymap.set('n', '<Leader>t', ':%s/\\s\\+$//e<CR>', opts) -- trim whitespace

local telescope = require('telescope.builtin')
vim.keymap.set('n', '<Leader><Leader>', telescope.buffers, opts)
vim.keymap.set('n', '<Leader>.', telescope.find_files, opts)
vim.keymap.set('n', '<Leader>m', telescope.marks, opts)
vim.keymap.set('n', '<Leader>:', telescope.commands, opts)

vim.keymap.set('n', '<Leader>/', telescope.live_grep, opts)
vim.keymap.set('n', '<LocalLeader>/', telescope.current_buffer_fuzzy_find)

vim.keymap.set('n', '<Leader>d', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '<Leader>D', telescope.diagnostics, opts)
vim.keymap.set('n', '<Leader>[', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', '<Leader>]', vim.diagnostic.goto_next, opts)


function on_attach(client, bufnr)
  client.server_capabilities.semanticTokensProvider = nil

  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)

  vim.keymap.set('n', 'gd', telescope.lsp_definitions, bufopts)
  vim.keymap.set('n', 'gr', telescope.lsp_references, bufopts)
  vim.keymap.set('n', 'gi', telescope.lsp_implementations, bufopts)

  vim.keymap.set('n', '<LocalLeader>R', vim.lsp.buf.rename, bufopts)

  -- keymap.set('n', '<LocalLeader>D', vim.lsp.buf.declaration, bufopts)
  -- vim.keymap.set('n', '<LocalLeader>s', telescope.lsp_document_symbols, bufopts)
  -- vim.keymap.set('n', '<LocalLeader>S', telescope.lsp_dynamic_workspace_symbols, bufopts)

  vim.keymap.set('n', '<LocalLeader>f', function() vim.lsp.buf.format { async = true } end, bufopts)
  vim.keymap.set('n', '<LocalLeader>o', function()
    vim.lsp.buf.code_action({ context = { only = { 'source.organizeImports' } }, apply = true })
  end, bufopts)

  vim.keymap.set('n', '<LocalLeader>a', vim.lsp.buf.code_action, bufopts)
end

require('lspconfig').gopls.setup {
  on_attach = on_attach,
  settings = {
    gopls = {
      gofumpt = true,
      staticcheck = true,
    }
  }
}

require('lspconfig').clojure_lsp.setup{
  on_attach = on_attach,
  root_dir = function(filename, bufnr)
    -- prevent LSP from attaching to conjure buffer
    if string.match(filename, "conjure%-log%-%d+") then
      return nil
    end
    return require("lspconfig.server_configurations.clojure_lsp").default_config.root_dir(filename, bufnr)
  end,
}
