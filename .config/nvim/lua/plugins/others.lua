-----------------------------------------------------------
-- Инициализация плагинов (только уникальные настройки)
-----------------------------------------------------------
require("onenord").setup()

require("numb").setup()

require("nvim-lightbulb").setup({ autocmd = { enabled = true } })

require("Comment").setup()

require("nvim-web-devicons").setup()

require("tsw").setup({ show_variables = true, show_order = true })

-- Telescope + trouble
local trouble = require("trouble.sources.telescope")
require("telescope").setup({
	defaults = {
		mappings = {
			i = { ["<c-t>"] = trouble.open },
			n = { ["<c-t>"] = trouble.open },
		},
	},
})

require("trouble").setup()

require("which-key").setup()

require("mini.surround").setup()

-- Refactoring (если не настроен в другом месте)
require("refactoring").setup({})
