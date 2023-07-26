return {
  -- {
  --   'sainnhe/gruvbox-material',
  --   lazy = false,
  --   priority = 1000,
  --   init = function()
  --     vim.g.gruvbox_material_disable_italic_comment = 1
  --     vim.g.gruvbox_material_better_performance = 1
  --     vim.g.gruvbox_material_diagnostic_virtual_text = 'colored'
  --   end,
  -- },
  {
    'sainnhe/everforest',
    lazy = true,
    priority = 1000,
    init = function()
      vim.g.everforest_background = 'hard'
      vim.g.everforest_better_performance = 1
      vim.g.everforest_diagnostic_virtual_text = 'colored'
    end,
  },
}
