local keys = {
    { '\\', ':noh<CR>', desc = 'Clear Search Highlights' },
    -- { '<Leader>b', '<Cmd>Telescope git_branches<CR>', desc = 'Git Branches' },
    -- { '<Leader>c', '<Cmd>Telescope commands<CR>', desc = 'Command List' },
    -- { '<Leader>g', '<Cmd>Telescope live_grep<CR>', desc = 'Live Grep' },
    -- { '<Leader>h', '<Cmd>Telescope command_history<CR>', desc = 'Command History' },
    -- { '<Leader>q', [[ :pclose | cclose | lclose | helpclose<CR> ]], desc = 'Close All Helper Windows' },
    -- { '<Leader>s', '<Cmd>Telescope git_status<CR>', desc = 'Git Status' },
    -- { '<Leader>t', '<Cmd>StripWhitespace<CR>', desc = 'Strip Whitespace' },
    -- { '<Leader>T', '<Cmd>Telescope treesitter<CR>', desc = 'Treesitter Nodes' },
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

    { 'tpope/vim-fugitive', cmd = 'Git' },
    { 'tpope/vim-commentary', event = 'VeryLazy' },
    { 'ntpeters/vim-better-whitespace', event = 'VeryLazy' },
    { 'kylechui/nvim-surround', version = '*', event = 'VeryLazy', opts = {} },
    { 'windwp/nvim-autopairs', event = 'InsertEnter', opts = { check_ts = true, enable_check_bracket_line = false } },
}
