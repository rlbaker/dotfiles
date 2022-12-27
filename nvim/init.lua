require('plugins')

local keymaps = require('keymaps')
keymaps.setup()

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

vim.opt.termguicolors = true
require('gruvbox').setup({
  italic = false,
  overrides = {
    SignColumn = { bg = '#504945' },
    NormalFloat = { bg = '#504945' },
  }
})
vim.cmd('colorscheme gruvbox')

vim.g.html_indent_autotags = 'html,head,body'

-- vim-sexp
vim.g.sexp_mappings = {
  sexp_insert_at_list_head = 'H',
  sexp_insert_at_list_tail = 'L',
}

-- conjure
vim.g['conjure#client#clojure#nrepl#connection#auto_repl#enabled'] = false
vim.g['conjure#completion#omnifunc'] = false
vim.g['conjure#eval#inline_results'] = false
vim.g['conjure#extract#tree_sitter#enabled'] = true
vim.g['conjure#filetypes'] = { 'clojure' }
vim.g['conjure#mapping#def_word'] = false
vim.g['conjure#mapping#doc_word'] = false
vim.g['conjure#log#botright'] = true
vim.g['conjure#log#hud#height'] = 0.66
vim.g['conjure#log#jump_to_latest#cursor_scroll_position'] = 'center'
vim.g['conjure#log#jump_to_latest#enabled'] = true
vim.g['conjure#log#wrap'] = true

-- rainbow parens
vim.g.rainbow_active = 1
vim.g.rainbow_conf = {
  guifgs = {
    '#7C6F64', -- grey
    '#B57614', -- yellow
    '#427B58', -- aqua
    '#8F3F71', -- purple
    '#076678', -- blue
    '#AF3A03', -- orange
    '#79740E', -- green
  },
}

--- disable comment continuations
vim.api.nvim_create_autocmd('FileType', {
  pattern = '*',
  callback = function()
    vim.opt.formatoptions:remove { 'c', 'r', 'o' }
  end
})

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

require('nvim-treesitter.configs').setup {
  auto_install = false,
  ensure_installed = { 'clojure', 'go', 'help', 'lua', 'vim' },
  highlight = { enable = false },
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
