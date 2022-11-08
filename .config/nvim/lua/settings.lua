local cmd = vim.cmd -- execute Vim commands
local api = vim.api -- execute Vim api
local exec = vim.api.nvim_exec -- execute Vimscript
local g = vim.g -- global variables
local opt = vim.opt -- global/buffer/windows-scoped options
-- Направление перевода с русского на английский
g.translate_source = "ru"
g.translate_target = "en"
-- Компактный вид у тагбара и Отк. сортировка по имени у тагбара
-- g.tagbar_compact = 1
-- g.tagbar_sort = 0

-----------------------------------------------------------
-- Главные
-----------------------------------------------------------
opt.colorcolumn = "120" -- Разделитель на 80 символов
opt.cursorline = true -- Подсветка строки с курсором
opt.spelllang = { "en_us", "ru" } -- Словари рус eng
opt.swapfile = false -- Выключить swapfiles
opt.number = true -- Включаем нумерацию строк
opt.relativenumber = true -- Вкл. относительную нумерацию строк
-- opt.so=999                          -- Курсор всегда в центре экрана
opt.undofile = true -- Возможность отката назад
opt.splitright = true -- vertical split вправо
opt.splitbelow = true -- horizontal split вниз
opt.mouse = "a" -- включаем мышь
-- auto-reload files when modified externally
-- https://unix.stackexchange.com/a/383044
vim.o.autoread = true
-- api.nvim_create_autocmd({ "BufEnter", "CursorHold", "CursorHoldI", "FocusGained" }, {
-- 	command = "if mode() != 'c' | checktime | endif",
-- 	pattern = { "*" },
-- })
-----------------------------------------------------------
-- Цветовая схема
-----------------------------------------------------------
opt.termguicolors = true --  24-bit RGB colors
require("onenord").setup()
require("lualine").setup({
	options = {
		theme = "onenord",
	},
})
-----------------------------------------------------------
-- Табы и отступы
-----------------------------------------------------------
cmd([[
filetype indent plugin on
syntax enable
]])
opt.expandtab = true -- use spaces instead of tabs
opt.shiftwidth = 4 -- shift 4 spaces when tab
opt.tabstop = 4 -- 1 tab == 4 spaces
opt.smartindent = true -- autoindent new lines
-- don't auto commenting new lines
-- cmd([[au BufEnter * set fo-=c fo-=r fo-=o]])
-- remove line lenght marker for selected filetypes
-- cmd [[autocmd FileType text,markdown,html,xhtml,javascript setlocal cc=0]]
-- 2 spaces for selected filetypes
-- cmd [[
-- autocmd FileType xml,html,xhtml,css,scss,javascript,lua,yaml,htmljinja setlocal shiftwidth=2 tabstop=2
-- ]]
-- С этой строкой отлично форматирует html файл, который содержит jinja2
-- cmd [[ autocmd BufNewFile,BufRead *.html set filetype=htmldjango ]]
-----------------------------------------------------------
-- Полезные фишки
-----------------------------------------------------------
-- Запоминает где nvim последний раз редактировал файл
-- cmd [[
-- autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
-- ]]
-- Подсвечивает на доли секунды скопированную часть текста
exec(
	[[
augroup YankHighlight
autocmd!
autocmd TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=700}
augroup end
]],
	false
)

-- GitBlame enable
-- g.blamer_enabled = 1

local _border = "single"

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
	border = _border,
})

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
	border = _border,
})

vim.diagnostic.config({
	float = { border = _border },
})

-----------------------------------------------------------
-- Инициализация плагинов
-----------------------------------------------------------
-- require("impatient").enable_profile()

require("bufferline").setup({
	options = {
		diagnostics = "nvim_lsp",
		-- show_tab_indicators = true,
		-- show_buffer_icons = true,
		-- show_buffer_close_icons = true,
		-- show_buffer_default_icon = true,
		-- color_icons = true,
		-- diagnostics_indicator = function(count, level)
		-- 	local icon = level:match("error") and "✘ " or "▲ "
		-- 	return " " .. icon .. count
		-- end,
		-- hover = {
		-- 	enabled = true,
		-- 	delay = 200,
		-- 	reveal = { "close" },
		-- },
		offsets = {
			{
				filetype = "NvimTree",
				text = function()
					return vim.fn.getcwd()
				end,
				highlight = "Directory",
				text_align = "left",
			},
		},
	},
})

require("nvim-tree").setup({
	diagnostics = {
		enable = true,
	},
	filters = {
		dotfiles = true,
	},
	git = {
		ignore = true,
	},
})

