return {
  { 'tpope/vim-commentary', event = 'VeryLazy' },
  { 'tpope/vim-fugitive', cmd = 'Git' },
  -- { 'tpope/vim-repeat', event = 'VeryLazy' },
  -- { 'tpope/vim-surround', event = 'VeryLazy' },
  { 'vmchale/just-vim', ft = 'just' },
  -- { 'echasnovski/mini.pairs', event = 'InsertEnter', opts = {} },
  {
    'echasnovski/mini.completion',
    event = 'InsertEnter',
    opts = {
      lsp_completion = { source_func = 'omnifunc', auto_setup = false },
      delay = { completion = 250, signature = 100, info = 250 },
    },
  },
}
