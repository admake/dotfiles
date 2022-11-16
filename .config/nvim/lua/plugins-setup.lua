vim.cmd([[packadd packer.nvim]])

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins-setup.lua source <afile> | PackerCompile
  augroup end
]])

local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
		vim.cmd([[packadd packer.nvim]])
		return true
	end
	return false
end

local packer_bootstrap = ensure_packer()

require("packer").startup(function(use)
	-- Packer сам себя
	use("wbthomason/packer.nvim")

	-----------------------------------------------------------
	-- ПЛАГИНЫ ВНЕШНЕГО ВИДА
	-----------------------------------------------------------

	-- Цветовая схема
	use("rmehri01/onenord.nvim")

	--- Информационная строка внизу
	use({
		"nvim-lualine/lualine.nvim",
		requires = {
			"nvim-tree/nvim-web-devicons",
			opt = true,
		},
	})

	-- Табы вверху
	use({
		"akinsho/bufferline.nvim",
		tag = "v3.*",
		requires = "nvim-tree/nvim-web-devicons",
	})

	-- GitGutters
	use("airblade/vim-gitgutter")

	-----------------------------------------------------------
	-- НАВИГАЦИЯ
	-----------------------------------------------------------

	-- Файловый менеджер
	use({
		"nvim-tree/nvim-tree.lua",
		requires = "nvim-tree/nvim-web-devicons",
	})

	-- Навигация внутри файла по классам и функциям
	use("majutsushi/tagbar")

	-- Замена fzf и ack
	use({
		"nvim-telescope/telescope.nvim",
		tag = "0.1.0",
		requires = { { "nvim-lua/plenary.nvim" } },
	})

	-----------------------------------------------------------
	-- LSP и автодополнялка
	-----------------------------------------------------------
	-- Highlight, edit, and navigate code using a fast incremental parsing library
	use("nvim-treesitter/nvim-treesitter")
	use("nvim-treesitter/playground")
	-- This tiny plugin adds vscode-like pictograms to neovim built-in lsp
	use("onsails/lspkind.nvim")
	-- Collection of configurations for built-in LSP client
	use("neovim/nvim-lspconfig")
	-- use 'williamboman/nvim-lsp-installer'
	use("williamboman/mason.nvim")
	use("williamboman/mason-lspconfig.nvim")
	use("WhoIsSethDaniel/mason-tool-installer.nvim")
	-- Автодополнялка
	use("hrsh7th/nvim-cmp")
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/cmp-cmdline")
	use("hrsh7th/cmp-nvim-lsp-signature-help")
	use("ray-x/cmp-treesitter")
	use("saadparwaiz1/cmp_luasnip")
	use({
		"nvim-telescope/telescope-fzf-native.nvim",
		run = "make",
	})
	use({
		"tzachar/cmp-fuzzy-buffer",
		requires = { "hrsh7th/nvim-cmp", "tzachar/fuzzy.nvim" },
	})
	use({
		"David-Kunz/cmp-npm",
		requires = {
			"nvim-lua/plenary.nvim",
		},
	})
	-- Автодополнялка к файловой системе
	use("hrsh7th/cmp-path")
	-- Snippets plugin
	use("L3MON4D3/LuaSnip")

	--tabnine as copilot
	-- use({ "tbodt/deoplete-tabnine", run = "./install.sh" })

	-----------------------------------------------------------
	-- Refactoring
	-----------------------------------------------------------
	use({
		"ThePrimeagen/refactoring.nvim",
		requires = {
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-treesitter/nvim-treesitter" },
		},
	})

	-----------------------------------------------------------
	-- РАЗНОЕ
	-----------------------------------------------------------
	-- Даже если включена русская раскладка vim команды будут работать
	use("powerman/vim-plugin-ruscmd")
	-- 'Автоформатирование' кода для всех языков
	use("Chiel92/vim-autoformat")
	-- ]p - вставить на строку выше, [p - ниже
	use("tpope/vim-unimpaired")
	-- Переводчик рус - англ
	use("skanehira/translate.vim")
	--- popup окошки
	use("nvim-lua/popup.nvim")
	-- Обрамляет или снимает обрамление. Выдели слово, нажми S и набери <h1>
	use("tpope/vim-surround")
	-- Считает кол-во совпадений при поиске
	use("google/vim-searchindex")
	-- Может повторять через . vimsurround
	use("tpope/vim-repeat")
	-- Комментирует по gc все, вне зависимости от языка программирования
	use("numToStr/Comment.nvim")
	-- Закрывает автоматом скобки
	use("cohama/lexima.vim")
	-- Для кеймапов
	use("b0o/mapx.nvim")

	-- вместо fugitive
	use("lewis6991/gitsigns.nvim")

	use("tpope/vim-sensible")
	use("f-person/auto-dark-mode.nvim")
	use("mhartington/formatter.nvim")
	-- use({
	-- 	"spinks/vim-leader-guide",
	-- 	config = function()
	-- 		require("vim-leader-guide").setup()
	-- 	end,
	-- })
	-- numb navigate
	use("nacro90/numb.nvim")
	-- documentation generator
	-- use({
	-- 	"kkoomen/vim-doge",
	-- 	run = ":call doge#install()",
	-- })
	-- diagnostic list etc
	-- Lua
	use({
		"folke/trouble.nvim",
		requires = "nvim-tree/nvim-web-devicons",
	})

	-- Diagnostics Code Action Menu
	use({
		"weilbith/nvim-code-action-menu",
		cmd = "CodeActionMenu",
		config = function()
			require("code_action_menu")
		end,
	})

	-- Diagnostics bulb
	use({
		"kosayoda/nvim-lightbulb",
		requires = "antoinemadec/FixCursorHold.nvim",
	})

	-- Rooter отвечает за авто рут открытого проекта
	use("airblade/vim-rooter")

	-- Window auto focus and navigate
	-- use({
	-- 	"beauwilliams/focus.nvim",
	-- 	config = function()
	-- 		require("focus").setup()
	-- 	end,
	-- })
	-- Or lazy load with `module` option. See further down for info on how to lazy load when using FocusSplit commands
	-- Or lazy load this plugin by creating an arbitrary command using the cmd option in packer.nvim
	-- use { 'beauwilliams/focus.nvim', cmd = { "FocusSplitNicely", "FocusSplitCycle" }, module = "focus",
	--     config = function()
	--         require("focus").setup({hybridnumber = true})
	--     end
	-- }

	-- Multiple cursors
	-- use("terryma/vim-multiple-cursors")

	-- multi cursor Ctrl-D
	-- use({ "mg979/vim-visual-multi", branch = "master" })

	-- Is using a standard Neovim install, i.e. built from source or using a
	-- provided appimage.
	use("lewis6991/impatient.nvim")

	-- Startup time
	use("dstein64/vim-startuptime")

	-- Test Runner
	use({
		"nvim-neotest/neotest",
		requires = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			"antoinemadec/FixCursorHold.nvim",
			"haydenmeade/neotest-jest",
		},
	})

	use("gpanders/editorconfig.nvim")
	if packer_bootstrap then
		require("packer").sync()
	end
end)