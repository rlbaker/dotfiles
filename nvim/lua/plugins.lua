return {
    {
        'sainnhe/gruvbox-material',
        lazy = false,
        priority = 1000,
        config = function()
            vim.g.gruvbox_material_better_performance = 1
            vim.g.gruvbox_material_diagnostic_virtual_text = 'colored'
            vim.cmd([[colorscheme gruvbox-material]])
            vim.api.nvim_set_hl(0, 'MatchParen', { fg = '#FF0000' })
        end
    },

    {
        'nvim-lualine/lualine.nvim',
        opts = {
            tabline = {
                lualine_a = { 'buffers' },
                lualine_z = { 'tabs' },
            },
            options = {
                icons_enabled = false,
                section_separators = '',
                component_separators = '',
            },
        },
    },

    {
        'nvim-treesitter/nvim-treesitter',
        dependencies = { 'RRethy/nvim-treesitter-endwise' },
        build = function()
            local update = require('nvim-treesitter.install').update { with_sync = true }
            update()
        end,
        config = function()
            require('nvim-treesitter.configs').setup {
                highlight = { enable = true },
                endwise = { enable = true },
            }
        end
    },
    {
        'windwp/nvim-autopairs',
        config = function()
            require('nvim-autopairs').setup {
                check_ts = true,
                map_cr = false,
            }

            local cond = require('nvim-autopairs.conds')
            require("nvim-autopairs").get_rules("'")[1].not_filetypes = { 'clojure', 'lisp' }
            require("nvim-autopairs").get_rules("'")[1]:with_pair(cond.not_after_text("["))
        end
    },

    { 'neovim/nvim-lspconfig' },
    { 'tpope/vim-commentary' },
    { 'tpope/vim-repeat' },
    { 'tpope/vim-surround' },
    { 'tpope/vim-fugitive',   cmd = 'Git' },

    {
        'nvim-telescope/telescope.nvim',
        branch = '0.1.x',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope-ui-select.nvim'
        },
        config = function()
            local telescope = require('telescope')
            telescope.setup {
                defaults = {
                    layout_strategy = 'vertical',
                    layout_config = {
                        prompt_position = 'top',
                    },
                    mappings = {
                        i = { ['<ESC>'] = require('telescope.actions').close },
                    },
                    sorting_strategy = 'ascending',
                },
                pickers = {
                    buffers = { sort_lastused = true },
                },
            }
            telescope.load_extension('ui-select')
        end
    },

    {
        'Olical/conjure',
        config = function()
            vim.g['conjure#filetypes'] = { 'clojure' }
            vim.g['conjure#highlight#enabled'] = true
            vim.g['conjure#log#wrap'] = true
        end
    },
}
