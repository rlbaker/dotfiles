return {
  {
    'ellisonleao/gruvbox.nvim',
    priority = 1000,
    config = function()
      vim.opt.termguicolors = true
      require('gruvbox').setup({
          bold = false,
          italic = false,
      })
      vim.cmd('colorscheme gruvbox')
    end
  },

  { 'tpope/vim-commentary' },
  { 'tpope/vim-surround' },
  { 'tpope/vim-repeat' },
  { 'tpope/vim-fugitive', cmd = 'Git' },
  { 'blankname/vim-fish', ft = 'fish' },
  { 'neovim/nvim-lspconfig' },

  {
    'nvim-treesitter/nvim-treesitter',
    build = function()
      local treesitter = require('nvim-treesitter.install')
      local ts_update = treesitter.update({ with_sync = true })
      ts_update()
    end,
    config = function()
      require('nvim-treesitter.configs').setup {
        auto_install = false,
        ensure_installed = { 'clojure', 'go', 'help', 'lua', 'vim' },
        highlight = {
          enable = true,
          disable = { 'clojure' },
        },
      }
    end
  },

  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = 'nvim-lua/plenary.nvim',
    config = function() 
      local actions = require('telescope.actions')
      require('telescope').setup({
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
            ["<ESC>"] = actions.close,
          },
        },
      },
      pickers = {
        buffers = {
          ignore_current_buffer = true,
          sort_mru = true,
        }
      },
    })
    end
  },

  {
    'nvim-telescope/telescope-ui-select.nvim',
    config = function()
      require('telescope').load_extension('ui-select')
    end
  },

  {
    'guns/vim-sexp', ft = 'clojure',
    config = function()
      vim.api.nvim_set_hl(0, 'clojureParen', { fg = '#a89984' })
      vim.g.sexp_mappings = {
        sexp_insert_at_list_head = '',
        sexp_insert_at_list_tail = ''
      }
    end
  },

  {
    'tpope/vim-sexp-mappings-for-regular-people', ft = 'clojure',
    dependencies = 'guns/vim-sexp',
  },

  {
    'Olical/conjure', ft = 'clojure',
    config = function()
      vim.g['conjure#filetypes'] = { 'clojure' }
      vim.g['conjure#extract#tree_sitter#enabled'] = true
      vim.g['conjure#log#botright'] = true
      vim.g['conjure#log#hud#height'] = 0.66
      vim.g['conjure#log#jump_to_latest#cursor_scroll_position'] = 'center'
      vim.g['conjure#log#jump_to_latest#enabled'] = true
      vim.g['conjure#log#wrap'] = true
      vim.g['conjure#eval#inline_results'] = false
      vim.g['conjure#client#clojure#nrepl#connection#auto_repl#enabled'] = false
      vim.g['conjure#completion#omnifunc'] = false
      vim.g['conjure#mapping#def_word'] = false
      vim.g['conjure#mapping#doc_word'] = false
    end
  },
}
