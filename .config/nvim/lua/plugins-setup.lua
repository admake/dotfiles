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
		"nvim-tree/nvim-web-devicons",
		lazy = true,
	},
	{
		"gbprod/nord.nvim",
		lazy = false,
		priority = 1000,
	},
	{ "fcancelinha/nordern.nvim", lazy = false, priority = 1000 },
	{
		"rmehri01/onenord.nvim",
		lazy = false,
		priority = 1000,
	},
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},
	{
		"akinsho/bufferline.nvim",
		event = "VeryLazy",
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},
	{
		"sindrets/diffview.nvim",
		cmd = "DiffviewOpen",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	{ "rhysd/conflict-marker.vim", event = "VeryLazy" },
	{
		"lukas-reineke/indent-blankline.nvim",
		event = "VeryLazy",
		main = "ibl", -- для версии 3 необязательно, но можно указать
		opts = {}, -- конфиг в отдельном файле plugins/indent_blankline.lua
	},
	{ "xzbdmw/colorful-menu.nvim" },

	--------------------------------------------------------------------------------
	-- Навигация и поиск
	--------------------------------------------------------------------------------
	{
		"nvim-tree/nvim-tree.lua",
		cmd = "NvimTreeToggle",
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},
	{
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
				cond = function()
					return vim.fn.executable("make") == 1
				end,
			},
		},
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
			-- "saghen/blink.compat",
			"nvim-tree/nvim-web-devicons",
			-- optional: provides snippets for the snippet source
			"rafamadriz/friendly-snippets",
			"L3MON4D3/LuaSnip",
		},
	},

	-- LSP управление
	{ "L3MON4D3/LuaSnip", event = "InsertEnter" },
	{ "onsails/lspkind.nvim", event = "InsertEnter" },
	{ "neovim/nvim-lspconfig", event = "BufReadPre" },
	{ "williamboman/mason.nvim", cmd = "Mason", build = ":MasonUpdate" },
	{ "williamboman/mason-lspconfig.nvim", dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" } },
	{ "WhoIsSethDaniel/mason-tool-installer.nvim", dependencies = { "williamboman/mason.nvim" } },
	{ "b0o/schemastore.nvim", lazy = true },
	{ "ray-x/lsp_signature.nvim", event = "VeryLazy" },
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
			provider = "kodify",
			providers = {
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
			"hrsh7th/nvim-cmp",
			"ibhagwan/fzf-lua",
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
			"nvim-tree/nvim-web-devicons",
			"stevearc/dressing.nvim",
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
	},
	{ "windwp/nvim-autopairs", event = "InsertEnter", opts = {} }, -- замена lexima.vim
	{ "echasnovski/mini.surround", version = "*", event = "VeryLazy", config = true },
	{ "numToStr/Comment.nvim", keys = { { "gc", mode = { "n", "v" }, desc = "Comment" } }, opts = {} },
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
	-- Git
	--------------------------------------------------------------------------------
	{ "lewis6991/gitsigns.nvim", event = "BufReadPost", opts = {} },
	{
		"NeogitOrg/neogit",
		cmd = "Neogit",
		dependencies = { "nvim-lua/plenary.nvim", "sindrets/diffview.nvim" },
	},

	{
		"kdheepak/lazygit.nvim",
		lazy = false,
		cmd = {
			"LazyGit",
			"LazyGitConfig",
			"LazyGitCurrentFile",
			"LazyGitFilter",
			"LazyGitFilterCurrentFile",
		},
		-- optional for floating window border decoration
		dependencies = {
			"nvim-telescope/telescope.nvim",
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require("telescope").load_extension("lazygit")
		end,
	},

	--------------------------------------------------------------------------------
	-- Утилиты
	--------------------------------------------------------------------------------
	{ "f-person/auto-dark-mode.nvim" },
	{ "google/vim-searchindex", event = "BufReadPost" },
	{ "nacro90/numb.nvim", event = "VeryLazy" },
	{ "powerman/vim-plugin-ruscmd", cmd = "Ruscmd" },
	{ "skanehira/translate.vim", cmd = "Translate" },
	{ "stsewd/gx-extended.vim", keys = { "gx" } },
	{ "tpope/vim-repeat", keys = { "." } },
	{ "tpope/vim-unimpaired", keys = { "[", "]", "y[", "y]" } },
	{ "airblade/vim-rooter", event = "VeryLazy" },
	{ "dstein64/vim-startuptime", cmd = "StartupTime" },
	{
		"folke/trouble.nvim",
		cmd = "Trouble",
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},
	{ "folke/which-key.nvim", event = "VeryLazy", opts = {} },
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
		"weilbith/nvim-code-action-menu",
		cmd = "CodeActionMenu",
		config = function()
			require("code_action_menu")
		end,
	},
	{
		"kosayoda/nvim-lightbulb",
		dependencies = { "antoinemadec/FixCursorHold.nvim" },
		event = "VeryLazy",
	},

	--------------------------------------------------------------------------------
	-- Тестирование
	--------------------------------------------------------------------------------
	{
		"nvim-neotest/neotest",
		cmd = "Neotest",
		dependencies = {
			"antoinemadec/FixCursorHold.nvim",
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
	{ "gpanders/editorconfig.nvim", event = "VeryLazy" },
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
				shift_width = 2, -- Для отступа в 2 пробела
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
	--- Firenvim editing mode in browser
	{ "glacambre/firenvim", build = ":call firenvim#install(0)" },
	--- Notifications about movings
	-- {
	-- 	"m4xshen/hardtime.nvim",
	-- 	lazy = false,
	-- 	dependencies = { "MunifTanjim/nui.nvim" },
	-- 	opts = {},
	-- },
	-- {
	-- 	"rachartier/tiny-glimmer.nvim",
	-- 	event = "VeryLazy",
	-- 	priority = 10, -- Low priority to catch other plugins' keybindings
	-- 	config = function()
	-- 		require("tiny-glimmer").setup()
	-- 	end,
	-- },
	-- {
	-- 	"tris203/precognition.nvim",
	-- 	event = "VeryLazy",
	-- },
})
