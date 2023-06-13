return {
    {
        'sainnhe/gruvbox-material',
        lazy = false,
        priority = 1000,
        init = function()
            vim.g.gruvbox_material_better_performance = 1
            vim.g.gruvbox_material_diagnostic_virtual_text = 'colored'
            vim.cmd([[colorscheme gruvbox-material]])
            vim.api.nvim_set_hl(0, 'MatchParen', { fg = '#FF0000' })
        end,
    },

    { 'neovim/nvim-lspconfig' },
    { 'tpope/vim-repeat' },
    { 'tpope/vim-commentary' },
    { 'tpope/vim-surround' },
    { 'tpope/vim-fugitive', cmd = 'Git' },
    {
        'windwp/nvim-autopairs',
        event = 'VeryLazy',
        opts = { check_ts = true },
    },

    {
        'nvim-treesitter/nvim-treesitter',
        event = 'VeryLazy',
        dependencies = { 'RRethy/nvim-treesitter-endwise' },
        build = function()
            local update = require('nvim-treesitter.install').update { with_sync = true }
            update()
        end,
        config = function()
            require('nvim-treesitter.configs').setup {
                auto_install = false,
                ensure_installed = { 'bash', 'fish', 'go', 'lua', 'vim', 'vimdoc' },
                highlight = { enable = true },
                indent = { enable = true },
                endwise = { enable = true },
            }
        end,
    },

    {
        'nvim-telescope/telescope.nvim',
        lazy = true,
        branch = '0.1.x',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope-ui-select.nvim',
        },
        config = function()
            local telescope = require('telescope')
            telescope.setup {
                defaults = {
                    layout_strategy = 'vertical',
                    layout_config = { prompt_position = 'top' },
                    mappings = {
                        i = { ['<ESC>'] = require('telescope.actions').close },
                    },
                    sorting_strategy = 'ascending',
                },
                pickers = { buffers = { sort_lastused = true } },
            }
            telescope.load_extension('ui-select')
        end,
    },
}
