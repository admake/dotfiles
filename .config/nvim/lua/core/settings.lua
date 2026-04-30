-- Направление перевода с русского на английский
vim.g.translate_source = "ru"
vim.g.translate_target = "en"

-- Полное отключение netrw (используется nvim-tree)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.netrw_scp_cmd = "scp -q -T"

-----------------------------------------------------------
-- Главные
-----------------------------------------------------------
vim.opt.colorcolumn = "120"
vim.opt.cursorline = true

vim.opt.spelllang = { "en_us", "ru" }

vim.opt.swapfile = false

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.undofile = true

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.mouse = "a"
vim.opt.autoread = true
vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "CursorHoldI", "FocusGained" }, {
	command = "if mode() != 'c' | checktime | endif",
	pattern = { "*" },
})

-- search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- backspace
vim.opt.backspace = "indent,eol,start"

-----------------------------------------------------------
-- Табы и отступы
---------------------------------------------------------
vim.cmd([[
filetype indent plugin on
syntax enable
]])
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.smartindent = true

-----------------------------------------------------------
-- Полезные фишки
-----------------------------------------------------------
vim.cmd([[
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
]])
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

vim.o.timeout = true
vim.o.timeoutlen = 300