require("refactoring").setup({})

require("cmp-npm").setup({})

-- nvim-cmp supports additional completion capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
vim.o.completeopt = "menuone,noselect"
vim.opt.completeopt = { "menu", "menuone", "noselect" }
-- luasnip setup
local luasnip = require("luasnip")
require("luasnip.loaders.from_vscode").lazy_load()
-- nvim-cmp setup
local cmp = require("cmp")
local lspkind = require("lspkind")
local compare = require("cmp.config.compare")
local select_opts = { behavior = cmp.SelectBehavior.Select }
cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	mapping = cmp.mapping.preset.insert({
		-- Move between completion items.
		["<Up>"] = cmp.mapping.select_prev_item(select_opts),
		["<Down>"] = cmp.mapping.select_next_item(select_opts),

		["<C-p>"] = cmp.mapping.select_prev_item(select_opts),
		["<C-n>"] = cmp.mapping.select_next_item(select_opts),

		-- Scroll text in the documentation window.
		["<C-u>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),

		-- Confirm selection.
		["<C-Space>"] = cmp.mapping.complete(),

		-- Cancel completion.
		["<C-e>"] = cmp.mapping.abort(),

		-- Confirm selection.
		["<CR>"] = cmp.mapping.confirm({
			select = true,
		}), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
		["<C-d>"] = cmp.mapping(function(fallback)
			if luasnip.jumpable(1) then
				luasnip.jump(1)
			else
				fallback()
			end
		end, { "i", "s" }),
		["<C-b>"] = cmp.mapping(function(fallback)
			if luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),

		-- Autocomplete with tab.
		-- If the completion menu is visible, move to the next item.
		-- If the line is "empty", insert a Tab character.
		-- If the cursor is inside a word, trigger the completion menu.
		["<Tab>"] = cmp.mapping(function(fallback)
			local col = vim.fn.col(".") - 1

			if cmp.visible() then
				cmp.select_next_item(select_opts)
			elseif col == 0 or vim.fn.getline("."):sub(col, col):match("%s") then
				fallback()
			else
				cmp.complete()
			end
		end, { "i", "s" }),

		-- If the completion menu is visible, move to the previous item.
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item(select_opts)
			else
				fallback()
			end
		end, { "i", "s" }),
	}),
	sources = {
		{
			name = "nvim_lsp",
			priority = 9,
		},
		{
			name = "luasnip",
			priority = 8,
		},
		{
			name = "treesitter",
			priority = 7,
		},
		{
			name = "nvim_lsp_signature_help",
			priority = 6,
		},
		{
			name = "path",
			priority = 5,
		},
		{
			name = "buffer",
			option = {
				get_bufnrs = function()
					return api.nvim_list_bufs()
				end,
			},
			priority = 4,
		},
		{
			name = "fuzzy_buffer",
			priority = 4,
		},
		{
			name = "npm",
			priority = 4,
			keyword_length = 4,
		},
	},
	sorting = {
		priority_weight = 1.0,
		comparators = {
			-- compare.score_offset, -- not good at all
			compare.score, -- based on :  score = score + ((#sources - (source_index - 1)) * sorting.priority_weight)
			compare.recently_used,
			compare.locality,
			compare.order,
			compare.offset,
			require("cmp_fuzzy_buffer.compare"),
			-- compare.scopes, -- what?
			-- compare.sort_text,
			-- compare.kind,
			-- compare.length, -- useless
			-- compare.offset,
			-- compare.exact,
			-- compare.score,
			-- compare.recently_used,
			-- compare.order,
		},
	},
	formatting = {
		format = lspkind.cmp_format({
			mode = "symbol_text", -- show only symbol annotations
			maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)

			-- The function below will be called before any actual modifications from lspkind
			-- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
			before = function(entry, vim_item)
				-- ...
				return vim_item
			end,
		}),
	},
})
cmp.setup.cmdline("/", {
	sources = cmp.config.sources({
		{ name = "fuzzy_buffer" },
	}),
})

