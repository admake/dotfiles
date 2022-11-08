vim.cmd([[packadd packer.nvim]])

require("packer").startup(function()
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
			"kyazdani42/nvim-web-devicons",
			opt = true,
		},
	})

	-- Табы вверху
	use({
		"akinsho/bufferline.nvim",
		tag = "v2.*",
		requires = "kyazdani42/nvim-web-devicons",
	})

	-- GitGutters
	use("airblade/vim-gitgutter")

	-- GitBlame
	-- use("APZelos/blamer.nvim")

	-----------------------------------------------------------
	-- НАВИГАЦИЯ
	-----------------------------------------------------------
	-- Файловый менеджер
	use({
		"kyazdani42/nvim-tree.lua",
		requires = "kyazdani42/nvim-web-devicons",
	})

	-- Навигация внутри файла по классам и функциям
	use("majutsushi/tagbar")

	-- Замена fzf и ack
	use({
		"nvim-telescope/telescope.nvim",
		tag = "0.1.0",
		requires = { { "nvim-lua/plenary.nvim" } },
		config = function()
			require("telescope").setup({})
		end,
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
	-- HTML и CSS
	-----------------------------------------------------------
	-- Подсвечивает закрывающий и открыт тэг. Если, где-то что-то не закрыто, то не подсвечивает.
	-- use("idanarye/breeze.vim")
	-- Закрывает автоматом html и xml тэги. Пишешь <h1> и он автоматом закроется </h1>
	-- use("alvan/vim-closetag")

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
	-- Стартовая страница, если просто набрать vim в консоле
	-- use 'mhinz/vim-startify'
	-- Комментирует по gc все, вне зависимости от языка программирования
	use({
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	})
	-- Обрамляет строку в теги по ctrl- y + ,
	-- use 'mattn/emmet-vim'
	-- Закрывает автоматом скобки
	use("cohama/lexima.vim")
	-- Линтер, работает для всех языков
	-- use 'dense-analysis/ale'
	-- Для кеймапов
	use("b0o/mapx.nvim")

	use("tpope/vim-fugitive")
	use("tpope/vim-sensible")
	use("f-person/auto-dark-mode.nvim")
	use("mhartington/formatter.nvim")
	-- use({
	-- 	"spinks/vim-leader-guide",
	-- 	config = function()
	-- 		require("vim-leader-guide").setup()
	-- 	end,
	-- })
	-- Jest runner
	-- use("David-Kunz/jester")
	-- Smooth scroll
	-- use("karb94/neoscroll.nvim")
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
		requires = "kyazdani42/nvim-web-devicons",
		config = function()
			require("trouble").setup({
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
			})
		end,
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
	-- use("tweekmonster/startuptime.vim")

	-- LateX Highlight
	-- use("jbyuki/nabla.vim")
end)

require("mason").setup()

-- require("mason-lspconfig").setup({
--     ensure_installed = {
--         'bashls',
--         'diagnosticls',
--         'dockerls',
--         'dotls',
--         'eslint',
--         'jsonls',
--         'tsserver',
--         'marksman',
--         'sumneko_lua',
--         'remark_ls',
--         'vimls',
--         'lemminx',
--         'yamlls'
--     }
-- })

require("mason-tool-installer").setup({
	-- a list of all tools you want to ensure are installed upon
	-- start; they should be the names Mason uses for each tool
	ensure_installed = { -- you can turn off/on auto_update per tool
		"bash-language-server",
		"diagnostic-languageserver",
		"dockerfile-language-server",
		"dot-language-server",
		"eslint_d",
		"eslint-lsp",
		"jq",
		"json-lsp",
		"markdownlint",
		"node-debug2-adapter",
		"prettier",
		"prettierd",
		"shellcheck",
		"shellcheck",
		"typescript-language-server",
		"vim-language-server",
		"vint",
		"xmlformatter",
		"yaml-language-server",
		"yamllint",
		"lua-language-server",
		"stylua",
		-- 'sumneko_lua',
		-- 'gopls',
		-- 'editorconfig-checker'
		-- 'impl',
		-- 'json-to-struct',
		-- 'luacheck',
		-- 'misspell',
		-- 'revive',
		-- 'shfmt',
		-- 'staticcheck',
	},

	-- if set to true this will check each tool for updates. If updates
	-- are available the tool will be updated. This setting does not
	-- affect :MasonToolsUpdate or :MasonToolsInstall.
	-- Default: false
	auto_update = false,

	-- automatically install / update on startup. If set to false nothing
	-- will happen on startup. You can use :MasonToolsInstall or
	-- :MasonToolsUpdate to install tools and check for updates.
	-- Default: true
	run_on_start = true,

	-- set a delay (in ms) before the installation starts. This is only
	-- effective if run_on_start is set to true.
	-- e.g.: 5000 = 5 second delay, 10000 = 10 second delay, etc...
	-- Default: 0
	start_delay = 1000, -- 3 second delay
})
