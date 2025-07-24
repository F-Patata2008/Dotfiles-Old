vim.keymap.set("n", "<C-s>", "<cmd>w<CR>", { noremap = true, silent = true, desc = "Save file" })
vim.keymap.set("n", "<C-q>", "<cmd>q<CR>", { noremap = true, silent = true, desc = "Quit file" })
vim.keymap.set("n", "<C-a>", "ggVG", { noremap = true, silent = true, desc = "Select all" })


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
