return {
    -- Hardhacker theme
    {
        "hardhackerlabs/theme-vim",
        name = "hardhacker",
        lazy = true, -- Load only when needed
        config = function()
            vim.g.hardhacker_hide_tilde = 1
            vim.g.hardhacker_keyword_italic = 1
            vim.g.hardhacker_custom_highlights = {}
        end
    },

    -- Catppuccin theme (default)
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        lazy = false,
        config = function()
            require("catppuccin").setup({
                flavour = "mocha",
                transparent_background = true,
                term_colors = true,
                styles = {
                    comments = { "italic" },
                    functions = { "italic" },
                    keywords = { "italic" },
                    variables = { "italic" },
                },
                integrations = {
                    treesitter = true,
                    telescope = true,
                    gitsigns = true,
                    lsp_trouble = true,
                    cmp = true,
                    which_key = true,
                    dashboard = true,
                    neotree = true,
                },
            })
            vim.cmd.colorscheme("catppuccin")
        end
    },

    -- Autocommand to switch to hardhacker for LaTeX
    {
        "nvim-lua/plenary.nvim", -- dummy dependency to inject our logic
        config = function()
            vim.api.nvim_create_autocmd("FileType", {
                pattern = "tex",
                callback = function()
                    require("lazy").load({ plugins = { "hardhacker" } })
                    vim.cmd("colorscheme hardhacker")

                    -- Make it transparent
                    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
                    vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
                    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
                    vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none" })
                    vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = "none" })
                    vim.api.nvim_set_hl(0, "TelescopeBorder", { bg = "none" })
                    vim.api.nvim_set_hl(0, "NvimTreeNormal", { bg = "none" })
                    vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none" })
                end,
            })
        end,
    }
}

