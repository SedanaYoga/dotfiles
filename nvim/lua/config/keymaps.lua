-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- -- Escape Insert Mode
local keymap = vim.keymap
local opts = { noremap = true, silent = true }

-- Escape
keymap.set("i", "jj", "<Esc>")

-- Delete a word backwards
keymap.set("n", "dw", 'vb"_d')

-- Persist yanked text
keymap.set("v", "p", '"_dP')

-- Select all
keymap.set("n", "<C-a>", "gg<S-v>G")

-- Stay in indent Mode
keymap.set("v", "<", "<gv")
keymap.set("v", ">", ">gv")

-- Do not yank with x
keymap.set("n", "x", '"_x')

-- Comment
vim.api.nvim_set_keymap("n", "<leader>/", "gcc", {})
vim.api.nvim_set_keymap("x", "<leader>/", "gc", {})

-- No Highlights
keymap.set("n", "<Leader>h", "<cmd>nohlsearch<CR>", { desc = "Remove Highlight" })

-- Move text up and down
keymap.set("x", "J", ":move '>+1<CR>gv-gv")
keymap.set("x", "K", ":move '<-2<CR>gv-gv")

-- Yank line down and up
keymap.set("n", "<Leader>j", "yypk<cr>", { desc = "Yank Line Down" })
keymap.set("n", "<Leader>k", "yyPj<cr>", { desc = "Yank Line Up" })
keymap.set("x", "<Leader>j", ":co '><CR>V'[=gv", { desc = "Yank Line Down" })
keymap.set("x", "<Leader>k", ":co '<-1<CR>V'[=gv", { desc = "Yank Line Up" })

-- Bufferline
keymap.set("n", "<Tab>", "<Cmd>BufferLineCycleNext<CR>", opts)
keymap.set("n", "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", opts)
keymap.set("n", "<Leader>;h", "<Cmd>BufferLineCloseLeft<CR>", opts)
keymap.set("n", "<Leader>;l", "<Cmd>BufferLineCloseRight<CR>", opts)
keymap.set("n", "<Leader>;p", "<Cmd>BufferLineTogglePin<CR>", opts)
keymap.set("n", ";c", "<Cmd>bd<Cr>")

-- Telescope
keymap.set("n", ";r", "<cmd>Telescope live_grep<cr>")
keymap.set("n", ";f", function()
  require("telescope.builtin").find_files({
    no_ignore = false,
    hidden = false,
  })
end)

-- Flutter Tools
keymap.set("n", "<leader>wr", "<cmd>FlutterRun<CR>")
keymap.set("n", "<leader>we", "<cmd>FlutterEmulators<CR>")
keymap.set("n", "<leader>wt", "<cmd>FlutterRestart<CR>")
