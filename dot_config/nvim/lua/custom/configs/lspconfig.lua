local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"

local util = require "lspconfig/util"

lspconfig.rust_analyzer.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  file_types = {"rust"},
  root_dir = util.root_pattern("Config.toml"),
})

lspconfig.html.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

lspconfig.cssls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

lspconfig.eslint.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

lspconfig.tailwindcss.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

-- lspconfig.quick_lint_js.setup({
--  on_attach = on_attach,
--  capabilities = capabilities
-- })

--[[ local function organize_imports()
  local params = {
    command = "_typescript.organizeImports",
    arguments = {vim.api.nvim_buf_get_name(0)},
    title = ""
  }
  vim.lsp.buf.execute_command(params)
end

lspconfig.tsserver.setup({
on_attach = on_attach,
capabilities = capabilities,
commands = {
    TSOrganizeImports = {
      organize_imports,
      description = "Organize Imports"
    }
  },
file_types = { "typescript", "typescriptreact", "typescript.tsx" },
cmd = { "typescript-language-server", '--stdio' }
}) ]]
