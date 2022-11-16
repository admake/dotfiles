require("nvim-tree").setup({
	diagnostics = {
		enable = true,
	},
	filters = {
		dotfiles = true,
	},
	git = {
		ignore = true,
	},
})
