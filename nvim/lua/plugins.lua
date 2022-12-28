return {
  {
    'ellisonleao/gruvbox.nvim',
    config = function()
      vim.opt.termguicolors = true
      require('gruvbox').setup({
        italic = false,
        overrides = {
          SignColumn = { bg = '#504945' },
          NormalFloat = { bg = '#504945' },
        }
      })
      vim.cmd([[colorscheme gruvbox]])
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
    config = {
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
    },
  },

  {
    'nvim-telescope/telescope-ui-select.nvim',
    config = function() require('telescope').load_extension('ui-select') end
  },

  -- clojure plugins
  { 'clojure-vim/clojure.vim', ft = 'clojure' },

  {
    'luochen1990/rainbow',
    ft = { 'clojure', 'lisp' },
    init = function() vim.g.rainbow_active = 1 end,
    config = function()
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
    end
  },

  {
    'guns/vim-sexp',
    ft = { 'clojure', 'lisp' },
    config = function()
      vim.g.sexp_mappings = {
        sexp_insert_at_list_head = 'H',
        sexp_insert_at_list_tail = 'L',
      }
    end
  },

  {
    'tpope/vim-sexp-mappings-for-regular-people',
    ft = { 'clojure', 'lisp' },
    dependencies = 'guns/vim-sexp',
  },

  {
    'Olical/conjure',
    ft = { 'clojure', 'lisp' },
    config = function()
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
    end
  },
}
