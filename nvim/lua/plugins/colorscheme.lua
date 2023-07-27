return {
  {
    'sainnhe/everforest',
    lazy = false,
    priority = 1000,
    init = function()
      vim.g.everforest_better_performance = 1
      vim.g.everforest_diagnostic_virtual_text = 'highlight'
    end,
  },
}
