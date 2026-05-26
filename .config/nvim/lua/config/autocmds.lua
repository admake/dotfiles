-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Автоматически добавляет дату в формате "📅 ГГГГ-ММ-ДД" после ввода элемента чек-лиска в markdown файлах.
vim.api.nvim_create_autocmd("InsertCharPre", {
  pattern = { "*.md" }, -- Срабатывает только в markdown-файлах
  callback = function()
    local char = vim.v.char
    -- Проверяем, что нажат пробел и что перед ним уже введён шаблон "- [ ]"
    if char == " " then
      local line = vim.fn.getline(".")
      local col = vim.fn.col(".") - 2 -- Позиция перед введённым пробелом
      if col >= 5 and line:sub(col - 4, col) == "- [ ]" then
        -- Вставляем дату с нужным форматированием
        local date = os.date(" 📅 %Y-%m-%d")
        vim.api.nvim_put({ date }, "c", true, true)
      end
    end
  end,
})
