 return {
     {
   -- "goolord/alpha-nvim",
    -- dependencies = { 'echasnovski/mini.icons' },
    --dependencies = { 
      --  'nvim-tree/nvim-web-devicons',
        --'nvim-lua/plenary.nvim',

    --},


    --config = function()
      --  local alpha = require("alpha")
     -- local dashboard = require("alpha.themes.startify")

       -- dashboard.section.header.val = {
         --   [[███╗   ██╗███████╗ ██████╗       ██╗   ██╗██╗███╗   ███╗]],
           -- [[████╗  ██║██╔════╝██╔═══██╗      ██║   ██║██║████╗ ████║]],
         --   [[██╔██╗ ██║█████╗  ██║   ██║█████╗██║   ██║██║██╔████╔██║]],
           -- [[██║╚██╗██║██╔══╝  ██║   ██║╚════╝██║   ██║██║██║╚██╔╝██║]],
        --    [[██║ ╚████║███████╗╚██████╔╝      ╚██████╔╝██║██║ ╚═╝ ██║]],
          --  [[╚═╝  ╚═══╝╚══════╝ ╚═════╝        ╚═════╝ ╚═╝╚═╝     ╚═╝]],
       -- }

        --alpha.setup(dashboard.opts)
    --end,
   
   'goolord/alpha-nvim',
    dependencies = { 'echasnovski/mini.icons' },
    config = function ()
        require'alpha'.setup(require'alpha.themes.dashboard'.config)
    end
  },
 }
