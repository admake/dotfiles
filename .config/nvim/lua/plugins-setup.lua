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

	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
	},

	{ "L3MON4D3/LuaSnip" },
	{ "WhoIsSethDaniel/mason-tool-installer.nvim" },
	{ "b0o/schemastore.nvim" },
	{ "hrsh7th/cmp-buffer" },
	{ "hrsh7th/cmp-cmdline" },
	{ "hrsh7th/cmp-nvim-lsp" },
	{ "hrsh7th/cmp-nvim-lsp-signature-help" },
	{ "hrsh7th/cmp-path" },
	{ "hrsh7th/nvim-cmp" },
	{ "neovim/nvim-lspconfig" },
	{ "nvim-treesitter/playground" },
	{ "onsails/lspkind.nvim" },
	{ "ray-x/cmp-treesitter" },
	{ "ray-x/lsp_signature.nvim" },
	{ "saadparwaiz1/cmp_luasnip" },
	{ "williamboman/mason-lspconfig.nvim" },
	{ "williamboman/mason.nvim" },
	{ "bullets-vim/bullets.vim" },

	{
		"tzachar/cmp-fuzzy-buffer",
		dependencies = { "hrsh7th/nvim-cmp", "tzachar/fuzzy.nvim" },
	},

	{
		"David-Kunz/cmp-npm",
		dependencies = { "nvim-lua/plenary.nvim" },
	},

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
	{ "cohama/lexima.vim" },
	{ "echasnovski/mini.surround", version = "*" },
	{ "numToStr/Comment.nvim" },

	--------------------------------------------------------------------------------
	-- Git и интеграция с системой контроля версий
	--------------------------------------------------------------------------------
	{ "lewis6991/gitsigns.nvim" },
	{
		"NeogitOrg/neogit",
		dependencies = {
			"ibhagwan/fzf-lua",
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
			"sindrets/diffview.nvim",
		},
	},

	--------------------------------------------------------------------------------
	-- Утилиты и другое
	--------------------------------------------------------------------------------
	{ "Chiel92/vim-autoformat" },
	{ "b0o/mapx.nvim" },
	{ "f-person/auto-dark-mode.nvim" },
	{ "google/vim-searchindex" },
	{ "mhartington/formatter.nvim" },
	{ "nacro90/numb.nvim" },
	{ "neoclide/jsonc.vim" },
	{ "nvim-lua/popup.nvim" },
	{ "powerman/vim-plugin-ruscmd" },
	{ "skanehira/translate.vim" },
	{ "stsewd/gx-extended.vim" },
	{ "tpope/vim-repeat" },
	{ "tpope/vim-sensible" },
	{ "tpope/vim-unimpaired" },
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
			"antoinemadec/FixCursorHold.nvim",
			"haydenmeade/neotest-jest",
			"nvim-lua/plenary.nvim",
			"nvim-neotest/nvim-nio",
			"nvim-treesitter/nvim-treesitter",
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
		config = function()
			require("markview").setup({
				experemental = {
					check_rtp_message = false,
				},
			})
		end,
	},
	{
		"karb94/neoscroll.nvim",
		config = function()
			require("neoscroll").setup({
				-- Your configuration options here
				-- easing = "quintic",
				easing = "linear",
				duration_multiplier = 0.25,
			})
		end,
	},
})
