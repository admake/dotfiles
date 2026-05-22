require("nvim-tree").setup({
	hijack_netrw = true, -- Явно включаем перехват
	disable_netrw = true,
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
	renderer = {
		icons = {
			show = {
				file = true,
				folder = true,
				folder_arrow = true,
				git = true,
			},
		},
	},
})
