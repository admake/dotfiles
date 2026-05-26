-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

map("n", "<leader>ll", "<cmd>Lazy<cr>", { desc = "Lazy" })

-- Obsidian
map("n", "<leader>o", ":Obsidian<CR>", { desc = "Obsidian picker" })
