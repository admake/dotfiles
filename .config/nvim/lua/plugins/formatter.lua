-----------------------------------------------------------
-- formatting
-----------------------------------------------------------

vim.env.PRETTIERD_LOCAL_PRETTIER_ONLY = 1

-- Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands
require("formatter").setup({
	-- Enable or disable logging
	logging = true,
	-- Set the log level
	log_level = vim.log.levels.INFO,
	-- All formatter configurations are opt-in
	filetype = {
		yaml = { require("formatter.defaults.prettier") },
		json = { require("formatter.defaults.prettier") },
		jsonc = { require("formatter.defaults.prettier") },
		typescript = { require("formatter.defaults.prettier") },
		javascript = { require("formatter.defaults.prettier") },
		markdown = { require("formatter.defaults.prettier") },
		lua = { require("formatter.filetypes.lua").stylua },
		python = { require("formatter.filetypes.python").black },
		sh = { require("formatter.filetypes.sh").shfmt },
		dockerfile = { require("formatter.filetypes.sh").shfmt },
		xml = { require("formatter.filetypes.xml").tidy },
		zsh = { require("formatter.filetypes.sh").shfmt },
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
