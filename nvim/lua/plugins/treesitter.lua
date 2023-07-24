return {
  {
    'nvim-treesitter/nvim-treesitter',
    event = { 'BufReadPost', 'BufNewFile' },
    build = function()
      local update = require('nvim-treesitter.install').update { with_sync = true }
      update()
    end,
    config = function()
      require('nvim-treesitter.configs').setup {
        auto_install = true,
        ensure_installed = { 'fish', 'go', 'lua', 'zig' },
        highlight = { enable = true },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = '<C-Space>',
            node_incremental = '<C-Space>',
            scope_incremental = false,
            node_decremental = '<bs>',
          },
        },
      }
    end,
  },
}
