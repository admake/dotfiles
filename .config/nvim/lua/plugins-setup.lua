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
	-- Packer self-managed не нужен в lazy.nvim

	-- Плагины внешнего вида
	{ "nvim-tree/nvim-web-devicons" },
	{ "rmehri01/onenord.nvim" },

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

	-- Навигация
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

	-- LSP и автодополнялка
	{ "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" }, -- рек. добавить build для обновления
	{ "nvim-treesitter/playground" },
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		-- lazy.nvim не использует after, но можно поставить lazy.load по событию
	},
	{ "onsails/lspkind.nvim" },
	{ "neovim/nvim-lspconfig" },
	{ "ray-x/lsp_signature.nvim" },
	{ "williamboman/mason.nvim" },
	{ "williamboman/mason-lspconfig.nvim" },
	{ "WhoIsSethDaniel/mason-tool-installer.nvim" },
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "make",
	},
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

	-- Refactoring
	{
		"ThePrimeagen/refactoring.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter" },
	},

	-- Разное
	{ "neoclide/jsonc.vim" },
	{ "powerman/vim-plugin-ruscmd" },
	{ "Chiel92/vim-autoformat" },
	{ "tpope/vim-unimpaired" },
	{ "skanehira/translate.vim" },
	{ "nvim-lua/popup.nvim" },
	{
		"kylechui/nvim-surround",
		version = "main", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
	},
	{ "google/vim-searchindex" },
	{ "tpope/vim-repeat" },
	{ "numToStr/Comment.nvim" },
	{ "cohama/lexima.vim" },
	{ "b0o/mapx.nvim" },
	{ "lewis6991/gitsigns.nvim" },
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
	{
		"NeogitOrg/neogit",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
			"sindrets/diffview.nvim",
			"ibhagwan/fzf-lua",
		},
	},
	{ "airblade/vim-rooter" },
	{ "terryma/vim-multiple-cursors" },
	{ "lewis6991/impatient.nvim" },
	{ "dstein64/vim-startuptime" },
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
	{ "typed-rocks/ts-worksheet-neovim" },
	{ "gpanders/editorconfig.nvim" },
	{
		"epwalsh/obsidian.nvim",
		dependencies = {
			"ibhagwan/fzf-lua",
			"preservim/vim-markdown",
			"godlygeek/tabular",
		},
	},
	{
		"OXY2DEV/markview.nvim", --[[ dependencies = "" ]]
	},
})
