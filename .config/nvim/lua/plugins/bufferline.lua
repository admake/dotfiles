-- require("bufferline").setup({})
require("bufferline").setup({
	options = {
		mode = "tabs", -- "buffers"
		diagnostics = "nvim_lsp",
		diagnostics_indicator = function(count, level)
			local icon = level:match("error") and "✘ " or "▲ "
			return " " .. icon .. count
		end,
		offsets = {
			{
				filetype = "NvimTree",
				text = function()
					return vim.fn.getcwd()
				end,
				highlight = "Directory",
				text_align = "left",
			},
		},
	},
})
