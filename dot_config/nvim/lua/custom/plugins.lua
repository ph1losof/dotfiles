local overrides = require "custom.configs.overrides"

local plugins = {
  {
    'wakatime/vim-wakatime',
    event = "VeryLazy"
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
			require "plugins.configs.lspconfig"
			require "custom.configs.lspconfig"
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
       require "custom.configs.null-ls"
     end,
   },
   },
  {
    "williamboman/mason.nvim",
    opts = overrides.mason
  },
  {
    "nvim-tree/nvim-tree.lua",
    opts = overrides.nvimtree,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = overrides.treesitter,
    event = {"BufReadPre", "BufNewFile"},
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
    { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
    { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
    -- { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
  },
  },
  {
    "potamides/pantran.nvim",
    config = function()
      require('pantran').setup({})
    end,
  },
  {
	"ThePrimeagen/harpoon",
	lazy = false,
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = true,
	keys = {
		{ "<leader>mh", "<cmd>lua require('harpoon.mark').add_file()<cr>", desc = "Mark file with harpoon" },
		{ "<leader>nh", "<cmd>lua require('harpoon.ui').nav_next()<cr>", desc = "Go to next harpoon mark" },
		{ "<leader>ph", "<cmd>lua require('harpoon.ui').nav_prev()<cr>", desc = "Go to previous harpoon mark" },
		{ "<leader>ah", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", desc = "Show harpoon marks" },
	},
},
  {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "antoinemadec/FixCursorHold.nvim"
  }
  },
{
    "Exafunction/codeium.vim",
    event = "BufEnter",
},
  {
    "sourcegraph/sg.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      { "<leader>ss", "<cmd>lua require('sg.extensions.telescope').fuzzy_search_results()<CR>", desc = "Fuzzy Search" },
    },
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  {
    "metakirby5/codi.vim",
    event = "VeryLazy",
  },
  {
    "Pocco81/auto-save.nvim",
    event = "BufEnter",
    config = function()
      require("auto-save").setup {
        enabled = true,
        execution_message = {
		      message = function() -- message to print on save
			      return ("AutoSave: saved at " .. vim.fn.strftime("%H:%M:%S"))
	      	end,
	      	dim = 0.18, -- dim the color of `message`
		      cleaning_interval = 1250, -- (milliseconds) automatically clean MsgArea after displaying `message`. See :h MsgArea
      	},
        trigger_events = {"FocusLost", "BufLeave"},
        debounce_delay = 2000,
        callbacks = {
          before_saving = nil,
        }
      }
    end,
  },
  {
    'numToStr/Comment.nvim',
    opts = {},
    lazy = false,
  },
  {
    'nvimdev/lspsaga.nvim',
    keys = {
      { "K", "<cmd>Lspsaga hover_doc<CR>", desc = "Hover Doc" },
      { "<leader>rf", "<cmd>Lspsaga finder<CR>", desc = "LSP Finder" },
      { "<leader>ra", "<cmd>Lspsaga rename<CR>", desc = "Rename" },
      { "<leader>t", "<cmd>Lspsaga term_toggle<CR>", desc = "Terminal" },
    },
    config = function()
        require('lspsaga').setup({})
    end,
    dependencies = {
        'nvim-treesitter/nvim-treesitter', -- optional
        'nvim-tree/nvim-web-devicons'     -- optional
    }
  },
  {
    "andrewferrier/debugprint.nvim",
    event = "BufEnter",
    opts = {},
    dependencies = {
        "nvim-treesitter/nvim-treesitter"
    },
  },
  {
    'windwp/nvim-ts-autotag',
    event = "InsertEnter",
    opts = {}
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
        on_attach = require('plugins.configs.lspconfig').on_attach,
        capabilities = require('plugins.configs.lspconfig').capabilities,
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
    }
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
    opts = {}
  },
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
        require("nvim-surround").setup({})
    end
  },
  {
		"mfussenegger/nvim-dap",
    keys = {
      { "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", desc = "Toggle Breakpoint" },
      { "<leader>dB", "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>", desc = "Conditional Breakpoint" },
      { "<leader>dc", "<cmd>lua require'dap'.continue()<cr>", desc = "Continue" },
      { "<leader>dj", "<cmd>lua require'dap'.step_into()<cr>", desc = "Step Into" },
      { "<leader>dl", "<cmd>lua require'dap'.step_over()<cr>", desc = "Step Over" },
      { "<leader>dk", "<cmd>lua require'dap'.step_out()<cr>", desc = "Step Out" },
      { "<leader>dh", "<cmd>lua require'dap'.step_back()<cr>", desc = "Step Back" },
    },
	},
  -- {
  --   "quick-lint/quick-lint-js",
  --   dependencies = {
  --     "neovim/nvim-lspconfig",
  --   },
  --   file_types = { "javascript", "javascriptreact", "typescript", "typescriptreact", 'javascript.jsx', 'typescript.tsx' },
  --   config = function()
  --     require("quick-lint-js").setup()
  --   end,
  -- },
	{
		"rcarriga/nvim-dap-ui",
		config = function()
			require("dapui").setup()
      local dap, dapui = require("dap"), require("dapui")
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
    keys = {
      { "<leader>du", "<cmd>lua require'dapui'.toggle()<cr>", desc = "Toggle UI" },
    },
		requires = { "mfussenegger/nvim-dap" },
	},
  {
    "mxsdev/nvim-dap-vscode-js",
    dependencies = { "mfussenegger/nvim-dap" },
    config = function()
      require("dap-vscode-js").setup({
        debugger_path = vim.fn.stdpath("data") .. "/lazy/vscode-js-debug",
        adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost", 'node', 'chrome' },
      })
      local js_based_languages = { "typescript", "javascript", "typescriptreact", "typescript.tsx" }

for _, language in ipairs(js_based_languages) do
  require("dap").configurations[language] = {
    {
      type = "pwa-node",
      request = "launch",
      name = "Launch file",
      program = "${file}",
      cwd = "${workspaceFolder}",
    },
    {
      type = "pwa-node",
      request = "attach",
      name = "Attach",
      processId = require 'dap.utils'.pick_process,
      cwd = "${workspaceFolder}",
    },
    {
      type = "pwa-chrome",
      request = "launch",
      name = "Start Chrome with \"localhost\"",
      url = "http://localhost:3000",
      webRoot = "${workspaceFolder}",
      userDataDir = "${workspaceFolder}/.vscode/vscode-chrome-debug-userdatadir"
    }
  }
end

    end,
  },
  {
  "https://github.com/apple/pkl-neovim",
  lazy = true,
  event = "BufReadPre *.pkl",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
  },
  build = function()
    vim.cmd("TSInstall! pkl")
  end,
},
}

return plugins;
