-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

--  Орфография
vim.opt.spelllang = { "en_us", "ru" } -- языки для проверки орфографии

-- Настройки для плагина перевода (направление переводов)
vim.g.translate_source = "ru" -- исходный язык
vim.g.translate_target = "en" -- целевой язык

-- Настройка langmap для русской раскладки
local function escape(str)
  return str:gsub('([\\;," ])', "\\%1")
end
local ru = "ёйцукенгшщзхъфывапролджэячсмитьбю"
  .. "ЁЙЦУКЕНГШЩЗХЪФЫВАПРОЛДЖЭЯЧСМИТЬБЮ"
local en = "`qwertyuiop[]asdfghjkl;'zxcvbnm,." .. '~QWERTYUIOP{}ASDFGHJKL:"ZXCVBNM<>'
vim.opt.langmap = escape(ru) .. ";" .. escape(en)

-- In case you don't want to use `:LazyExtras`,
-- then you need to set the option below.
vim.g.lazyvim_picker = "snacks"
