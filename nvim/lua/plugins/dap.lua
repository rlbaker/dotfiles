return {
    { 'mfussenegger/nvim-dap', lazy = true },
    { 'leoluz/nvim-dap-go', lazy = true, opts = {} },
    {
        'rcarriga/nvim-dap-ui',
        keys = {
            '<LocalLeader>d',
            '<LocalLeader>c',
            '<LocalLeader>r',
            '<LocalLeader>b',
        },
        dependencies = {
            'mfussenegger/nvim-dap',
            'leoluz/nvim-dap-go',
        },
        config = function()
            vim.opt.signcolumn = 'yes'
            local dap = require('dap')
            local dapui = require('dapui')

            dapui.setup()

            vim.keymap.set('n', '<LocalLeader>c', function() dap.continue() end)
            vim.keymap.set('n', '<LocalLeader>s', function() dap.step_over() end)
            vim.keymap.set('n', '<LocalLeader>i', function() dap.step_into() end)
            vim.keymap.set('n', '<LocalLeader>o', function() dap.step_out() end)
            vim.keymap.set('n', '<LocalLeader>b', function() dap.toggle_breakpoint() end)
            vim.keymap.set({ 'n', 'v' }, '<LocalLeader>e', function() dapui.eval() end)
            vim.keymap.set('n', '<LocalLeader>d', function() dapui.toggle() end)
            vim.keymap.set('n', '<LocalLeader>R', function() dap.run_last() end)
            vim.keymap.set('n', '<LocalLeader>r', function()
                dapui.open()
                dap.continue()
            end)
            vim.keymap.set('n', '<LocalLeader>q', function()
                dap.terminate()
                dapui.close()
            end)
        end,
    },
}
