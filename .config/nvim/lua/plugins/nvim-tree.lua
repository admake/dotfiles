require("nvim-tree").setup({
	update_focused_file = { enable = true },
	hijack_cursor = true,
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
