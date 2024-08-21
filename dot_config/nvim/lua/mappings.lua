require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set
local unmap = vim.keymap.del

-- map("n", ";", ":", { desc = "CMD enter command mode" })
-- map("i", "jk", "<ESC>")

-- map("n", "<A-j>", ":m .+1<CR>==") -- move line up(n)
-- map("n", "<A-k>", ":m .-2<CR>==") -- move line down(n)
-- map("v", "<A-j>", ":m '>+1<CR>gv=gv") -- move line up(v)
-- map("v", "<A-k>", ":m '<-2<CR>gv=gv") -- move line down(v)
unmap("n", "<C-n>")
unmap("n", "gc")

map("n", "<C-n>", "<cmd>Oil<cr>")
map("x", "<leader>/", "gb", { desc = "comment toggle", remap = true })
map("n", "<leader>tsv", ":vsp<CR>", { desc = "toggle vertical split", remap = true })
map("n", "<leader>tsh", ":sp<CR>", { desc = "toggle horizontal split", remap = true })
map("n", "<leader>gsp", "<cmd>Gitsigns preview_hunk<CR>", { desc = "git preview hunk", remap = true })
map("n", "<leader>gsr", "<cmd>Gitsigns reset_hunk<CR>", { desc = "git reset hunk", remap = true })
