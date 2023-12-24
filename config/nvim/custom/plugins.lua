local plugins = {
  {
    "nvim-neotest/neotest",
    ft = { "go", "rust", "typescript", "javascriptreact", "typescriptreact" },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-neotest/neotest-go",
      "nvim-neotest/neotest-rust",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require "custom.configs.neotest"
    end,
  },
  {
    "nvim-neotest/neotest-go",
  },
  {
    "rouge8/neotest-rust",
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "ray-x/go.nvim",
    },
    config = function ()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", { "nvim-telescope/telescope-fzf-native.nvim", build = "make" } },
    cmd = "Telescope",
    init = function()
      require("core.utils").load_mappings "telescope"
    end,
    opts = function()
      return require "custom.configs.telescope"
    end,
    config = function(_, opts)
      dofile(vim.g.base46_cache .. "telescope")
      local telescope = require "telescope"
      telescope.setup(opts)

      -- load extensions
      for _, ext in ipairs(opts.extensions_list) do
        telescope.load_extension(ext)
      end
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "gopls",
        "goimports",
        "ruff",
        "rust-analyzer",
        "elixir-ls",
        "terraform-ls",
      },
    },
  },
  {
    "mfussenegger/nvim-dap",
    init = function()
      require("core.utils").load_mappings("dap")
    end
  },
  {
    "leoluz/nvim-dap-go",
    ft = "go",
    dependencies = {
      "mfussenegger/nvim-dap",
      "rcarriga/nvim-dap-ui",
    },
    config = function(_, opts)
      require ("dap-go").setup(opts)
      require("core.utils").load_mappings("dap_go")
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = "mfussenegger/nvim-dap",
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      require("dapui").setup()
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    ft = "go",
    opts = function()
      return require "custom.configs.null-ls"
    end,
  },
  {
    "ray-x/go.nvim",
    dependencies = {  -- optional packages
      "ray-x/guihua.lua",
    },
    -- opts = function ()
    --   return require "custom.configs.go"
    -- end,
    opts = {},
    config = function(_, opts)
      require("go").setup(opts)
    end,
    event = {"CmdlineEnter"},
    ft = {"go", 'gomod'},
    build = ':lua require("go.install").update_all_sync()' -- if you need to install/update all binaries
  },
  -- RUST PLUGINS --------------------------------------------------------------
  {
    "rust-lang/rust.vim",
    ft = "rust",
    init = function ()
      vim.g.rustfmt_autosave = 1
    end
  },
  {
    "simrat39/rust-tools.nvim",
    ft = "rust",
    dependencies = "neovim/nvim-lspconfig",
    opts = function ()
      return require "custom.configs.rust-tools"
    end,
    config = function(_, opts)
      require('rust-tools').setup(opts)
    end
  },
  {
    'saecki/crates.nvim',
    ft = {"rust","toml"},
    event = { "BufRead Cargo.toml" },
    dependencies = { 'nvim-lua/plenary.nvim' },
    -- opts = function()
    --   return {
    --     null_ls = {
    --       enabled = true,
    --       name = "crates.nvim",
    --     }
    --   }
    -- end,
    config = function(_, _)
      local crates = require('crates')
      crates.setup()
      crates.show()
     require("core.utils").load_mappings("crates")
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    opts = function()
      local M = require "plugins.configs.cmp"
      table.insert(M.sources, {name = "crates"})
      return M
    end
  },
  {
    "epwalsh/pomo.nvim",
    version = "*",  -- Recommended, use latest release instead of latest commit
    lazy = true,
    cmd = { "TimerStart", "TimerRepeat" },
    dependencies = {
      -- Optional, but highly recommended if you want to use the "Default" timer
      "rcarriga/nvim-notify",
    },
    opts = function ()
      return require "custom.configs.pomo"
    end,
    config = function(_, opts)
      require('pomo').setup(opts)
    end,
  },
  {
    "nvim-tree/nvim-web-devicons",
  },
  {
    "folke/noice.nvim",
     event = "VeryLazy",
     dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    config = function()
      return require "custom.configs.noice"
    end,
  },
  {
    "echasnovski/mini.nvim",
    event = "VeryLazy",
    config = function()
      require("mini.animate").setup {
        scroll = {
          enable = false,
        },
      }
    end,
  },
  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
  },
  {
    "ThePrimeagen/vim-be-good",
    ft = {"markdown"},
  },
  {
  "johmsalas/text-case.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    -- Author's Note: If default keymappings fail to register (possible config issue in my local setup),
    -- verify lazy loading functionality. On failure, disable lazy load and report issue
    -- lazy = false,
    config = function()
      require("textcase").setup({
          default_keymappings_enabled = false,
        })
      require("telescope").load_extension("textcase")
    end,
  }
}

return plugins
