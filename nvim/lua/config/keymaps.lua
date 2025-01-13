-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
-- This file is automatically loaded by lazyvim.config.init

-- DO NOT USE THIS IN YOU OWN CONFIG!!
-- use `vim.map` instead
local map = vim.keymap.set

-- Escape
map("i", "jj", "<Esc>")

-- Delete a word backwards
map("n", "dw", 'vb"_d')

-- Persist yanked text
map("v", "p", '"_dP')

-- Select all
map("n", "<C-a>", "gg<S-v>G")

-- Stay in indent Mode
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Do not yank with x
map("n", "x", '"_x')

-- No Highlights
map("n", "<Leader>h", "<cmd>nohlsearch<CR>", { desc = "Remove Highlight" })

-- Move text up and down
map("x", "J", ":move '>+1<CR>gv-gv")
map("x", "K", ":move '<-2<CR>gv-gv")

-- Yank line down and up
map("n", "<Leader>j", "yypk<cr>", { desc = "Yank Line Down" })
map("n", "<Leader>k", "yyPj<cr>", { desc = "Yank Line Up" })
map("x", "<Leader>j", ":co '><CR>V'[=gv", { desc = "Yank Line Down" })
map("x", "<Leader>k", ":co '<-1<CR>V'[=gv", { desc = "Yank Line Up" })

-- Bufferline
map("n", "<Tab>", "<Cmd>BufferLineCycleNext<CR>", {})
map("n", "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", {})
map("n", "<Leader>;h", "<Cmd>BufferLineCloseLeft<CR>", {})
map("n", "<Leader>;l", "<Cmd>BufferLineCloseRight<CR>", {})
map("n", "<Leader>;p", "<Cmd>BufferLineTogglePin<CR>", {})
map("n", ";c", "<Cmd>bd<Cr>")

-- Telescope
map("n", ";r", "<cmd>FzfLua live_grep<cr>")
map("n", ";f", "<cmd>FzfLua files<cr>")

-- Flutter Tools
map("n", "<leader>wr", "<cmd>FlutterRun<CR>")
map("n", "<leader>we", "<cmd>FlutterEmulators<CR>")
map("n", "<leader>wt", "<cmd>FlutterRestart<CR>")

map("i", "<C-[>", function()
  require("copilot.suggestion").prev()
end)

map("i", "<C-]>", function()
  require("copilot.suggestion").next()
end)

map("i", "<M-l>", function()
  require("copilot.suggestion").accept()
end)

map("i", "<C-]>", function()
  require("copilot.suggestion").dismiss()
end)
