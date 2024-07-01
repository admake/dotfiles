-----------------------------------------------------------
-- Инициализация плагинов
-----------------------------------------------------------
require("onenord").setup()

-- numb navigate preview
require("numb").setup()

-- bulb code actions like vscode
require("nvim-lightbulb").setup({ autocmd = { enabled = true } })

require("Comment").setup()

require("nvim-web-devicons").setup()

-- local actions = require("telescope.actions")
local trouble = require("trouble.sources.telescope")

require("telescope").setup({
	defaults = {
		mappings = {
			i = { ["<c-t>"] = trouble.open },
			n = { ["<c-t>"] = trouble.open },
		},
	},
})

require("trouble").setup({})

require("which-key").setup({})
