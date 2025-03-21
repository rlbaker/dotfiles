return {
    { 'folke/which-key.nvim', lazy = true },
    { 'nvim-tree/nvim-web-devicons', lazy = true },

    {
        'sainnhe/gruvbox-material',
        lazy = false,
        priority = 1000,
        config = function()
            vim.g.gruvbox_material_better_performance = 1
            vim.g.gruvbox_material_diagnostic_virtual_text = 'highlighted'
            vim.g.gruvbox_material_disable_terminal_colors = 1
            vim.cmd.colorscheme('gruvbox-material')
        end,
    },

    {
        'nvim-treesitter/nvim-treesitter',
        -- event = 'VeryLazy',
        dependencies = { 'RRethy/nvim-treesitter-endwise' },
        build = function()
            local update = require('nvim-treesitter.install').update { with_sync = true }
            update()
        end,
        config = function()
            require('nvim-treesitter.configs').setup {
                auto_install = true,
                highlight = { enable = true },
                endwise = { enable = true },
            }
            vim.wo.foldmethod = 'expr'
            vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
        end,
    },

    {
        'nvim-lualine/lualine.nvim',
        event = 'VeryLazy',
        opts = { sections = { lualine_x = { 'encoding', 'filetype' } } },
    },

    { 'echasnovski/mini.comment', event = 'VeryLazy', opts = {} },
    { 'echasnovski/mini.trailspace', event = 'VeryLazy', opts = {} },
    { 'kylechui/nvim-surround', event = 'VeryLazy', opts = {} },
    {
        'HiPhish/rainbow-delimiters.nvim',
        config = function()
            require('rainbow-delimiters.setup').setup {}
        end,
    },
    { 'tpope/vim-fugitive', cmd = 'Git' },

    {
        'windwp/nvim-autopairs',
        event = 'VeryLazy',
        opts = {
            check_ts = true,
            disable_in_visualblock = true,
            enable_check_bracket_line = false,
        },
    },

    {
        'nvim-telescope/telescope.nvim',
        cmd = 'Telescope',
        branch = '0.1.x',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope-ui-select.nvim',
        },
        event = 'VeryLazy',
        config = function()
            local telescope = require('telescope')
            telescope.setup {
                defaults = {
                    layout_strategy = 'vertical',
                    sorting_strategy = 'ascending',
                    layout_config = { prompt_position = 'top' },
                    mappings = {
                        i = { ['<ESC>'] = require('telescope.actions').close },
                    },
                },
                pickers = {
                    buffers = { sort_lastused = true, sort_mru = true },
                },
            }
            telescope.load_extension('ui-select')
        end,
    },
}
