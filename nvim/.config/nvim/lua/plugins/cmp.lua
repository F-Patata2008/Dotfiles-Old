return {
    {
        "L3MON4D3/LuaSnip",
        dependencies = {
            "saadparwaiz1/cmp_luasnip",
            "rafamadriz/friendly-snippets",
            "evesdropper/luasnip-latex-snippets.nvim",
        },
    },
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "onsails/lspkind.nvim", -- 💡 Icons support
        },
        config = function()
            local cmp = require('cmp')
            local lspkind = require('lspkind') -- load lspkind

            require("luasnip.loaders.from_vscode").lazy_load()
            require("luasnip.loaders.from_lua").lazy_load({
                paths = vim.fn.stdpath('config') .. "/lua/snippets/" 
            })

            cmp.setup({
                snippet = {
                    expand = function(args)
                        require('luasnip').lsp_expand(args.body)
                    end
                },
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
                mapping = cmp.mapping.preset.insert({
                    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<C-e>'] = cmp.mapping.abort(),
                    ['<CR>'] = cmp.mapping.confirm({ select = true }),
                    ['<Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif require('luasnip').expand_or_jumpable() then
                            require('luasnip').expand_or_jump()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),

                    ['<S-Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif require('luasnip').jumpable(-1) then
                            require('luasnip').jump(-1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),

                }),
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' },
                }, {
                    { name = 'buffer' },
                }),
                formatting = {
                    format = lspkind.cmp_format({
                        mode = 'symbol_text', -- "symbol" or "symbol_text" or "text"
                        maxwidth = 50,
                        ellipsis_char = '...',
                        menu = {
                            nvim_lsp = "[LSP]",
                            luasnip = "[Snip]",
                            buffer = "[Buf]",
                            path = "[Path]",
                        }
                    }),
                },
            })

            -- LaTeX compile shortcut
            vim.keymap.set('n', '<C-l>', '<Cmd>VimtexCompile<CR>', {
                noremap = true,
                silent = true,
                desc = "Compile LaTeX (Vimtex)"
            })
        end
    }
}

