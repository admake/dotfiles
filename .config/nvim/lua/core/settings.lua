-- Направление перевода с русского на английский
vim.g.translate_source = "ru"
vim.g.translate_target = "en"
-- Компактный вид у тагбара и Отк. сортировка по имени у тагбара
-- g.tagbar_compact = 1
-- g.tagbar_sort = 0

-- disable netrw at the very start of your init.lua (strongly advised)
-- because https://github.com/nvim-tree/nvim-tree.lua#setup
-- vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.netrw_browser_viewer = "open"

-----------------------------------------------------------
-- Главные
-----------------------------------------------------------
vim.opt.colorcolumn = "120" -- Разделитель на 80 символов
vim.opt.cursorline = true -- Подсветка строки с курсором

vim.opt.spelllang = { "en_us", "ru" } -- Словари рус eng

vim.opt.swapfile = false -- Выключить swapfiles

vim.opt.number = true -- Включаем нумерацию строк
vim.opt.relativenumber = true -- Вкл. относительную нумерацию строк
-- opt.so=999             -- Курсор всегда в центре экрана

vim.opt.undofile = true -- Возможность отката назад

vim.opt.splitright = true -- vertical split вправо
vim.opt.splitbelow = true -- horizontal split вниз

vim.opt.mouse = "a" -- включаем мышь
-- auto-reload files when modified externally
-- https://unix.stackexchange.com/a/383044
vim.opt.autoread = true
vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "CursorHoldI", "FocusGained" }, {
	command = "if mode() != 'c' | checktime | endif",
	pattern = { "*" },
})

-- search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- backspace
vim.opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position

-----------------------------------------------------------
-- Табы и отступы
---------------------------------------------------------
vim.cmd([[
filetype indent plugin on
syntax enable
]])
vim.opt.expandtab = true -- use spaces instead of tabs
vim.opt.shiftwidth = 4 -- shift 4 spaces when tab
vim.opt.tabstop = 4 -- 1 tab == 4 spaces
vim.opt.smartindent = true -- autoindent new lines

-----------------------------------------------------------
-- Полезные фишки
-----------------------------------------------------------
-- Запоминает где nvim последний раз редактировал файл
vim.cmd([[
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
]])
-- Подсвечивает на доли секунды скопированную часть текста
vim.api.nvim_exec(
	[[
augroup YankHighlight
autocmd!
autocmd TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=700}
augroup end
]],
	false
)

vim.opt.completeopt = { "menu", "menuone", "noselect" }
