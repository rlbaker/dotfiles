return {
  {
    'sainnhe/gruvbox-material',
    priority = 1000,
    config = function()
      vim.g.gruvbox_material_diagnostic_virtual_text = 'colored'
      vim.g.gruvbox_material_better_performance = 1
      vim.opt.termguicolors = true
      vim.cmd([[colorscheme gruvbox-material]])
    end
  },

  {
    'nvim-lualine/lualine.nvim',
    config = {
      options = {
        theme = 'gruvbox-material',
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
        ensure_installed = { 'clojure', 'go', 'help', 'lua', 'vim' },

        highlight  = { enable = true },
        indent     = { enable = true },
        endwise    = { enable = true },
        playground = { enable = true },
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
            i = {
              ['<ESC>'] = actions.close,
            },
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
    config = function()
      local npairs = require('nvim-autopairs')
      npairs.setup {
        check_ts                  = true,
        enable_check_bracket_line = true,
        map_cr                    = true,
      }
      npairs.get_rule("'")[1].not_filetypes = { 'clojure', 'lisp' }
      npairs.get_rule('`').not_filetypes    = { 'clojure', 'lisp' }
    end
  },

  --   {
  --     'guns/vim-sexp', ft = 'clojure',
  --     config = function()
  --       -- vim.api.nvim_set_hl(0, "@punctuation.bracket", { fg = '#bdae93' })

  --       vim.g.sexp_enable_insert_mode_mappings = 0
  --       vim.g.sexp_mappings = {
  --         sexp_insert_at_list_head = '',
  --         sexp_insert_at_list_tail = '',
  --       }
  --     end
  --   },

  --   {
  --     'tpope/vim-sexp-mappings-for-regular-people',
  --     ft = 'clojure', dependencies = 'guns/vim-sexp',
  --   },

  -- {
  --   'Olical/conjure', ft = 'clojure',
  --   config = function()
  --     vim.g['conjure#filetypes'] = { 'clojure' }
  --     vim.g['conjure#extract#tree_sitter#enabled'] = true
  --     vim.g['conjure#log#botright'] = true
  --     vim.g['conjure#log#hud#height'] = 0.66
  --     vim.g['conjure#log#jump_to_latest#cursor_scroll_position'] = 'center'
  --     vim.g['conjure#log#jump_to_latest#enabled'] = true
  --     vim.g['conjure#log#wrap'] = true
  --     vim.g['conjure#eval#inline_results'] = false
  --     vim.g['conjure#client#clojure#nrepl#connection#auto_repl#enabled'] = false
  --     vim.g['conjure#completion#omnifunc'] = false
  --     -- vim.g['conjure#mapping#def_word'] = false
  --     -- vim.g['conjure#mapping#doc_word'] = false
  --   end
  -- },
}
