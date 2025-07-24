vim.keymap.set('n', '<C-s>', ':w<CR>', {})
vim.keymap.set('n', '<C-q>', ':q<CR>', {})


return {
    {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  },
  keys = {
    {
      "<space>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
  },
}
}
