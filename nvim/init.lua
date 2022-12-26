require('plugins')

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

vim.opt.termguicolors = true
require('gruvbox').setup({
  italic = false,
  overrides = {
    SignColumn = { bg = '#504945' },
    NormalFloat = { bg = '#504945' },
  }
})
vim.cmd('colorscheme gruvbox')

--- disable comment continuations
vim.api.nvim_create_autocmd('FileType', {
  pattern = '*',
  callback = function()
      vim.opt.formatoptions:remove { 'c', 'r', 'o' }
  end
})

local keymaps = require('keymaps')
keymaps.setup()

function on_attach(client, bufnr)
  client.server_capabilities.semanticTokensProvider = nil
  keymaps.lsp(bufnr)
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

require'lspconfig'.clojure_lsp.setup{
  on_attach = on_attach
}

require('nvim-treesitter.configs').setup {
  auto_install = false,
  ensure_installed = { 'clojure', 'go', 'help', 'lua', 'vim' },
  highlight = { enable = true },
  rainbow = { enable = false },
}

-- telescope config
local telescope = require('telescope')
telescope.setup {
  defaults = {
    layout_strategy = 'vertical',
    layout_config = {
      prompt_position = 'top',
    },
    path_display = { 'shorten' },
    sorting_strategy = 'ascending'
  },
  pickers = {
    buffers = {
      ignore_current_buffer = true,
      sort_mru = true,
    }
  }
}
telescope.load_extension("ui-select")

