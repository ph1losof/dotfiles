---@type ChadrcConfig
local M = {}

M.ui = {
	theme = "yoru",
	tabufline = {
		enabled = true,
		overriden_modules = function(modules)
			table.insert(modules, modules[1])
			table.remove(modules, 1)
		end,
	},
}
M.plugins = "custom.plugins"

return M
