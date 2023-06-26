return {
  { 'tpope/vim-surround', keys = { 'ys', 'ds', 'cs' } },
  { 'tpope/vim-repeat', keys = { '.' } },
  { 'tpope/vim-fugitive', cmd = 'Git' },
  {
    'tpope/vim-commentary',
    keys = {
      'gcc',
      'gcu',
      { 'gc', mode = { 'o', 'n', 'x' } },
    },
  },
}