require("lspconfig").tsserver.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})
require("lspconfig").marksman.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})
require("lspconfig").yamlls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		yaml = {
			schemas = {
				["https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json"] = ".gitlab-ci.{yml,yaml}",
				["https://json.schemastore.org/package.json"] = "package.json",
			},
		},
	},
})
require("lspconfig").sumneko_lua.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		Lua = {
			runtime = {
				-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
				version = "LuaJIT",
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { "vim" },
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = api.nvim_get_runtime_file("", true),
			},
			-- Do not send telemetry data containing a randomized but unique identifier
			telemetry = {
				enable = false,
			},
		},
	},
})
require("lspconfig").eslint.setup({
	lintCommand = "eslint_d -f unix --stdin --stdin-filename ${INPUT}",
	lintStdin = true,
	lintFormats = { "%f:%l:%c: %m" },
	lintIgnoreExitCode = true,
	formatCommand = "eslint_d --fix-to-stdout --stdin --stdin-filename=${INPUT}",
	formatStdin = true,
	quiet = true,
})

-----------------------------------------------------------
-- Change diagnostic icons
-----------------------------------------------------------

local sign = function(opts)
	vim.fn.sign_define(opts.name, {
		texthl = opts.name,
		text = opts.text,
		numhl = "",
	})
end

sign({
	name = "DiagnosticSignError",
	text = "✘",
})
sign({
	name = "DiagnosticSignWarn",
	text = "▲",
})
sign({
	name = "DiagnosticSignHint",
	text = "⚑",
})
sign({
	name = "DiagnosticSignInfo",
	text = "",
})

-----------------------------------------------------------
-- diagnostic config
-----------------------------------------------------------
vim.diagnostic.config({
	virtual_text = false,
	severity_sort = true,
	-- float = {
	--     border = 'rounded',
	--     source = 'always',
	--     header = '',
	--     prefix = ''
	-- }
})

-- defaults
-- {
--     virtual_text = true,
--     signs = true,
--     update_in_insert = false,
--     underline = true,
--     severity_sort = false,
--     float = true
-- }

-----------------------------------------------------------
-- formatting
-----------------------------------------------------------
-- Utilities for creating configurations

-- local util = require("formatter.util")

-- local function get_prettierd_env(path)
-- 	local open = io.open

-- 	local function read_file(path)
-- 		local file = open(path, "r") -- r read mode and b binary mode
-- 		if not file then
-- 			return nil
-- 		end
-- 		local content = file:read("*a") -- *a or *all reads the whole file
-- 		file:close()
-- 		return content
-- 	end

-- 	local function get_port_token(line)
-- 		local result = {}
-- 		for value in string.gmatch(line, "%S+") do
-- 			table.insert(result, value)
-- 		end

-- 		return result[1], result[2]
-- 	end

-- 	local fileContent = read_file(path)
-- 	local port, token = get_port_token(fileContent)
-- 	print(port, token)
-- end

-- local port, token = get_prettierd_env("/Users/admakeye/.prettierd")

vim.env.PRETTIERD_LOCAL_PRETTIER_ONLY = 1

-- Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands
require("formatter").setup({
	-- Enable or disable logging
	logging = true,
	-- Set the log level
	-- log_level = vim.log.levels.DEBUG,
	-- All formatter configurations are opt-in
	filetype = {
		yaml = { require("formatter.defaults.prettierd") },
		json = { require("formatter.defaults.prettierd") },
		typescript = { require("formatter.defaults.prettierd") },
		javascript = { require("formatter.defaults.prettierd") },
		markdown = { require("formatter.defaults.prettierd") },
		lua = { require("formatter.filetypes.lua").stylua },
	},
	-- echo "$(cat ~/.prettierd | cut -d" " -f2) util.get_current_buffer_file_path()" | cat - util.get_current_buffer_file_path() | nc localhost $(cat ~/.prettierd | cut -d" " -f1) | sponge util.get_current_buffer_file_path()
})

-- Format on save
local fmtGroup = api.nvim_create_augroup("FormatAutogroup", {
	clear = true,
})
api.nvim_create_autocmd("BufWritePost", {
	command = ":FormatWrite",
	group = fmtGroup,
})

-- Jest
-- require("jester").setup({
-- 	cmd = "npm test --",
-- 	cmd = "npm test -- -t '$result' -- $file",
-- 	path_to_jest_run = "jest",
-- 	path_to_jest_debug = "./node_modules/bin/jest",
-- })

-- Smooth scroll
require("neoscroll").setup({
	mappings = { "<C-u>", "<C-d>", "<C-b>", "<C-f>", "<C-y>", "<C-e>", "zt", "zz", "zb" },
	easing_function = "sine",
	-- easing_function = "quintic",
})

-- numb navigate preview
require("numb").setup()

-- bulb code actions like vscode
require("nvim-lightbulb").setup({ autocmd = { enabled = true } })
