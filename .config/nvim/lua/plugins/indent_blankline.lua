vim.opt.list = true
vim.opt.listchars:append("space:⋅")

require("ibl").setup({
	indent = {
		char = "│",
		smart_indent_cap = true,
	},
	scope = {
		enabled = true,
		show_start = true,
		show_end = false,
	},
})
