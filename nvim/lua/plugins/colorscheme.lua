return {
    'sainnhe/everforest',
    priority = 1000,
    init = function()
        vim.g.everforest_better_performance = 1
        vim.g.everforest_diagnostic_virtual_text = 'highlight'
    end,
    config = function()
        vim.cmd [[colorscheme everforest]]
        vim.api.nvim_set_hl(0, 'MatchParen', { fg = '#FF0000' })
    end,
}
