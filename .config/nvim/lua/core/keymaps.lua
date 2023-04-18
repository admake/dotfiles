local mapx = require("mapx")
local nnoremap = mapx.nnoremap
local inoremap = mapx.inoremap
local vnoremap = mapx.vnoremap

-- Remap space as leader key.
-- Leader key is a special key that will allow us to make some additional keybindings.
-- I'm using a spacebar, but you can use whatever you'd wish
-- We'll use it (for example) for searching and changing file
-- (by pressing spacebar, then `s` and then `f`).
vim.api.nvim_set_keymap("", "<Space>", "<Nop>", { noremap = true, silent = true })
vim.g.mapleader = " "
vim.g.maplocalleader = " "
-- vim.keymap.set("n", "<leader>", "<cmd>LeaderGuide '<Space>'<CR>", { silent = true })
-- vim.keymap.set("v", "<leader>", "<cmd>LeaderGuideVisual '<Space>'<CR>", { silent = true })

--
-- Mappings.
--

-- Move lines C-j C-k
nnoremap("<C-j>", ":m .+1<CR>==")
nnoremap("<C-k>", ":m .-2<CR>==")
inoremap("<C-j>", "<Esc>:m .+1<CR>==gi")
inoremap("<C-k>", "<Esc>:m .-2<CR>==gi")
vnoremap("<C-j>", ":m '>+1<CR>gv=gv")
vnoremap("<C-k>", ":m '<-2<CR>gv=gv")

-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = {
	noremap = true,
	silent = true,
}
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)
vim.keymap.set("n", "g[", vim.diagnostic.goto_prev, opts)
vim.keymap.set("n", "g]", vim.diagnostic.goto_next, opts)
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, opts)

-----------------------------------------------------------
-- telescope
-----------------------------------------------------------
nnoremap("<c-p>", "<cmd>lua require('telescope.builtin').find_files({hidden=true})<cr>")
vim.keymap.set("n", "<leader>ff", function()
	require("telescope.builtin").find_files({ hidden = true })
end)
vim.keymap.set("n", "<leader>fg", function()
	require("telescope.builtin").live_grep()
end)
vim.keymap.set("n", "<leader>fb", function()
	require("telescope.builtin").buffers()
end)
vim.keymap.set("n", "<leader>fh", function()
	require("telescope.builtin").help_tags()
end)
vim.keymap.set("n", "<leader>fd", function()
	require("telescope.builtin").diagnostics()
end)

-- NvimTreeToggle
nnoremap("<leader>b", ":NvimTreeToggle<CR>", "<silent>")

-- TroubleToggle
nnoremap("<leader>l", ":TroubleToggle<CR>", "<silent>")

-----------------------------------------------------------
-- Refactoring Mappings
-----------------------------------------------------------
-- prompt for a refactor to apply when the remap is triggered
vim.keymap.set(
	"v",
	"<leader>rr",
	":lua require('refactoring').select_refactor()<CR>",
	{ noremap = true, silent = true, expr = false }
)

-----------------------------------------------------------
-- -- formatting
-----------------------------------------------------------
nnoremap("<leader>F", ":FormatWrite<CR>", "<silent>")

-----------------------------------------------------------
-- test runner
-----------------------------------------------------------
-- -- Run nearest test(s) under the cursor
vim.keymap.set("n", "<leader>tt", function()
	require("neotest").run.run()
end)
-- -- Run current file
vim.keymap.set("n", "<leader>tf", function()
	require("neotest").run.run(vim.fn.expand("%"))
end)
-- -- Run last test(s)
-- vim.keymap.set("n", "<leader>tl", function()
-- 	require("jester").run_last()
-- end)

-----------------------------------------------------------
-- bufferline
-----------------------------------------------------------
