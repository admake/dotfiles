-----------------------------------------------------------
-- formatting
-----------------------------------------------------------

vim.env.PRETTIERD_LOCAL_PRETTIER_ONLY = 1

-- Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands
require("formatter").setup({
	-- Enable or disable logging
	logging = true,
	-- Set the log level
	-- log_level = vim.log.levels.DEBUG,
	-- All formatter configurations are opt-in
	filetype = {
		yaml = { require("formatter.defaults.prettierd") },
		json = { require("formatter.defaults.prettierd") },
		typescript = { require("formatter.defaults.prettierd") },
		javascript = { require("formatter.defaults.prettierd") },
		markdown = { require("formatter.defaults.prettierd") },
		lua = { require("formatter.filetypes.lua").stylua },
	},
})

-- Format on save
local fmtGroup = vim.api.nvim_create_augroup("FormatAutogroup", {
	clear = true,
})
vim.api.nvim_create_autocmd("BufWritePost", {
	command = ":FormatWrite",
	group = fmtGroup,
})

-- echo "$(cat ~/.prettierd | cut -d" " -f2) util.get_current_buffer_file_path()" | cat - util.get_current_buffer_file_path() | nc localhost $(cat ~/.prettierd | cut -d" " -f1) | sponge util.get_current_buffer_file_path()
