local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	--------------------------------------------------------------------------------
	-- UI (Внешний вид и статусные строки)
	--------------------------------------------------------------------------------
	{
		"nvim-tree/nvim-web-devicons", -- Иконки для файлов и плагинов
	},

	{
		"rmehri01/onenord.nvim", -- Цветовая схема
		lazy = false, -- Загружается сразу
	},

	{
		"nvim-lualine/lualine.nvim", -- Статусная строка
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},

	{
		"akinsho/bufferline.nvim", -- Буферная строка/вкладки
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},

	{
		"sindrets/diffview.nvim", -- Просмотр изменений git
		dependencies = { "nvim-lua/plenary.nvim" },
	},

	{ "rhysd/conflict-marker.vim" }, -- Маркер конфликтов MERGE
	{ "lukas-reineke/indent-blankline.nvim" }, -- Вертикальные отступы (indent guides)

	--------------------------------------------------------------------------------
	-- Навигация и поиск
	--------------------------------------------------------------------------------
	{
		"nvim-tree/nvim-tree.lua", -- Проводник файлов
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},

	{ "majutsushi/tagbar" }, -- Навигация по тегам

	{
		"nvim-telescope/telescope.nvim", -- Мощный поиск и навигация
		version = "0.1.x",
		dependencies = { "nvim-lua/plenary.nvim" },
	},

	{
		"nvim-telescope/telescope-fzf-native.nvim", -- FZF фильтрация для Telescope (компиляция нужна)
		build = "make",
	},

	--------------------------------------------------------------------------------
	-- LSP, автодополнение и подсветка синтаксиса
	--------------------------------------------------------------------------------
	{
		"nvim-treesitter/nvim-treesitter", -- Парсер синтаксиса и подсветка
		build = ":TSUpdate",
		dependencies = { "OXY2DEV/markview.nvim" }, -- markview зависит от treesitter
	},

	{ "nvim-treesitter/playground" }, -- Отладчик деревьев дерева разбора

	{
		"nvim-treesitter/nvim-treesitter-textobjects", -- Текстовые объекты для treesitter
		dependencies = { "nvim-treesitter/nvim-treesitter" },
	},

	{ "onsails/lspkind.nvim" }, -- Иконки для LSP автодополнения
	{ "neovim/nvim-lspconfig" }, -- Конфигурация LSP
	{ "ray-x/lsp_signature.nvim" }, -- Подсказки аргументов функций
	{ "williamboman/mason.nvim" }, -- Менеджер LSP-серверов
	{ "williamboman/mason-lspconfig.nvim" },
	{ "WhoIsSethDaniel/mason-tool-installer.nvim" },

	{ "hrsh7th/nvim-cmp" }, -- Автодополнение
	{ "hrsh7th/cmp-nvim-lsp" },
	{ "hrsh7th/cmp-buffer" },
	{ "hrsh7th/cmp-cmdline" },
	{ "hrsh7th/cmp-nvim-lsp-signature-help" },
	{ "ray-x/cmp-treesitter" },
	{ "saadparwaiz1/cmp_luasnip" },

	{
		"tzachar/cmp-fuzzy-buffer", -- Фаззи автодополнение по буферу
		dependencies = { "hrsh7th/nvim-cmp", "tzachar/fuzzy.nvim" },
	},

	{
		"David-Kunz/cmp-npm", -- Автодополнение npm пакетов
		dependencies = { "nvim-lua/plenary.nvim" },
	},

	{ "hrsh7th/cmp-path" }, -- Автодополнение путей в файловой системе
	{ "L3MON4D3/LuaSnip" }, -- Snippet engine
	{ "b0o/schemastore.nvim" }, -- JSON schema для LSP

	--------------------------------------------------------------------------------
	-- LLM Kotype and Codify
	--------------------------------------------------------------------------------
	-- {
	-- 	"frankroeder/parrot.nvim",
	-- 	dependencies = { "ibhagwan/fzf-lua", "nvim-lua/plenary.nvim" },
	-- },
	{
		"yetone/avante.nvim",
		build = "make BUILD_FROM_SOURCE=true",
		-- build = "make",
		lazy = false,
		-- event = "VeryLazy",
		version = false, -- Never set this value to "*"! Never!
		git = { timeout = 3600 },
		---@module 'avante'
		---@type avante.Config
		opts = {
			behavior = { auto_suggestions = true, enable_cursor_planning_mode = true },
			hints = { enabled = true },
			provider = "kodify",
			providers = {
				kodify = {
					__inherited_from = "openai",
					endpoint = "https://demo1-fundres.dev.mts.ai/v1",
					api_path = "/chat/completions", -- путь (чаще всего не нужно указывать отдельно)
					api_key_name = "KODIFY_API_KEY",
					model = "kodify_2.0.1",
					enabled = true,
					timeout = 30000, -- Timeout in milliseconds
					disable_tools = true,
				},
			},
			default_provider = "kodify",
		},
		dependencies = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			--- The below dependencies are optional,
			"echasnovski/mini.pick", -- for file_selector provider mini.pick
			"nvim-telescope/telescope.nvim", -- for file_selector provider telescope
			"hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
			"ibhagwan/fzf-lua", -- for file_selector provider fzf
			"stevearc/dressing.nvim", -- for input provider dressing
			"folke/snacks.nvim", -- for input provider snacks
			"nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
			{
				-- support for image pasting
				"HakonHarnes/img-clip.nvim",
				event = "VeryLazy",
				opts = {
					-- recommended settings
					default = {
						embed_image_as_base64 = false,
						prompt_for_file_name = false,
						--
						drag_and_drop = {
							insert_mode = true,
						},
					},
				},
			},
			-- {
			-- 	-- Make sure to set this up properly if you have lazy=true
			-- 	"MeanderingProgrammer/render-markdown.nvim",
			-- 	opts = {
			-- 		file_types = { "markdown", "Avante" },
			-- 	},
			-- 	ft = { "markdown", "Avante" },
			-- },
		},
	},
	--------------------------------------------------------------------------------
	-- Рефакторинг и работа с кодом
	--------------------------------------------------------------------------------
	{
		"ThePrimeagen/refactoring.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter" },
	},

	{
		"kylechui/nvim-surround",
		version = "main",
		event = "VeryLazy",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
	},

	{ "numToStr/Comment.nvim" }, -- Комментарии блоков и строк
	{ "cohama/lexima.vim" }, -- Автоматическое закрытие скобок и кавычек

	--------------------------------------------------------------------------------
	-- Git и интеграция с системой контроля версий
	--------------------------------------------------------------------------------
	{ "lewis6991/gitsigns.nvim" }, -- Подсветка изменений в гите
	{
		"NeogitOrg/neogit",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
			"sindrets/diffview.nvim",
			"ibhagwan/fzf-lua",
		},
	},

	--------------------------------------------------------------------------------
	-- Утилиты и другое
	--------------------------------------------------------------------------------
	{ "neoclide/jsonc.vim" }, -- Поддержка JSON с комментариями
	{ "powerman/vim-plugin-ruscmd" }, -- Русские команды
	{ "Chiel92/vim-autoformat" }, -- Автоформатирование кода
	{ "tpope/vim-unimpaired" }, -- Дополнительные удобные команды и макросы
	{ "skanehira/translate.vim" }, -- Переводчик в Vim
	{ "nvim-lua/popup.nvim" }, -- Popup API
	{ "google/vim-searchindex" }, -- Индексы поиска
	{ "tpope/vim-repeat" }, -- Расширение повторения команд
	{ "b0o/mapx.nvim" }, -- Утилиты для сопоставления клавиш
	{ "tpope/vim-sensible" }, -- Базовые улучшения vim
	{ "f-person/auto-dark-mode.nvim" }, -- Автоматическая смена темы по времени суток
	{ "mhartington/formatter.nvim" }, -- Форматирование кода
	{ "nacro90/numb.nvim" }, -- Показывает номер строки при перемещении по файлу
	{ "stsewd/gx-extended.vim" }, -- Улучшения для gx
	{
		"kkoomen/vim-doge",
		build = ":call doge#install()",
	},
	{
		"folke/trouble.nvim",
		dependencies = "nvim-tree/nvim-web-devicons",
	},
	{ "folke/which-key.nvim" }, -- Подсказки для горячих клавиш
	{
		"weilbith/nvim-code-action-menu",
		cmd = "CodeActionMenu",
		config = function()
			require("code_action_menu")
		end,
	},
	{
		"kosayoda/nvim-lightbulb",
		dependencies = "antoinemadec/FixCursorHold.nvim",
	},
	{ "airblade/vim-rooter" }, -- Автоматический переход в корень проекта
	{ "terryma/vim-multiple-cursors" }, -- Мультикурсор

	{ "lewis6991/impatient.nvim" }, -- Ускорение загрузки nvim
	{ "dstein64/vim-startuptime" }, -- Анализатор времени запуска

	--------------------------------------------------------------------------------
	-- Тестирование
	--------------------------------------------------------------------------------
	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			"antoinemadec/FixCursorHold.nvim",
			"haydenmeade/neotest-jest",
			"nvim-neotest/nvim-nio",
		},
	},

	--------------------------------------------------------------------------------
	-- Специализированные плагины и инструменты
	--------------------------------------------------------------------------------
	{ "typed-rocks/ts-worksheet-neovim" }, -- Worksheet для TypeScript
	{ "gpanders/editorconfig.nvim" }, -- EditorConfig поддержка

	{
		"epwalsh/obsidian.nvim",
		dependencies = {
			"ibhagwan/fzf-lua",
			"preservim/vim-markdown",
			"godlygeek/tabular",
		},
	},
	{
		"OXY2DEV/markview.nvim", -- Просмотр меток (зависит от treesitter)
	},
})
