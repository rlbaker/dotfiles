return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = { delay = 500 },
  },

  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      bigfile = { enabled = true },
      dashboard = { enabled = true },
      explorer = { enabled = true },
      input = { enabled = true },
      notifier = { enabled = true },
      picker = {
        win = {
          input = {
            keys = { ["<Esc>"] = { "close", mode = { "n", "i" } } },
          },
        },
      },
      scope = { enabled = true },
      words = { enabled = true },
    },
  },

  { "nvim-tree/nvim-web-devicons", lazy = true },

  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },

  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = { "RRethy/nvim-treesitter-endwise" },
    build = function()
      require("nvim-treesitter.install").update { with_sync = true } ()
    end,
    config = function()
      require("nvim-treesitter.configs").setup {
        auto_install = true,
        sync_install = false,
        highlight = { enable = true },
        endwise = { enable = true },
      }
      vim.wo.foldmethod = "expr"
      vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
    end,
  },

  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = {
      options = {
        section_separators = "",
        component_separators = "",
      },
      sections = {
        lualine_x = { "encoding", "filetype" },
      },
    },
  },

  { "echasnovski/mini.comment", event = "VeryLazy", opts = {} },
  { "echasnovski/mini.trailspace", event = "VeryLazy", opts = {} },
  { "kylechui/nvim-surround", event = "VeryLazy", opts = {} },

  {
    "HiPhish/rainbow-delimiters.nvim",
    submodules = false,
    config = function()
      require("rainbow-delimiters.setup").setup {}
    end,
  },
  { "tpope/vim-fugitive", cmd = "Git" },

  {
    "windwp/nvim-autopairs",
    event = "VeryLazy",
    opts = {
      check_ts = true,
      disable_in_visualblock = true,
      enable_check_bracket_line = true,
      disable_filetype = { "TelescopePrompt", "vim" },
    },
  },
}
