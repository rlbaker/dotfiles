return {
    {
        'mfussenegger/nvim-dap',
        ft = 'go',
        config = function()
            vim.keymap.set('n', '<LocalLeader>s', function() require('dap').step_over() end)
            vim.keymap.set('n', '<LocalLeader>i', function() require('dap').step_into() end)
            vim.keymap.set('n', '<LocalLeader>o', function() require('dap').step_out() end)
            vim.keymap.set('n', '<LocalLeader>b', function() require('dap').toggle_breakpoint() end)
            vim.keymap.set('n', '<LocalLeader>c', function() require('dap').continue() end)

            vim.keymap.set({ 'n', 'v' }, '<LocalLeader>e', function() require('dapui').eval() end)


            vim.keymap.set('n', '<LocalLeader>d', function()
                require('dapui').toggle()
            end)

            vim.keymap.set('n', '<LocalLeader>r', function()
                require('dapui').open()
                require('dap').continue()
            end)

            vim.keymap.set('n', '<LocalLeader>R', function()
                require('dapui').open()
                require('dap').run_last()
            end)

            vim.keymap.set('n', '<LocalLeader>q', function()
                require('dap').terminate()
                require('dapui').close()
            end)
        end,
    },
    { 'rcarriga/nvim-dap-ui', ft = 'go', opts = {} },
    { 'leoluz/nvim-dap-go', ft = 'go', opts = {} },
}
