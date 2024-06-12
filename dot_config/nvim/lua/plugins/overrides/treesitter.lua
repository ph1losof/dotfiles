local M = {}

M = {
  autotag = {
    enable = true,
  },
  highight = {
    enable = true,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<leader><tab>",
      node_incremental = "<leader><tab>",
      node_decremental = "<bs>",
      scope_incremental = false,
    },
  },
  ensure_installed = {
    "bash",
    "cmake",
    "css",
    "dockerfile",
    "dot",
    "git_rebase",
    "gitattributes",
    "gitcommit",
    "gitignore",
    "html",
    "http",
    "javascript",
    "jq",
    "json",
    "json5",
    "jsonc",
    "lua",
    "make",
    "markdown",
    "markdown_inline",
    "nix",
    "org",
    "python",
    "regex",
    "rust",
    "sql",
    "comment",
    "svelte",
    "sxhkdrc",
    "todotxt",
    "toml",
    "typescript",
    "svelte",
    "tsx",
    "vim",
    "yaml",
  },
}

return M
