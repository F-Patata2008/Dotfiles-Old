return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls", "pyright", "clangd", "texlab"
				}
			})
		end
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local lspconfig = require("lspconfig")
            local capabilities = require('cmp_nvim_lsp').default_capabilities()
			--lspconfig.lua_ls.setup({})
			lspconfig.pyright.setup({
                capabilities = capabilities
            })
            lspconfig.texlab.setup({
                capabilities = capabilities
            })
			lspconfig.clangd.setup({
                capabilities = capabilities
            })
			vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})

			vim.keymap.set("n", "<space>gd", vim.lsp.buf.definition, {})
			vim.keymap.set("n", "<space>gr", vim.lsp.buf.references, {})
			vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, {})
            vim.diagnostic.config({
                virtual_text = true,
                signs = false,
                underline = true,
            })
		end
	}
}
