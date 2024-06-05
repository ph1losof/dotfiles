return {
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    ---@type Flash.Config
    opts = {},
    -- stylua: ignore
    keys = {
     { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
     { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
    },
  },
  {
    "stevearc/dressing.nvim",
    opts = {},
  },
  {
    "chentoast/marks.nvim",
    event = "VeryLazy",
    opts = {
      mappings = {
        preview = "m;",
      },
    },
  },
  {
    "stevearc/conform.nvim",
    event = "BufWritePost", -- uncomment for format on save
    config = function()
      require "configs.conform"
    end,
  },
  {
    "wakatime/vim-wakatime",
    event = "VeryLazy",
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
    "andrewferrier/debugprint.nvim",
    event = "BufEnter",
    opts = {},
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
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
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    cmd = "Trouble",
    keys = {
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>cs",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
      },
      {
        "<leader>cl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
      {
        "<leader>xL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>xQ",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
    },
  },
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup {}
    end,
  },
  {
    "supermaven-inc/supermaven-nvim",
    event = "VeryLazy",
    config = function()
      require("supermaven-nvim").setup {
        disable_inline_completion = false,
      }
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    opts = {
      sources = {
        { name = "nvim_lsp" },
        { name = "supermaven" },
        { name = "luasnip" },
        { name = "buffer" },
        { name = "nvim_lua" },
        { name = "path" },
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("nvchad.configs.lspconfig").defaults()
      require "configs.lspconfig"
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
  },
  {
    "williamboman/mason.nvim",
    opts = require "plugins.overrides.mason",
  },
  {
    "nvim-tree/nvim-tree.lua",
    opts = require "plugins.overrides.nvimtree",
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = require "plugins.overrides.treesitter",
    event = { "BufReadPre", "BufNewFile" },
  },
  {
    "psliwka/vim-smoothie",
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
      require("telescope").load_extension "refactoring"
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
    "ThePrimeagen/harpoon",
    enabled = true,
    branch = "harpoon2",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    keys = function()
      local harpoon = require "harpoon"
      return {
        {
          "<leader>h1",
          function()
            harpoon:list():select(1)
          end,
          desc = "Go to harpoon mark 1",
        },
        {
          "<leader>h2",
          function()
            harpoon:list():select(2)
          end,
          desc = "Go to harpoon mark 2",
        },
        {
          "<leader>h3",
          function()
            harpoon:list():select(3)
          end,
          desc = "Go to harpoon mark 3",
        },
        {
          "<leader>h4",
          function()
            harpoon:list():select(4)
          end,
          desc = "Go to harpoon mark 4",
        },
        {
          "<leader>hn",
          function()
            harpoon:list():next()
          end,
          desc = "Go to next harpoon mark",
        },
        {
          "<leader>hp",
          function()
            harpoon:list():prev()
          end,
          desc = "Go to previous harpoon mark",
        },
        {
          "<leader>hm",
          function()
            harpoon.ui:toggle_quick_menu(harpoon:list())
          end,
          desc = "Show harpoon marks",
        },
        {
          "<leader>hx",
          function()
            harpoon:list():add()
          end,
          desc = "Mark file with harpoon",
        },
      }
    end,
    config = function(_, opts)
      require("harpoon").setup(opts)
    end,
  },
  {
    "kevinhwang91/nvim-ufo",
    dependencies = {
      "kevinhwang91/promise-async",
    },
    event = "BufRead",
    keys = {
      {
        "zR",
        function()
          require("ufo").openAllFolds()
        end,
        desc = "Open all folds",
      },
      {
        "zM",
        function()
          require("ufo").closeAllFolds()
        end,
        desc = "Close all folds",
      },
      {
        "zZ",
        function()
          require("ufo").peekFoldedLinesUnderCursor()
        end,
        desc = "Peek folded lines under cursor",
      },
    },
    opts = {
      open_fold_hl_timeout = 0,
      fold_virt_text_handler = function(text, lnum, endLnum, width)
        local suffix = " > "
        local lines = ("[%d lines] "):format(endLnum - lnum)

        local cur_width = 0
        for _, section in ipairs(text) do
          cur_width = cur_width + vim.fn.strdisplaywidth(section[1])
        end

        suffix = suffix .. (" "):rep(width - cur_width - vim.fn.strdisplaywidth(lines) - 3)

        table.insert(text, { suffix, "Comment" })
        table.insert(text, { lines, "Todo" })
        return text
      end,
      preview = {
        win_config = {
          border = { "┏", "━", "┓", "┃", "┛", "━", "┗", "┃" },
          winblend = 0,
          winhighlight = "Normal:LazyNormal",
        },
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
  {
    "windwp/nvim-ts-autotag",
    event = "InsertEnter",
    -- opts = {},
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true,
    opts = {},
    -- use opts = {} for passing setup options
    -- this is equalent to setup({}) function
  },
  {
    "pmizio/typescript-tools.nvim",
    lazy = false,
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    opts = {},
    keys = {
      { "<leader>oi", "<cmd>TSToolsOrganizeImports<cr>", desc = "Organize Imports" },
      { "<leader>ru", "<cmd>TSToolsOrganizeImports<cr>", desc = "Remove unused statements" },
      { "<leader>ami", "<cmd>TSToolsAddMissingImports<cr>", desc = "Add Missing Imports" },
    },
    config = function()
      require("typescript-tools").setup {
        on_attach = require("nvchad.configs.lspconfig").on_attach,
        capabilities = require("nvchad.configs.lspconfig").capabilities,
        file_types = {
          "typescript",
          "typescriptreact",
          "typescript.tsx",
        },
      }
    end,
  },
  {
    "Pocco81/auto-save.nvim",
    event = "BufWritePost",
    config = function()
      require("auto-save").setup {
        enabled = true,
        execution_message = {
          message = function() -- message to print on save
            return ("AutoSave: saved at " .. vim.fn.strftime "%H:%M:%S")
          end,
          dim = 0.18, -- dim the color of `message`
          cleaning_interval = 1250, -- (milliseconds) automatically clean MsgArea after displaying `message`. See :h MsgArea
        },

        condition = function(buf)
          if pcall(function()
            return vim.bo[buf].buftype
          end) then
            if vim.bo[buf].buftype ~= "" then
              return false
            end
          else
            return false
          end
        end,
        trigger_events = { "FocusLost", "BufLeave" },
        debounce_delay = 2000,
        callbacks = {
          before_saving = nil,
        },
      }
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
      require("lspsaga").setup {}
    end,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
  },
}
