local keys = {
    { '<Leader>.', '<Cmd>Telescope find_files<CR>', desc = 'Find Files' },
    { '<Leader>/', '<Cmd>Telescope current_buffer_fuzzy_find<CR>', desc = 'Fuzzy Find in Buffer' },
    { '<Leader><Leader>', '<Cmd>Telescope buffers<CR>', desc = 'Buffer List' },
    { '<Leader>d', '<Cmd>Telescope diagnostics<CR>', desc = 'Diagnostic List' },

    { '<Leader>[', vim.diagnostic.goto_prev, desc = 'Previous Diagnostic' },
    { '<Leader>]', vim.diagnostic.goto_next, desc = 'Next Diagnostic' },
    { '<Leader>q', [[ :pclose | cclose | lclose | helpclose<CR> ]], desc = 'Close All Helper Windows' },
    { '<Leader>s', function() MiniTrailspace.trim() end, desc = 'Trim Trailing Whitespace' },
    { '\\', ':noh<CR>', desc = 'Clear Search Highlights' },
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
            -- vim.api.nvim_set_hl(0, 'MatchParen', { bg = '#FF0000' })
        end,
    },

    { 'nvim-tree/nvim-web-devicons', lazy = true },
    { 'folke/which-key.nvim', event = 'VeryLazy', opts = { spec = keys } },

    {
        'nvim-lualine/lualine.nvim',
        event = 'VeryLazy',
        opts = { sections = { lualine_x = { 'encoding', 'filetype' } } },
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
                auto_install = true,
                ensure_installed = { 'bash', 'fish', 'go', 'lua', 'vim' },
                highlight = { enable = true },
                endwise = { enable = true },
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = '<Leader><Up>',
                        node_incremental = '<Leader><Up>',
                        -- scope_incremental = '<Leader>ts',
                        node_decremental = '<Leader><Down>',
                    },
                },
            }
            vim.wo.foldmethod = 'expr'
            vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
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
        event = 'VeryLazy',
        config = function()
            local telescope = require('telescope')
            telescope.setup {
                defaults = {
                    layout_strategy = 'vertical',
                    -- layout_config = { prompt_position = 'top' },
                    mappings = {
                        i = { ['<ESC>'] = require('telescope.actions').close },
                    },
                    -- sorting_strategy = 'ascending',
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

    { 'echasnovski/mini.comment', event = 'VeryLazy', opts = {} },
    { 'echasnovski/mini.trailspace', event = 'VeryLazy', opts = {} },
    {
        'windwp/nvim-autopairs',
        event = { 'InsertEnter', 'CmdlineEnter' },
        opts = { check_ts = true, disable_in_visualblock = true },
    },
    { 'kylechui/nvim-surround', event = 'VeryLazy', opts = {} },
    { 'tpope/vim-fugitive', cmd = 'Git' },
    { 'HiPhish/rainbow-delimiters.nvim' },
    { 'tikhomirov/vim-glsl' },
    { 'Apeiros-46B/uiua.vim', config = function() vim.g.uiua_format_on_save = false end },
    {
        'kosayoda/nvim-lightbulb',
        opts = {
            autocmd = { enabled = true },
            sign = { enabled = false },
            virtual_text = { enabled = true },
        },
    },
}
