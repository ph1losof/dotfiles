-- This file  needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/NvChad/blob/v2.5/lua/nvconfig.lua

---@type ChadrcConfig
local M = {}

M.ui = {
  theme = "catppuccin",
  tabufline = {
    enabled = false,
  },
  statusline = {
    order = { "mode", "file", "harpoon", "diagnostics", "git", "%=", "lsp_msg", "%=", "lsp", "cursor", "cwd" },
    modules = {
      harpoon = function()
        return "%#St_lspHints# " .. require("harpoonline").format() .. ""
      end,
    },
  },
  nvdash = {
    load_on_startup = true,
  },
}

return M
