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

-- HACK: to trigger on every ASCII char, unicode will work when the upstream neovim completion respects isIncomplete field properly
local chars = {}
for i = 32, 126 do
  table.insert(chars, string.char(i))
end

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    local buf = ev.buf
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client and client.name == "obsidian-ls" then
      client.server_capabilities.completionProvider.triggerCharacters = chars -- HACK:
      vim.bo[buf].completeopt = "menuone,noselect,fuzzy,nosort" -- noselect to make sure no accidentally accept and create new notes, others are not strictly necessary, adjust to your taste, see `:h completeopt'
      vim.lsp.completion.enable(true, client.id, buf, { autotrigger = true })
    end
  end,
})
