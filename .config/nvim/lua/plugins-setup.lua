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
		"nvim-tree/nvim-web-devicons",
	},

	{
		"rmehri01/onenord.nvim",
		lazy = false,
	},

	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},

	{
		"akinsho/bufferline.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},

	{
		"sindrets/diffview.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
	},

	{ "rhysd/conflict-marker.vim" },
	{ "lukas-reineke/indent-blankline.nvim" },

	--------------------------------------------------------------------------------
	-- Навигация и поиск
	--------------------------------------------------------------------------------
	{
		"nvim-tree/nvim-tree.lua",
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},

	{ "majutsushi/tagbar" },

	{
		"nvim-telescope/telescope.nvim",
		version = "0.1.x",
		dependencies = { "nvim-lua/plenary.nvim" },
	},

	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "make",
	},

	--------------------------------------------------------------------------------
	-- LSP, автодополнение и подсветка синтаксиса
	--------------------------------------------------------------------------------
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		priority = 50, -- приоритет выше для загрузки первым
		build = ":TSUpdate",
		dependencies = { "OXY2DEV/markview.nvim" }, -- markview как зависимость
	},

	{ "nvim-treesitter/playground" },

	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
	},

	{ "onsails/lspkind.nvim" },
	{ "neovim/nvim-lspconfig" },
	{ "ray-x/lsp_signature.nvim" },
	{ "williamboman/mason.nvim" },
	{ "williamboman/mason-lspconfig.nvim" },
	{ "WhoIsSethDaniel/mason-tool-installer.nvim" },

	{ "hrsh7th/nvim-cmp" },
	{ "hrsh7th/cmp-nvim-lsp" },
	{ "hrsh7th/cmp-buffer" },
	{ "hrsh7th/cmp-cmdline" },
	{ "hrsh7th/cmp-nvim-lsp-signature-help" },
	{ "ray-x/cmp-treesitter" },
	{ "saadparwaiz1/cmp_luasnip" },

	{
		"tzachar/cmp-fuzzy-buffer",
		dependencies = { "hrsh7th/nvim-cmp", "tzachar/fuzzy.nvim" },
	},

	{
		"David-Kunz/cmp-npm",
		dependencies = { "nvim-lua/plenary.nvim" },
	},

	{ "hrsh7th/cmp-path" },
	{ "L3MON4D3/LuaSnip" },
	{ "b0o/schemastore.nvim" },

	--------------------------------------------------------------------------------
	-- LLM Kotype and Codify
	--------------------------------------------------------------------------------
	-- {
	-- 	"frankroeder/parrot.nvim",
	-- 	dependencies = { "ibhagwan/fzf-lua", "nvim-lua/plenary.nvim" },
	-- },
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
					endpoint = "https://demo1-fundres.dev.mts.ai/v1",
					api_path = "/chat/completions",
					api_key_name = "KODIFY_API_KEY",
					model = "kodify_2.0.1",
					enabled = true,
					timeout = 30000,
					disable_tools = true,
				},
			},
			default_provider = "kodify",
		},
		dependencies = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			"echasnovski/mini.pick",
			"nvim-telescope/telescope.nvim",
			"hrsh7th/nvim-cmp",
			"ibhagwan/fzf-lua",
			"stevearc/dressing.nvim",
			"folke/snacks.nvim",
			"nvim-tree/nvim-web-devicons",
			{
				"HakonHarnes/img-clip.nvim",
				event = "VeryLazy",
				opts = {
					default = {
						embed_image_as_base64 = false,
						prompt_for_file_name = false,
						drag_and_drop = {
							insert_mode = true,
						},
					},
				},
			},
		},
	},
	--------------------------------------------------------------------------------
	-- Рефакторинг и работа с кодом
	--------------------------------------------------------------------------------
	{
		"ThePrimeagen/refactoring.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter" },
	},
	{ "echasnovski/mini.surround", version = "*" },
	{ "numToStr/Comment.nvim" },
	{ "cohama/lexima.vim" },

	--------------------------------------------------------------------------------
	-- Git и интеграция с системой контроля версий
	--------------------------------------------------------------------------------
	{ "lewis6991/gitsigns.nvim" },
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
	{ "neoclide/jsonc.vim" },
	{ "powerman/vim-plugin-ruscmd" },
	{ "Chiel92/vim-autoformat" },
	{ "tpope/vim-unimpaired" },
	{ "skanehira/translate.vim" },
	{ "nvim-lua/popup.nvim" },
	{ "google/vim-searchindex" },
	{ "tpope/vim-repeat" },
	{ "b0o/mapx.nvim" },
	{ "tpope/vim-sensible" },
	{ "f-person/auto-dark-mode.nvim" },
	{ "mhartington/formatter.nvim" },
	{ "nacro90/numb.nvim" },
	{ "stsewd/gx-extended.vim" },
	{
		"kkoomen/vim-doge",
		build = ":call doge#install()",
	},
	{
		"folke/trouble.nvim",
		dependencies = "nvim-tree/nvim-web-devicons",
	},
	{ "folke/which-key.nvim" },
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
	{ "airblade/vim-rooter" },
	{ "terryma/vim-multiple-cursors" },

	{ "lewis6991/impatient.nvim" },
	{ "dstein64/vim-startuptime" },

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
	{ "typed-rocks/ts-worksheet-neovim" },
	{ "gpanders/editorconfig.nvim" },

	{
		"epwalsh/obsidian.nvim",
		dependencies = {
			"ibhagwan/fzf-lua",
			"preservim/vim-markdown",
			"godlygeek/tabular",
			"OXY2DEV/markview.nvim",
		},
	},

	{
		"OXY2DEV/markview.nvim",
		event = "VeryLazy",
	},
})
