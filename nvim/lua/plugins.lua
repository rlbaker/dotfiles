return {
  {
    'sainnhe/gruvbox-material',
    priority = 1000,
    config = function()
      vim.opt.termguicolors = true
      vim.g.gruvbox_material_better_performance = 1
      vim.g.gruvbox_material_diagnostic_virtual_text = 'colored'
      vim.cmd([[colorscheme gruvbox-material]])
    end
  },

  {
    'nvim-lualine/lualine.nvim',
    config = {
      tabline = {
        lualine_a = { 'buffers' },
        lualine_z = { 'tabs' }
      },
      options = {
        icons_enabled        = false,
        section_separators   = '',
        component_separators = '',
      },
    },
  },

  { 'tpope/vim-commentary' },
  { 'tpope/vim-surround' },
  { 'tpope/vim-repeat' },
  { 'tpope/vim-fugitive', cmd = 'Git' },
  { 'marcuscf/vim-lua', ft = 'lua' },
  { 'blankname/vim-fish', ft = 'fish' },
  { 'neovim/nvim-lspconfig' },

  {
    'nvim-treesitter/nvim-treesitter',
    build = function()
      local ts = require('nvim-treesitter.install')
      local ts_update = ts.update({ with_sync = true })
      ts_update()
    end,
    config = function()
      require('nvim-treesitter.configs').setup {
        auto_install     = false,
        ensure_installed = { 'bash', 'go', 'help', 'lua', 'vim' },
        highlight        = { enable = true },
        indent           = { enable = true },
        endwise          = { enable = true },
      }
    end
  },

  {
    'RRethy/nvim-treesitter-endwise', ft = 'lua',
    dependencies = 'nvim-treesitter/nvim-treesitter'
  },

  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = 'nvim-lua/plenary.nvim',
    config = function()
      local actions = require('telescope.actions')
      require('telescope').setup {
        defaults = {
          layout_strategy = 'vertical',
          layout_config = {
            prompt_position = 'top',
            width = { 0.85, max = 130 },
            preview_height = 10,
          },
          path_display = { 'smart' },
          sorting_strategy = 'ascending',
          mappings = {
            i = { ['<ESC>'] = actions.close },
          },
        },
        pickers = {
          buffers = {
            ignore_current_buffer = true,
            sort_mru = true,
          }
        },
      }
    end
  },

  {
    'nvim-telescope/telescope-ui-select.nvim',
    config = function()
      require('telescope').load_extension('ui-select')
    end
  },

  {
    'windwp/nvim-autopairs',
    config = { check_ts = true }
  },
}
