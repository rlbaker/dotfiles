return {
  { 'tpope/vim-fugitive', cmd = 'Git' },
  { 'vmchale/just-vim', ft = 'just' },
  { 'echasnovski/mini.pairs', event = 'VeryLazy', opts = {} },
  { 'echasnovski/mini.comment', event = 'VeryLazy', opts = {} },
  {
    'echasnovski/mini.completion',
    event = 'InsertEnter',
    opts = {
      lsp_completion = { source_func = 'omnifunc', auto_setup = false },
      delay = { completion = 250, signature = 100, info = 250 },
    },
  },
}
