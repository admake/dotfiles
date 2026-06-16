-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua

-- Add any additional keymaps here
-- Копировать выделенное в системный буфер
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', { desc = "Copy to System Clipboard" })
-- Вырезать выделенное в системный буфер
vim.keymap.set({ "n", "v" }, "<leader>d", '"+d', { desc = "Cut to System Clipboard" })
-- Вставить из системного буфера
vim.keymap.set({ "n", "v" }, "<leader>p", '"+p', { desc = "Paste from System Clipboard" })

-- ГАРАНТИРОВАННОЕ ОТКЛЮЧЕНИЕ СПЛИТОВ
-- Это удаляет сами "исходники", которые langmapper пытается переводить
vim.keymap.del("n", "<leader>|")
vim.keymap.del("n", "<leader>-")
vim.keymap.del("n", "<leader>_")

-- Теперь, когда <leader>| свободен, назначаем Grep вручную.
-- Используем vim.keymap.set, так как langmapper.hack_get_keymap()
-- всё равно его перехватит и сделает перевод для ru-раскладки.
vim.keymap.set("n", "<leader>/", function()
  require("snacks").picker.grep()
end, { desc = "Grep (Root Dir)" })
