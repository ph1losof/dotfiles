return {
  {
    "m4xshen/hardtime.nvim",
    dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
    opts = {},
  },
  {
    "sindrets/diffview.nvim",
    event = "VeryLazy",
    keys = {
      { "<leader>dv", "<cmd>DiffviewOpen<cr>" },
      { "<leader>df", "<cmd>DiffviewFileHistory %<cr>" },
      { "<leader>dc", "<cmd>set hidden<cr><cmd>DiffviewClose<cr><cmd>set nohidden<cr>" },
    },
    opts = {},
  },
  { "tpope/vim-sleuth", opts = {} },
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
    event = "BufWritePre", -- uncomment for format on save
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
        "<leader>tg",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>tt",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>tq",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
    },
  },
  {
    "kylechui/nvim-surround",
    version = "*",
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
        disable_inline_completion = true,
      }
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    opts = {
      sources = {
        { name = "luasnip" },
        { name = "nvim_lsp" },
        { name = "supermaven" },
        { name = "cmdline" },
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
    "nvim-treesitter/nvim-treesitter",
    opts = require "plugins.overrides.treesitter",
    event = { "BufReadPre", "BufNewFile" },
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
          "<leader>ha",
          function()
            harpoon:list():add()
          end,
          desc = "Add buffer to harpoon",
        },
        {
          "<leader>hd",
          function()
            harpoon:list():remove()
          end,
          desc = "Delete buffer from harpoon",
        },
      }
    end,
    config = function(_, opts)
      require("harpoon").setup(opts)
    end,
  },
  {
    "nvchad/ui",
    dependencies = {
      "abeldekat/harpoonline",
      config = function()
        require("harpoonline").setup {
          on_update = function()
            vim.cmd.redrawstatus()
          end,
        }
      end,
    },
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
      },
      desc = "Open all folds",
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
      require("bqf").setup {
        preview = {
          winblend = 0,
        },
      }
    end,
  },
  {
    "windwp/nvim-ts-autotag",
    event = "InsertEnter",
    config = true,
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true,
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
        on_attach = function(client, bufnr)
          require("nvchad.configs.lspconfig").on_attach(client, bufnr)
        end,
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
    "okuuva/auto-save.nvim",
    cmd = "ASToggle", -- optional for lazy loading on command
    event = { "InsertLeave", "TextChanged" }, -- optional for lazy loading on trigger events
    config = function()
      require("auto-save").setup {
        condition = function(buf)
          local fn = vim.fn
          local utils = require "auto-save.utils.data"
          if pcall(function()
            return vim.bo[buf].buftype
          end) then
            if vim.bo[buf].buftype ~= "" then
              return false
            end
          else
            return false
          end

          if fn.getbufvar(buf, "&modifiable") == 1 and utils.not_in(fn.getbufvar(buf, "&filetype"), {}) then
            return true -- met condition(s), can save
          end
          return false -- can't save
        end,
      }
    end,
    debounce_delay = 250,
  },
  {
    "nvimdev/lspsaga.nvim",
    event = "LspAttach",
    keys = {
      { "K", "<cmd>Lspsaga hover_doc<CR>", desc = "Hover Doc" },
      { "<leader>gf", "<cmd>Lspsaga finder<CR>", desc = "LSP Finder" },
      { "<leader>gr", "<cmd>Lspsaga rename<CR>", desc = "Rename" },
      { "<leager>gp", "<cmd>Lspsaga peek_definition<CR>", desc = "Preview Definition" },
      { "<leader>gpt", "<cmd>Lspsaga peek_type_definition<CR>", desc = "Preview Type Definition" },
      { "<leader>gd", "<cmd>Lspsaga goto_definition<CR>", desc = "Outline" },
      { "<leader>gt", "<cmd>Lspsaga goto_type_definition<CR>", desc = "Outline" },
      { "<leader>ol", "<cmd>Lspsaga outline<CR>", desc = "Outline" },
    },
    config = function()
      require("lspsaga").setup {}
    end,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
  },
  {
    "folke/todo-comments.nvim",
    event = "VimEnter",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader>ct", "<cmd>TodoTelescope<cr>", desc = "Todo Telescope" },
      { "<leader>cq", "<cmd>TodoQuickFix<cr>", desc = "Todo Quickfix" },
    },
    opts = { signs = false },
  },
  {
    "nvim-telescope/telescope.nvim",
    opts = function()
      local conf = require "nvchad.configs.telescope"

      conf.defaults.mappings.i = {
        ["<C-j>"] = require("telescope.actions").move_selection_next,
        ["<C-k>"] = require("telescope.actions").move_selection_previous,
        ["<Esc>"] = require("telescope.actions").close,
      }

      return conf
    end,
    keys = {
      { "<leader>fr", "<cmd>Telescope resume<cr>", desc = "Resume" },
      { "<leader>fsd", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Document symbols" },
      { "<leader>fsw", "<cmd>Telescope lsp_workspace_symbols<cr>", desc = "Workspace symbols" },
      { "<leader>fd", "<cmd>Telecope diagnostics<cr>", desc = "Diagnostics" },
      { "<leader>fq", "<cmd>Telescope quickfix<cr>", desc = "Quickfix" },
      { "<leader>fa", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
    },
  },
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { "<C-n>", "<cmd>Oil<cr>", desc = "Open parent directory" },
    },
    config = function()
      require("oil").setup {
        columns = { "icon" },
        default_file_explorer = true,
        skip_confirm_for_simple_edits = true,
        delete_to_trash = true,
        keymaps = {
          ["<C-h>"] = false,
          ["<M-h>"] = "actions.select_split",
        },
        view_options = {
          show_hidden = true,
          natural_order = true,

          is_always_hidden = function(name, _)
            return name == ".." or name == ".git"
          end,
        },
      }

      if vim.fn.argv(0) == "" then
        vim.cmd "Oil"
      end
    end,
    lazy = false,
  },
  {
    "monaqa/dial.nvim",
    -- stylua: ignore
    keys = {
      { "<C-a>", function() return require("dial.map").inc_normal() end, expr = true, desc = "Increment" },
      { "<C-x>", function() return require("dial.map").dec_normal() end, expr = true, desc = "Decrement" },
    },
    config = function()
      local augend = require "dial.augend"
      local logical_alias = augend.constant.new {
        elements = { "&&", "||" },
        word = false,
        cyclic = true,
      }

      local ordinal_numbers = augend.constant.new {
        -- elements through which we cycle. When we increment, we go down
        -- On decrement we go up
        elements = {
          "first",
          "second",
          "third",
          "fourth",
          "fifth",
          "sixth",
          "seventh",
          "eighth",
          "ninth",
          "tenth",
        },
        -- if true, it only matches strings with word boundary. firstDate wouldn't work for example
        word = false,
        -- do we cycle back and forth (tenth to first on increment, first to tenth on decrement).
        -- Otherwise nothing will happen when there are no further values
        cyclic = true,
      }

      local weekdays = augend.constant.new {
        elements = {
          "Monday",
          "Tuesday",
          "Wednesday",
          "Thursday",
          "Friday",
          "Saturday",
          "Sunday",
        },
        word = true,
        cyclic = true,
      }

      local months = augend.constant.new {
        elements = {
          "January",
          "February",
          "March",
          "April",
          "May",
          "June",
          "July",
          "August",
          "September",
          "October",
          "November",
          "December",
        },
        word = true,
        cyclic = true,
      }

      local capitalized_boolean = augend.constant.new {
        elements = {
          "True",
          "False",
        },
        word = true,
        cyclic = true,
      }
      require("dial.config").augends:register_group {
        default = {
          augend.integer.alias.decimal,
          augend.integer.alias.hex,
          augend.date.alias["%Y/%m/%d"],
          logical_alias,
          ordinal_numbers,
          weekdays,
          months,
          capitalized_boolean,
          augend.constant.alias.bool,
          augend.semver.alias.semver,
          augend.constant.new { elements = { "let", "const" } },
        },
      }
    end,
  },
  {
    "echasnovski/mini.move",
    opts = {
      mappings = {
        left = "<S-left>",
        right = "<S-right>",
        down = "<S-down>",
        up = "<S-up>",
        line_left = "<S-left>",
        line_right = "<S-right>",
        line_down = "<S-down>",
        line_up = "<S-up>",
      },
    },
    config = function(_, opts)
      require("mini.move").setup(opts)
    end,
    event = "VeryLazy",
  },
  {
    "echasnovski/mini.bracketed",
    config = function()
      require("mini.bracketed").setup()
    end,
    event = "VeryLazy",
  },
  {
    "jinh0/eyeliner.nvim",
    config = function()
      require("eyeliner").setup {
        highlight_on_key = true,
        default_keymaps = true,
      }
    end,
    event = "VeryLazy",
  },
  {
    "laytan/tailwind-sorter.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-lua/plenary.nvim" },
    build = "cd formatter && npm ci && npm run build",
    event = "VeryLazy",
    config = function()
      require("tailwind-sorter").setup {
        on_save_enabled = true, -- If `true`, automatically enables on save sorting.
        on_save_pattern = { "*.html", "*.js", "*.jsx", "*.tsx", "*.twig", "*.hbs", "*.php", "*.heex", "*.astro" }, -- The file patterns to watch and sort.
        node_path = "node",
      }
    end,
  },
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    config = function()
      require("ts_context_commentstring").setup {
        enable_autocmd = false,
      }
    end,
  },
  {
    "numToStr/Comment.nvim",
    dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
    lazy = false,
    config = function()
      require("Comment").setup {
        pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
      }
    end,
  },
}
