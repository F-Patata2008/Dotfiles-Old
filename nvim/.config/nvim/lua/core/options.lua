vim.keymap.set('n', '<C-s>', ':w<CR>', {})
vim.keymap.set('n', '<C-q>', ':q<CR>', {})

return {
	ui = {
		icons = {
			ft = "󰧮",
			lazy = "󰂠",
			loaded = "",
			not_load = "",
		},
	},
}
