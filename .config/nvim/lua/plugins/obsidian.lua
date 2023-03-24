vim.g.vim_markdown_folding_disabled = 1

require("obsidian").setup({
	dir = "~/Documents/admakeye",
	completion = {
		nvim_cmp = true,
	},
})
