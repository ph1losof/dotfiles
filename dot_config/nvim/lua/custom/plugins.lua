local overrides = require("custom.configs.overrides")

local plugins = {
	{
		"wakatime/vim-wakatime",
		event = "VeryLazy",
	},
	{
		"ThePrimeagen/harpoon",
		branch = "master",
		lazy = false,
		dependencies = { "nvim-lua/plenary.nvim" },
		config = true,
		keys = {
			{ "<leader>hx", "<cmd>lua require('harpoon.mark').add_file()<cr>", desc = "Mark file with harpoon" },
			{ "<leader>hn", "<cmd>lua require('harpoon.ui').nav_next()<cr>", desc = "Go to next harpoon mark" },
			{ "<leader>hp", "<cmd>lua require('harpoon.ui').nav_prev()<cr>", desc = "Go to previous harpoon mark" },
			{ "<leader>hm", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", desc = "Show harpoon marks" },
			{ "<leader>h1", '<cmd>lua require("harpoon.ui").nav_file(1)<cr>', desc = "Go to harpoon mark 1" },
			{ "<leader>h2", '<cmd>lua require("harpoon.ui").nav_file(2)<cr>', desc = "Go to harpoon mark 2" },
			{ "<leader>h3", '<cmd>lua require("harpoon.ui").nav_file(3)<cr>', desc = "Go to harpoon mark 3" },
			{ "<leader>h4", '<cmd>lua require("harpoon.ui").nav_file(4)<cr>', desc = "Go to harpoon mark 4" },
		},
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			require("plugins.configs.lspconfig")
			require("custom.configs.lspconfig")
		end,
		opts = {
			servers = {
				tailwindcss = {
					hovers = true,
					suggestions = true,
					root_dir = function(fname)
						local root_pattern = require("lspconfig").util.root_pattern(
							"tailwind.config.cjs",
							"tailwind.config.ts",
							"tailwind.config.mjs",
							"tailwind.config.js",
							"postcss.config.js"
						)
						return root_pattern(fname)
					end,
				},
			},
		},
		dependencies = {
			"nvimtools/none-ls.nvim",
			after = "nvim-lspconfig",
			config = function()
				require("custom.configs.null-ls")
			end,
		},
	},
	{
		"williamboman/mason.nvim",
		opts = overrides.mason,
	},
	{
		"nvim-tree/nvim-tree.lua",
		opts = overrides.nvimtree,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		opts = overrides.treesitter,
		event = { "BufReadPre", "BufNewFile" },
	},
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		---@type Flash.Config
		opts = {},
  -- stylua: ignore
  keys = {
    { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
    { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
    -- { "S", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
    -- { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
    -- { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
  },
	},
	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			"antoinemadec/FixCursorHold.nvim",
		},
	},
	{
		"metakirby5/codi.vim",
		event = "VeryLazy",
	},
	{
		"Pocco81/auto-save.nvim",
		event = "BufEnter",
		config = function()
			require("auto-save").setup({
				enabled = true,
				execution_message = {
					message = function() -- message to print on save
						return ("AutoSave: saved at " .. vim.fn.strftime("%H:%M:%S"))
					end,
					dim = 0.18, -- dim the color of `message`
					cleaning_interval = 1250, -- (milliseconds) automatically clean MsgArea after displaying `message`. See :h MsgArea
				},
				trigger_events = { "FocusLost", "BufLeave" },
				debounce_delay = 2000,
				callbacks = {
					before_saving = nil,
				},
			})
		end,
	},
	{
		"nvimdev/lspsaga.nvim",
		keys = {
			{ "K", "<cmd>Lspsaga hover_doc<CR>", desc = "Hover Doc" },
			{ "<leader>gf", "<cmd>Lspsaga finder<CR>", desc = "LSP Finder" },
			{ "<leader>gr", "<cmd>Lspsaga rename<CR>", desc = "Rename" },
			{ "<leader>t", "<cmd>Lspsaga term_toggle<CR>", desc = "Terminal" },
			{ "<leader>gp", "<cmd>Lspsaga peek_definition<CR>", desc = "Preview Definition" },
			{ "<leader>gpt", "<cmd>Lspsaga peek_type_definition<CR>", desc = "Preview Type Definition" },
		},
		config = function()
			require("lspsaga").setup({})
		end,
		dependencies = {
			"nvim-treesitter/nvim-treesitter", -- optional
			"nvim-tree/nvim-web-devicons", -- optional
		},
	},
	{
		"andrewferrier/debugprint.nvim",
		event = "BufEnter",
		opts = {},
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
	},
	{
		"windwp/nvim-ts-autotag",
		event = "InsertEnter",
		-- opts = {},
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
		-- use opts = {} for passing setup options
		-- this is equalent to setup({}) function
	},
	{
		"pmizio/typescript-tools.nvim",
		lazy = false,
		dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
		opts = {},
		after = "nvimtools/none-ls.nvim",
		keys = {
			{ "<leader>oi", "<cmd>TSToolsOrganizeImports<cr>", desc = "Organize Imports" },
			{ "<leader>ru", "<cmd>TSToolsOrganizeImports<cr>", desc = "Remove unused statements" },
			{ "<leader>ami", "<cmd>TSToolsAddMissingImports<cr>", desc = "Add Missing Imports" },
		},
		config = function()
			require("typescript-tools").setup({
				on_attach = require("plugins.configs.lspconfig").on_attach,
				capabilities = require("plugins.configs.lspconfig").capabilities,
				file_types = {
					"typescript",
					"typescriptreact",
					"typescript.tsx",
				},
			})
		end,
	},
	{
		"mbbill/undotree",
		cmd = "UndotreeToggle",
		keys = {
			{ "<leader>u", "<cmd>UndotreeToggle<cr>", desc = "Toggle Undotree" },
		},
	},
	{
		"folke/trouble.nvim",
		event = "BufRead",
		lazy = false,
		keys = {
			{ "<leader>xx", "<cmd>TroubleToggle<cr>", desc = "Trouble Toggle" },
			{ "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Workspace Diagnostics" },
			{ "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>", desc = "Document Diagnostics" },
			{ "<leader>xq", "<cmd>TroubleToggle quickfix<cr>", desc = "Quickfix" },
			{ "<leader>xl", "<cmd>TroubleToggle loclist<cr>", desc = "Location List" },
			{ "<leader>xr", "<cmd>TroubleToggle lsp_references<cr>", desc = "LSP References" },
		},
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {},
	},
	{
		"kylechui/nvim-surround",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({})
		end,
	},
	{
		"mfussenegger/nvim-dap",
		config = function()
			local dap = require("dap")

			for _, language in ipairs({ "typescript", "javascript", "typescriptreact", "javascriptreact" }) do
				if not dap.configurations[language] then
					dap.configurations[language] = {
						-- Debug single nodejs files
						{
							type = "pwa-node",
							request = "launch",
							name = "Launch file",
							program = "${file}",
							cwd = vim.fn.getcwd(),
							sourceMaps = true,
						},
						-- Debug nodejs processes (make sure to add --inspect when you run the process)
						{
							type = "pwa-node",
							request = "attach",
							name = "Attach",
							processId = require("dap.utils").pick_process({ filter = "node" }),
							program = "${file}",
							cwd = vim.fn.getcwd(),
							sourceMaps = true,
						},
						-- Debug web applications (client side)
						{
							type = "pwa-chrome",
							request = "attach",
							port = 9222,
							name = "Client-Side Attach to Chrome(9222)",
							webRoot = vim.fn.getcwd(),
							protocol = "inspector",
							sourceMaps = true,
							userDataDir = false,
						},
						-- Divider for the launch.json derived configs
						{
							name = "----- ↓ launch.json configs ↓ -----",
							type = "",
							request = "launch",
						},
					}
				end
			end
		end,
		dependencies = {
			{
				"williamboman/mason.nvim",
				opts = function(_, opts)
					opts.ensure_installed = opts.ensure_installed or {}
					table.insert(opts.ensure_installed, "js-debug-adapter")
				end,
			},
			-- fancy UI for the debugger
			{
				"rcarriga/nvim-dap-ui",
				dependencies = { "nvim-neotest/nvim-nio" },
      -- stylua: ignore
      keys = {
        { "<leader>du", function() require("dapui").toggle({ }) end, desc = "Dap UI" },
        { "<leader>de", function() require("dapui").eval() end, desc = "Eval", mode = {"n", "v"} },
      },
				opts = {},
				config = function(_, opts)
					-- setup dap config by VsCode launch.json file
					-- require("dap.ext.vscode").load_launchjs()
					local dap = require("dap")
					local dapui = require("dapui")
					dapui.setup(opts)
					dap.listeners.after.event_initialized["dapui_config"] = function()
						dapui.open({})
					end
					dap.listeners.before.event_terminated["dapui_config"] = function()
						dapui.close({})
					end
					dap.listeners.before.event_exited["dapui_config"] = function()
						dapui.close({})
					end
				end,
			},
			-- Install the vscode-js-debug adapter
			{
				"microsoft/vscode-js-debug",
				-- After install, build it and rename the dist directory to out
				build = "npm install --legacy-peer-deps --no-save && npx gulp vsDebugServerBundle && rm -rf out && mv dist out",
				version = "1.*",
			},
			{
				"mxsdev/nvim-dap-vscode-js",
				config = function()
					---@diagnostic disable-next-line: missing-fields
					require("dap-vscode-js").setup({
						debugger_path = vim.fn.resolve(vim.fn.stdpath("data") .. "/lazy/vscode-js-debug"),

						adapters = {
							"chrome",
							"pwa-node",
							"pwa-chrome",
							"pwa-msedge",
							"pwa-extensionHost",
							"node-terminal",
						},
					})
				end,
			},

			-- virtual text for the debugger
			{
				"theHamsta/nvim-dap-virtual-text",
				opts = {},
			},
		},

  -- stylua: ignore
  keys = {
    { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Breakpoint Condition" },
    { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
    { "<leader>dc", function() require("dap").continue() end, desc = "Continue" },
    { "<leader>da", function() require("dap").continue({ before = get_args }) end, desc = "Run with Args" },
    { "<leader>dC", function() require("dap").run_to_cursor() end, desc = "Run to Cursor" },
    { "<leader>dg", function() require("dap").goto_() end, desc = "Go to Line (No Execute)" },
    { "<leader>di", function() require("dap").step_into() end, desc = "Step Into" },
    { "<leader>dj", function() require("dap").down() end, desc = "Down" },
    { "<leader>dk", function() require("dap").up() end, desc = "Up" },
    { "<leader>dl", function() require("dap").run_last() end, desc = "Run Last" },
    { "<leader>do", function() require("dap").step_out() end, desc = "Step Out" },
    { "<leader>dO", function() require("dap").step_over() end, desc = "Step Over" },
    { "<leader>dp", function() require("dap").pause() end, desc = "Pause" },
    { "<leader>dr", function() require("dap").repl.toggle() end, desc = "Toggle REPL" },
    { "<leader>ds", function() require("dap").session() end, desc = "Session" },
    { "<leader>dt", function() require("dap").terminate() end, desc = "Terminate" },
    { "<leader>dw", function() require("dap.ui.widgets").hover() end, desc = "Widgets" },
  },
	},
	{
		"psliwka/vim-smoothie",
		event = "BufEnter",
	},
	{
		"Exafunction/codeium.vim",
		event = "BufEnter",
	},
	{
		"kdheepak/lazygit.nvim",
		cmd = {
			"LazyGit",
			"LazyGitConfig",
			"LazyGitCurrentFile",
			"LazyGitFilter",
			"LazyGitFilterCurrentFile",
		},
		-- optional for floating window border decoration
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		-- setting the keybinding for LazyGit with 'keys' is recommended in
		-- order to load the plugin when the command is run for the first time
		keys = {
			{ "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
		},
	},
	{
		"nvim-pack/nvim-spectre",
		opts = { open_cmd = "noswapfile vnew" },
		keys = {
			{ "<leader>fr", "<cmd>lua require('spectre').open()<cr>", desc = "Open Spectre" },
		},
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	{
		"ThePrimeagen/refactoring.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			require("refactoring").setup()
			require("telescope").load_extension("refactoring")
		end,
		keys = {
			{
				"<leader>rr",
				function()
					require("telescope").extensions.refactoring.refactors()
				end,
				desc = "Refactor",
			},
		},
	},
	{
		"kevinhwang91/nvim-bqf",
		event = "VeryLazy",
		dependencies = {
			"junegunn/fzf",
		},
		config = function()
			require("bqf").setup()
		end,
		keys = {
			{ "<leader>qf", "<cmd>lua require('bqf').open()<cr>", desc = "Quickfix" },
		},
	},
}

return plugins
