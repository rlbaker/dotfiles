return {
    {
        'sainnhe/gruvbox-material',
        lazy = false,
        priority = 1000,
        config = function()
            vim.opt.termguicolors = true
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
            sections = { lualine_b = { 'diagnostics' } },
            options = {
                icons_enabled = false,
                section_separators = '',
                component_separators = '',
            },
        },
    },

    { 'tpope/vim-commentary' },
    { 'tpope/vim-repeat' },
    { 'tpope/vim-surround' },
    { 'tpope/vim-fugitive',   cmd = 'Git' },
    { 'neovim/nvim-lspconfig' },

    {
        'nvim-treesitter/nvim-treesitter',
        build = function()
            local update = require('nvim-treesitter.install').update { with_sync = true }
            update()
        end,
        config = function()
            require('nvim-treesitter.configs').setup {
                highlight = { enable = true },
                indent = { enable = true, disable = { 'go' } },
            }
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
