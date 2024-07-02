local M = {}

M = {
  PATH = "prepend", -- "skip" seems to cause the spawning error
  ensure_installed = {
    -- Lua
    "lua-language-server",
    "prisma-language-server",
    "luacheck",
    "stylua",

    -- SQL
    "sqls",
    "sqlfluff",
    "sql-formatter",

    -- JavaScript/Typescript
    "typescript-language-server",
    "prettierd",
    "eslint_d",

    -- Rust
    "rust-analyzer",
    "rustfmt",

    -- File Formats
    "json-lsp",
    "jsonlint",
    "jq",
    "yaml-language-server",
    "yamllint",
    "yamlfmt",

    -- Git
    "commitlint",
    "gitlint",

    -- Writing
    "marksman",
    "markdownlint",
    "vale",
    "write-good",
    "cspell",
    "misspell",
    "proselint",

    -- Shell
    "bash-language-server",
    "beautysh",
    "shfmt",
    "shellcheck",
    "shellharden",

    -- Others
    "tailwindcss-language-server",

    -- "vscode-css-language-server",
    "css-lsp",
    "codespell",
    "dockerfile-language-server",
    "dot-language-server",
    "editorconfig-checker",
    "html-lsp",
    "emmet-language-server",
  },
  automatic_installation = true,
}

vim.api.nvim_create_user_command("MasonInstallAll", function()
  vim.cmd("MasonInstall " .. table.concat(M.ensure_installed, " "))
end, {})

return M
