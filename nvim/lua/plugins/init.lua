local function keymaps()
    local wk = require('which-key')

    wk.setup {
        layout = { spacing = 1 },
        window = {
            border = 'single',
            margin = { 0, 0, 0, 0 },
            padding = { 0, 0, 0, 0 },
        },
    }

    wk.register({
        b = { '<Cmd>Telescope git_branches<CR>', 'Git Branches' },
        c = { '<Cmd>Telescope commands<CR>', 'Command List' },
        d = { '<Cmd>Telescope diagnostics<CR>', 'Diagnostic List' },
        g = { '<Cmd>Telescope live_grep<CR>', 'Live Grep' },
        h = { '<Cmd>Telescope command_history<CR>', 'Command History' },
        q = { [[ :pclose | cclose | lclose | helpclose<CR> ]], 'Close All Helper Windows' },
        s = { '<Cmd>Telescope git_status<CR>', 'Git Status' },
        t = { '<Cmd>StripWhitespace<CR>', 'Strip Whitespace' },
        T = { '<Cmd>Telescope treesitter<CR>', 'Treesitter Nodes' },
        ['.'] = { '<Cmd>Telescope find_files<CR>', 'Find Files' },
        ['/'] = { '<Cmd>Telescope current_buffer_fuzzy_find<CR>', 'Fuzzy Find in Buffer' },
        ['<Leader>'] = { '<Cmd>Telescope buffers<CR>', 'Buffer List' },
        ['['] = { vim.diagnostic.goto_prev, 'Previous Diagnostic' },
        [']'] = { vim.diagnostic.goto_next, 'Next Diagnostic' },
    }, { prefix = '<Leader>' })

    wk.register { ['\\'] = { ':noh<CR>', 'Clear Search Highlights' } }
    wk.register({
        ['<C-Space>'] = { '<C-X><C-O>', 'Completion' },
        ['<C-;>'] = { '<C-o>A;', 'Semicolon Insertion' },
    }, { mode = 'i' })
    wk.register({ ['<Esc>'] = { '<C-\\><C-n>', 'Leave Terminal Input Mode' } }, { mode = 't' })
end

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

    { 'folke/which-key.nvim', event = 'VeryLazy', config = keymaps },
    { 'tpope/vim-fugitive', cmd = 'Git' },
    { 'tpope/vim-commentary', event = 'VeryLazy' },
    { 'ntpeters/vim-better-whitespace', event = 'VeryLazy' },
    { 'kylechui/nvim-surround', version = '*', event = 'VeryLazy', opts = {} },
    { 'windwp/nvim-autopairs', event = 'InsertEnter', opts = { check_ts = true, enable_check_bracket_line = false } },
}
