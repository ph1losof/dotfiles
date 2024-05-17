local M = {}

M.mason = {
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
	},
	automatic_installation = true,
}

vim.api.nvim_create_user_command("MasonInstallAll", function()
	vim.cmd("MasonInstall " .. table.concat(M.mason.ensure_installed, " "))
end, {})

M.treesitter = {
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

M.nvimtree = {
	view = {
		side = "right",
	},
	git = {
		enable = true,
		ignore = false,
	},
	renderer = {
		highlight_git = true,
		icons = {
			show = {
				git = true,
			},
		},
	},
}

return M
