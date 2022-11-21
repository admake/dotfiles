-----------------------------------------------------------
-- Инициализация плагинов
-----------------------------------------------------------
require("onenord").setup()

require("gitsigns").setup()

-- numb navigate preview
require("numb").setup()

-- bulb code actions like vscode
require("nvim-lightbulb").setup({ autocmd = { enabled = true } })

require("Comment").setup()

require("nvim-web-devicons").setup()

require("trouble").setup({
	-- your configuration comes here
	-- or leave it empty to use the default settings
	-- refer to the configuration section below
})
