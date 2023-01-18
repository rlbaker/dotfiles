local telescope = require('telescope.builtin')

local function on_attach(client, bufnr)
  client.server_capabilities.semanticTokensProvider = nil
  -- vim.lsp.codelens.refresh()

  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)

  vim.keymap.set('n', 'gd', telescope.lsp_definitions, bufopts)
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gr', telescope.lsp_references, bufopts)
  vim.keymap.set('n', 'gi', telescope.lsp_implementations, bufopts)

  vim.keymap.set('n', 'gR', vim.lsp.buf.rename, bufopts)

  vim.keymap.set('n', '<LocalLeader>ci', telescope.lsp_incoming_calls, bufopts)
  vim.keymap.set('n', '<LocalLeader>co', telescope.lsp_outgoing_calls, bufopts)

  vim.keymap.set('n', '<LocalLeader>s', telescope.lsp_document_symbols, bufopts)
  vim.keymap.set('n', '<LocalLeader>S', telescope.lsp_dynamic_workspace_symbols, bufopts)

  vim.keymap.set('n', 'ga', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gf', function() vim.lsp.buf.format { async = true } end, bufopts)
  vim.keymap.set('n', 'go', function()
    vim.lsp.buf.code_action({
      context = { only = { 'source.organizeImports' } },
      apply = true
    })
  end, bufopts)
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

require('lspconfig').sumneko_lua.setup {
  on_attach = on_attach,
  settings = {
    Lua = {
      completion = { keywordSnippet = 'Disable' },
      diagnostics = { globals = { 'vim', 'love' } },
      runtime = { version = 'LuaJIT' },
      semantic = { enable = false },
      telemetry = { enable = false },
      format = {
        enable = true,
        defaultConfig = {
          indent_size = '2',
          indent_style = 'space',
          align_call_args = 'true',
          continuation_indent_size = '2',
          -- if_condition_align_with_each_other = 'true',
          if_condition_no_continuation_indent = 'true',
          local_assign_continuation_align_to_first_expression = 'true',
          quote_style = 'single',
          table_append_expression_no_space = 'true',
        },
      }
    },
  },
}

require('lspconfig').clojure_lsp.setup {
  on_attach = on_attach,
  root_dir = function(fname)
    -- prevent LSP from attaching to conjure buffer
    if string.match(fname, 'conjure%-log%-%d+') then return nil end
    return require('lspconfig.util').root_pattern('deps.edn', 'bb.edn', '.git')(fname)
  end,
}
