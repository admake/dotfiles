vim.g.markview_blink_loaded = true
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
	-- Глобальные настройки ленивой загрузки
	defaults = { lazy = true },
	performance = {
		cache = { enabled = true },
		rtp = {
			disabled_plugins = {
				"gzip",
				"matchit",
				"matchparen",
				"netrwPlugin",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
			},
		},
	},

	--------------------------------------------------------------------------------
	-- UI (Внешний вид и статусные строки)
	--------------------------------------------------------------------------------
	{
		"gbprod/nord.nvim",
		lazy = true,
	},
	{ "fcancelinha/nordern.nvim", lazy = true },
	{
		"rmehri01/onenord.nvim",
		lazy = false,
		priority = 1000,
	},
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
	},
	{
		"akinsho/bufferline.nvim",
		event = "VeryLazy",
	},
	{
		"sindrets/diffview.nvim",
		cmd = "DiffviewOpen",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	{ "rhysd/conflict-marker.vim", event = "VeryLazy" },
	{ "xzbdmw/colorful-menu.nvim" },

	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		opts = {
			bigfile = { enabled = true },
			dashboard = { enabled = true },
			indent = { enabled = true }, -- Заменяет indent-blankline
			input = { enabled = true }, -- Заменяет dressing.nvim
			notifier = { enabled = true },
			scope = { enabled = true },
			words = { enabled = true },
			picker = { enabled = true },
		},
	},
	{
		"stevearc/oil.nvim",
		cmd = "Oil",
		opts = {},
	},
	{
		"echasnovski/mini.nvim",
		version = false,
		config = function()
			require("mini.pairs").setup() -- Заменяет nvim-autopairs
			require("mini.ai").setup() -- Улучшенные текстовые объекты
			require("mini.surround").setup()
			require("mini.icons").setup()
			require("mini.icons").mock_nvim_web_devicons() -- Имитируем старый плагин
		end,
	},

	--------------------------------------------------------------------------------
	-- Навигация и поиск
	--------------------------------------------------------------------------------
	{
		"nvim-tree/nvim-tree.lua",
		cmd = "NvimTreeToggle",
	},

	--------------------------------------------------------------------------------
	-- LSP, автодополнение и подсветка синтаксиса
	--------------------------------------------------------------------------------
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		priority = 50,
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.config").setup({
				ensure_installed = { "lua", "vim", "vimdoc", "javascript", "typescript", "python", "markdown" },
				auto_install = true,
				highlight = { enable = true },
				indent = { enable = true },
			})
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
	},
	{
		"saghen/blink.cmp",
		version = "1.*",
		opts_extend = { "sources.default" },
		dependencies = {
			"saghen/blink.lib",
			-- optional: provides snippets for the snippet source
			"rafamadriz/friendly-snippets",
		},
	},

	-- LSP управление
	{ "onsails/lspkind.nvim", event = "InsertEnter" },
	{ "neovim/nvim-lspconfig", event = "BufReadPre" },
	{ "williamboman/mason.nvim", cmd = "Mason", build = ":MasonUpdate" },
	{ "williamboman/mason-lspconfig.nvim", dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" } },
	{ "WhoIsSethDaniel/mason-tool-installer.nvim", dependencies = { "williamboman/mason.nvim" } },
	{ "b0o/schemastore.nvim", lazy = true },
	{ "bullets-vim/bullets.vim", ft = { "markdown", "text" } },

	--------------------------------------------------------------------------------
	-- AI / LLM
	--------------------------------------------------------------------------------
	{
		"yetone/avante.nvim",
		build = "make",
		lazy = false,
		version = false,
		git = { timeout = 14400 },
		opts = {
			behavior = { auto_suggestions = true, enable_cursor_planning_mode = true },
			hints = { enabled = true },
			provider = "gemini",
			providers = {
				gemini = {
					endpoint = "https://generativelanguage.googleapis.com/v1beta/models",
					model = "gemini-2.5-pro", -- Or "gemini-2.5-flash" for faster responses
					proxy = os.getenv("https_proxy"), -- подхватываем прокси из системы
					api_key_name = "GEMINI_API_KEY",
					temperature = 0,
					timeout = 30000, -- Timeout in milliseconds
					max_tokens = 8192,
				},
				kodify = {
					__inherited_from = "openai",
					api_key_name = "KODIFY_API_KEY",
					api_path = "/chat/completions",
					disable_tools = true,
					enabled = true,
					endpoint = "https://demo1-fundres.dev.mts.ai/v1",
					model = "kodify_2.0.1",
					timeout = 30000,
				},
			},
			default_provider = "kodify",
		},
		dependencies = {
			"MunifTanjim/nui.nvim",
			"echasnovski/mini.pick",
			"folke/snacks.nvim",
			"ibhagwan/fzf-lua",
			"nvim-lua/plenary.nvim",
			{
				"HakonHarnes/img-clip.nvim",
				event = "VeryLazy",
				opts = {
					default = {
						embed_image_as_base64 = false,
						prompt_for_file_name = false,
						drag_and_drop = { insert_mode = true },
					},
				},
			},
		},
	},
	{
		"coder/claudecode.nvim",
		dependencies = { "folke/snacks.nvim" },
		config = true,
		keys = {
			{ "<leader>a", nil, desc = "Claude Code" },
			{ "<leader>ac", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
			{ "<leader>af", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
			{ "<leader>ar", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
			{ "<leader>aC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
			{ "<leader>am", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select Claude model" },
			{ "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer" },
			{ "<leader>as", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" },
			{
				"<leader>as",
				"<cmd>ClaudeCodeTreeAdd<cr>",
				desc = "Add file",
				ft = { "NvimTree", "neo-tree", "oil", "minifiles", "netrw" },
			},
			{ "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
			{ "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },
		},
	},

	--------------------------------------------------------------------------------
	-- Рефакторинг и работа с кодом
	--------------------------------------------------------------------------------
	{
		"ThePrimeagen/refactoring.nvim",
		cmd = "Refactor",
		dependencies = {
			"lewis6991/async.nvim",
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		lazy = false,
		opts = {},
	},
	-- Форматирование (conform.nvim)
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		opts = {
			log_level = vim.log.levels.DEBUG,
			formatters_by_ft = {
				lua = { "stylua" },
				javascript = { "prettierd", "prettier", stop_after_first = true },
				typescript = { "prettierd", "prettier", stop_after_first = true },
				json = { "prettierd", "prettier", stop_after_first = true },
				markdown = { "prettierd", "prettier", stop_after_first = true },
				python = { "ruff", "black", stop_after_first = true },
				-- Shell-подобные типы файлов
				sh = { "shfmt" },
				bash = { "shfmt" },
				zsh = { "shfmt" },
				shell = { "shfmt" }, -- fallback для прочих shell-скриптов
				dockerfile = { "shfmt" }, -- Dockerfile тоже можно форматировать через shfmt
			},
			-- Set default options
			default_format_opts = {
				lsp_format = "fallback",
			},
			-- Set up format-on-save
			format_on_save = { timeout_ms = 500 },
			-- Customize formatters
			formatters = {
				shfmt = {
					append_args = { "-i", "2" },
				},
			},
		},
	},

	--------------------------------------------------------------------------------
	-- Утилиты
	--------------------------------------------------------------------------------
	{ "f-person/auto-dark-mode.nvim" },
	{ "nacro90/numb.nvim", event = "VeryLazy" },
	{ "skanehira/translate.vim", cmd = "Translate" },
	{ "stsewd/gx-extended.vim", keys = { "gx" } },
	{ "tpope/vim-repeat", keys = { "." } },
	{ "tpope/vim-unimpaired", keys = { "[", "]", "y[", "y]" } },
	{
		"folke/trouble.nvim",
		cmd = "Trouble",
		opts = {},
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			-- Добавьте это, чтобы which-key понимал перемапленные клавиши
			delay = 300,
		},
		-- config = function(_, opts)
		-- 	local wk = require("which-key")
		-- 	wk.setup(opts)
		-- 	-- Интеграция с langmapper
		-- 	require("langmapper").setup_which_key()
		-- end,
	},
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		---@type Flash.Config
		opts = {},
		keys = {
			{
				"s",
				mode = { "n", "x", "o" },
				function()
					require("flash").jump()
				end,
				desc = "Flash",
			},
			{
				"S",
				mode = { "n", "x", "o" },
				function()
					require("flash").treesitter()
				end,
				desc = "Flash Treesitter",
			},
			{
				"r",
				mode = "o",
				function()
					require("flash").remote()
				end,
				desc = "Remote Flash",
			},
			{
				"R",
				mode = { "o", "x" },
				function()
					require("flash").treesitter_search()
				end,
				desc = "Treesitter Search",
			},
			{
				"<c-s>",
				mode = { "c" },
				function()
					require("flash").toggle()
				end,
				desc = "Toggle Flash Search",
			},
		},
	},
	{
		"kosayoda/nvim-lightbulb",
		event = "VeryLazy",
	},

	--------------------------------------------------------------------------------
	-- Тестирование
	--------------------------------------------------------------------------------
	{
		"nvim-neotest/neotest",
		cmd = "Neotest",
		dependencies = {
			"haydenmeade/neotest-jest",
			"nvim-lua/plenary.nvim",
			"nvim-neotest/nvim-nio",
			"nvim-treesitter/nvim-treesitter",
		},
	},

	--------------------------------------------------------------------------------
	-- Специализированные
	--------------------------------------------------------------------------------
	{
		"chipsenkbeil/distant.nvim",
		branch = "v0.3",
		config = function()
			require("distant"):setup()
		end,
	},
	{ "typed-rocks/ts-worksheet-neovim", ft = "ts" },
	{
		"obsidian-nvim/obsidian.nvim",
		version = "*",
		ft = "markdown",
		dependencies = {
			"ibhagwan/fzf-lua",
			"godlygeek/tabular",
			"OXY2DEV/markview.nvim",
		},
	},
	{
		"OXY2DEV/markview.nvim",
		event = "VeryLazy",
		opts = {
			preview = {
				modes = { "n", "c" }, -- Рендеринг включён в нормальном и вставки
				hybrid_modes = { "n" }, -- Гибридный режим активен только в normal mode
				linewise_hybrid_mode = true, -- <-- Ключевая опция
			},
			markdown = {
				list_items = {
					shift_width = 2,
					indent_size = 2,
				},
			},
			experimental = { check_rtp_message = false },
		},
	},
	{
		"sphamba/smear-cursor.nvim",
		opts = { -- Default  Range
			stiffness = 0.7, -- 0.6      [0, 1]
			trailing_stiffness = 0.6, -- 0.45     [0, 1]
			stiffness_insert_mode = 0.6, -- 0.5      [0, 1]
			trailing_stiffness_insert_mode = 0.6, -- 0.5      [0, 1]
			damping = 0.85, -- 0.85     [0, 1]
			damping_insert_mode = 0.90, -- 0.9      [0, 1]
			distance_stop_animating = 0.3, -- 0.1      > 0
		},
	},
	{
		"j-hui/fidget.nvim",
		opts = {},
	},
	--- Firenvim editing mode in browser
	{ "glacambre/firenvim", build = ":call firenvim#install(0)" },
	{
		"Wansmer/langmapper.nvim",
		lazy = false,
		priority = 1000, -- Должен загрузиться раньше всех кеймапов
		config = function()
			local lm = require("langmapper")
			lm.setup({
				-- Автоматически оборачивать vim.keymap.set
				map_all_ctrl = true,
			})
			-- Это "магия", которая заставляет все последующие вызовы vim.keymap.set
			-- (в core/keymaps.lua, lsp/config.lua и т.д.) работать для обеих раскладок
			lm.hack_get_keymap()
		end,
	},
})
