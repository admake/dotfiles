local wk = require("which-key")

-- Remap space as leader key.
vim.api.nvim_set_keymap("", "<Space>", "<Nop>", { noremap = true, silent = true })
vim.g.mapleader = " "
vim.g.maplocalleader = " "

------------
-- Mappings.
------------
wk.add({
	-- Move lines (normal, insert, visual)
	{ "<C-j>", ":m .+1<CR>==", desc = "Move line down", mode = "n", noremap = true, silent = true },
	{ "<C-k>", ":m .-2<CR>==", desc = "Move line up", mode = "n", noremap = true, silent = true },
	{ "<C-j>", "<Esc>:m .+1<CR>==gi", desc = "Move line down", mode = "i", noremap = true, silent = true },
	{ "<C-k>", "<Esc>:m .-2<CR>==gi", desc = "Move line up", mode = "i", noremap = true, silent = true },
	{ "<C-j>", ":m '>+1<CR>gv=gv", desc = "Move line down", mode = "v", noremap = true, silent = true },
	{ "<C-k>", ":m '<-2<CR>gv=gv", desc = "Move line up", mode = "v", noremap = true, silent = true },

	-- Diagnostics
	{ "<leader>e", vim.diagnostic.open_float, desc = "Show diagnostic", mode = "n", noremap = true, silent = true },
	{
		"g[",
		function()
			vim.diagnostic.jump({ count = -1 })
		end,
		desc = "Previous diagnostic",
		mode = "n",
		noremap = true,
		silent = true,
	},
	{
		"g]",
		function()
			vim.diagnostic.jump({ count = 1 })
		end,
		desc = "Next diagnostic",
		mode = "n",
		noremap = true,
		silent = true,
	},
	{ "<leader>q", vim.diagnostic.setloclist, desc = "Set location list", mode = "n", noremap = true, silent = true },
	{
		"gK",
		function()
			local new_config = not vim.diagnostic.config().virtual_lines
			vim.diagnostic.config({ virtual_lines = new_config })
		end,
		desc = "Toggle diagnostic virtual_lines",
		mode = "n",
		noremap = true,
		silent = true,
	},

	-- Show which-key for buffer local keymaps
	{
		"<leader>?",
		function()
			require("which-key").show({ global = false })
		end,
		desc = "Buffer Local Keymaps (which-key)",
		mode = "n",
	},

	-- Telescope
	{ "<c-p>", proxy = "<leader>ff", desc = "Find files (proxy)" },
	{
		"<leader>ff",
		function()
			require("telescope.builtin").find_files({ hidden = true })
		end,
		desc = "Find files",
		mode = "n",
	},
	{
		"<leader>fg",
		function()
			require("telescope.builtin").live_grep()
		end,
		desc = "Files grep",
		mode = "n",
	},
	{
		"<leader>fb",
		function()
			require("telescope.builtin").buffers()
		end,
		desc = "Find buffers",
		mode = "n",
	},
	{
		"<leader>fh",
		function()
			require("telescope.builtin").help_tags()
		end,
		desc = "Find helps",
		mode = "n",
	},
	{
		"<leader>fd",
		function()
			require("telescope.builtin").diagnostics()
		end,
		desc = "Find diagnostic",
		mode = "n",
	},

	{ "<leader>lg", ":LazyGit<CR>", desc = "LazyGit" },

	-- NvimTree
	{ "<leader>b", ":NvimTreeToggle<CR>", desc = "Toggle Tree", mode = "n", noremap = true, silent = true },

	-- Trouble
	{ "<leader>l", ":TroubleToggle<CR>", desc = "Toggle Trouble", mode = "n", noremap = true, silent = true },

	-- Refactoring (visual mode)
	{
		"<leader>rr",
		":lua require('refactoring').select_refactor()<CR>",
		desc = "Select refactor",
		mode = "v",
		noremap = true,
		silent = true,
	},

	-- Test runner (neotest)
	{
		"<leader>tt",
		function()
			require("neotest").run.run()
		end,
		desc = "Run nearest test",
		mode = "n",
	},
	{
		"<leader>tf",
		function()
			require("neotest").run.run(vim.fn.expand("%"))
		end,
		desc = "Run current file",
		mode = "n",
	},

	-- Tsw
	{ "<leader>R", ":Tsw show_variables=true<CR>", desc = "Tsw show variables", mode = "n", silent = true },
})
