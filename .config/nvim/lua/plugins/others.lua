-----------------------------------------------------------
-- Инициализация плагинов (только уникальные настройки)
-----------------------------------------------------------
require("onenord").setup()
require("numb").setup()
require("nvim-lightbulb").setup({ autocmd = { enabled = true } })
require("tsw").setup({ show_variables = true, show_order = true })
require("trouble").setup()
