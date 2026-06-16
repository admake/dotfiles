-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Default clipboard buffer
vim.opt.clipboard = ""

--
vim.o.winborder = "single"

--  Орфография
vim.opt.spelllang = { "en_us", "ru" } -- языки для проверки орфографии

-- Настройка langmap для русской раскладки
local function escape(str)
  return str:gsub('([\\;," ])', "\\%1")
end
local ru = "ёйцукенгшщзхъфывапролджэячсмитьбю"
  .. "ЁЙЦУКЕНГШЩЗХЪФЫВАПРОЛДЖЭЯЧСМИТЬБЮ"
-- .. ".,"
local en = "`qwertyuiop[]asdfghjkl;'zxcvbnm,." .. '~QWERTYUIOP{}ASDFGHJKL:"ZXCVBNM<>' -- [[ .. "/?" ]]
vim.opt.langmap = escape(ru) .. ";" .. escape(en)

--------------------------------------------------------------------------------
-- АВТОМАТИЧЕСКАЯ РАСКЛАДКА ДЛЯ КОМАНДНОГО РЕЖИМА (:)
--------------------------------------------------------------------------------

local ru_str =
  "ёйцукенгшщзхъфывапролджэячсмитьбюЁЙЦУКЕНГШЩЗХЪФЫВАПРОЛДЖЭЯЧСМИТЬБЮ"
local en_str = "`qwertyuiop[]asdfghjkl;'zxcvbnm,." .. '~QWERTYUIOP{}ASDFGHJKL:"ZXCVBNM<>'

-- Безопасно разбиваем UTF-8 строки на отдельные символы
local ru_chars = {}
for char in ru_str:gmatch("[%z\1-\127\194-\244][\128-\191]*") do
  table.insert(ru_chars, char)
end

local en_chars = {}
for char in en_str:gmatch("[%z\1-\127\194-\244][\128-\191]*") do
  table.insert(en_chars, char)
end

-- Создаем карту соответствий
local ru_to_en = {}
for i = 1, #ru_chars do
  ru_to_en[ru_chars[i]] = en_chars[i]
end

-- Регистрируем маппинги для командного режима
for ru_char, en_char in pairs(ru_to_en) do
  vim.keymap.set("c", ru_char, function()
    -- Проверяем, что мы находимся именно в режиме ввода команд (:), а не поиска (/ или ?)
    if vim.fn.getcmdtype() == ":" then
      local cmdline = vim.fn.getcmdline()

      -- Шаблон "терминаторов" команды. Если в строке уже есть пробел, слэш,
      -- кавычка, восклицательный знак или пайп — значит, имя команды закончено
      -- и начались её аргументы. Перевод отключается.
      if not cmdline:match('[ /\\?!"|]') then
        return en_char
      end
    end
    -- Во всех остальных случаях возвращаем родной русский символ
    return ru_char
  end, { expr = true, replace_keycodes = false })
end

-- In case you don't want to use `:LazyExtras`,
-- then you need to set the option below.
vim.g.lazyvim_picker = "snacks"

vim.g.loaded_perl_provider = 0
