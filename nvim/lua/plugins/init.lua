local keys = {
    { '\\', ':noh<CR>', desc = 'Clear Search Highlights' },
    { '<Leader>q', [[ :pclose | cclose | lclose | helpclose<CR> ]], desc = 'Close All Helper Windows' },
    { '<Leader>.', '<Cmd>Telescope find_files<CR>', desc = 'Find Files' },
    { '<Leader>/', '<Cmd>Telescope current_buffer_fuzzy_find<CR>', desc = 'Fuzzy Find in Buffer' },
    { '<Leader><Leader>', '<Cmd>Telescope buffers<CR>', desc = 'Buffer List' },
    { '<Leader>d', '<Cmd>Telescope diagnostics<CR>', desc = 'Diagnostic List' },
    { '<Leader>[', vim.diagnostic.goto_prev, desc = 'Previous Diagnostic' },
    { '<Leader>]', vim.diagnostic.goto_next, desc = 'Next Diagnostic' },
    { '<Esc>', '<C-\\><C-n>', desc = 'Leave Terminal Input Mode', mode = { 't' } },
    { '<C-Space>', '<C-X><C-O>', desc = 'Completion', mode = { 'i' } },
    { '<C-;>', '<C-o>A;', desc = 'Semicolon Insertion', mode = { 'i' } },
}

return {
    {
        'sainnhe/everforest',
        lazy = false,
        priority = 1000,
        init = function()
            vim.g.everforest_better_performance = 1
            vim.g.everforest_diagnostic_virtual_text = 'highlighted'
            vim.g.everforest_disable_terminal_colors = 1
            vim.g.everforest_sign_column_background = 'grey'
            vim.cmd [[colorscheme everforest]]
            vim.api.nvim_set_hl(0, 'MatchParen', { fg = '#FF0000' })
        end,
    },

    { 'nvim-tree/nvim-web-devicons', lazy = true },

    {
        'nvim-lualine/lualine.nvim',
        event = 'VeryLazy',
        opts = { sections = { lualine_x = { 'encoding', 'filetype' } } },
    },

    {
        'folke/which-key.nvim',
        event = 'VeryLazy',
        opts = {
            spec = keys,
            icons = { mappings = false },
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
                auto_install = true,
                ensure_installed = { 'bash', 'fish', 'go', 'lua', 'vim' },
                highlight = { enable = true },
                endwise = { enable = true },
            }
        end,
    },

    {
        'nvim-telescope/telescope.nvim',
        cmd = 'Telescope',
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
                pickers = {
                    buffers = {
                        sort_lastused = true,
                        sort_mru = true,
                    },
                },
            }
            telescope.load_extension('ui-select')
        end,
    },

    { 'tpope/vim-fugitive', cmd = 'Git' },
    { 'tpope/vim-commentary', event = 'VeryLazy' },
    { 'ntpeters/vim-better-whitespace', event = 'VeryLazy' },
    { 'kylechui/nvim-surround', version = '*', event = 'VeryLazy', opts = {} },
    { 'windwp/nvim-autopairs', event = 'InsertEnter', opts = { check_ts = true, enable_check_bracket_line = false } },
    { 'ziglang/zig.vim', event = 'VeryLazy' },
}
