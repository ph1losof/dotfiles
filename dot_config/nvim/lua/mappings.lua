require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set
local unmap = vim.keymap.del

unmap("n", "<C-n>")
unmap("n", "gc")

map("n", "<C-n>", "<cmd>Oil<cr>")
map("x", "<leader>/", "gb", { desc = "comment toggle", remap = true })
map("n", "<leader>tsv", ":vsp<CR>", { desc = "toggle vertical split", remap = true })
map("n", "<leader>tsh", ":sp<CR>", { desc = "toggle horizontal split", remap = true })
map("n", "<leader>gsp", "<cmd>Gitsigns preview_hunk<CR>", { desc = "git preview hunk", remap = true })
map("n", "<leader>gsr", "<cmd>Gitsigns reset_hunk<CR>", { desc = "git reset hunk", remap = true })
