local function keymaps()
    local wk = require('which-key')
    wk.setup()

    wk.register({
        b = { '<Cmd>Telescope git_branches<CR>', 'Git Branches' },
        c = { '<Cmd>Telescope commands<CR>', 'Command List' },
        d = { '<Cmd>Telescope diagnostics<CR>', 'Diagnostic List' },
        g = { '<Cmd>Telescope live_grep<CR>', 'Live Grep' },
        h = { '<Cmd>Telescope command_history<CR>', 'Command History' },
        -- m = { '<Cmd>Telescope marks<CR>', 'Mark List' },
        q = { [[ :pclose | cclose | lclose | helpclose<CR> ]], 'Close All Helper Windows' },
        -- r = { '<Cmd>Telescope registers<CR>', 'Register List' },
        s = { '<Cmd>Telescope git_status<CR>', 'Git Status' },
        t = { '<Cmd>Telescope treesitter<CR>', 'Treesitter Nodes' },
        ['.'] = { '<Cmd>Telescope find_files<CR>', 'Find Files' },
        ['/'] = { '<Cmd>Telescope current_buffer_fuzzy_find<CR>', 'Fuzzy Find in Buffer' },
        ['<Leader>'] = { '<Cmd>Telescope buffers<CR>', 'Buffer List' },
        ['['] = { vim.diagnostic.goto_prev, 'Previous Diagnostic' },
        [']'] = { vim.diagnostic.goto_next, 'Next Diagnostic' },
    }, { prefix = '<Leader>' })

    wk.register {
        ['\\'] = { ':noh<CR>', 'Clear Search Highlights' },
        ['<C-Space>'] = { '<C-X><C-O>', 'Completion', mode = 'i' },
        ['<Esc>'] = { '<C-\\><C-n>', 'Leave Terminal Input Mode', mode = 't' },
    }
end

return {
    {
        'sainnhe/everforest',
        priority = 1000,
        init = function()
            vim.g.everforest_better_performance = 1
            vim.g.everforest_diagnostic_virtual_text = 'highlight'
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
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end,
        config = keymaps,
        event = 'VeryLazy',
    },
    { 'tpope/vim-fugitive', cmd = 'Git' },
    { 'kylechui/nvim-surround', version = '*', event = 'VeryLazy', opts = {} },
    { 'echasnovski/mini.trailspace', event = 'BufWritePre', opts = {} },
    { 'echasnovski/mini.comment', opts = {}, keys = { { 'gc', mode = { 'n', 'v' } }, { 'gcc' } } },
    { 'windwp/nvim-autopairs', event = 'InsertEnter', opts = { check_ts = true } },
    { 'ziglang/zig.vim', ft = 'zig', init = function() vim.g.zig_fmt_autosave = 0 end },
}
