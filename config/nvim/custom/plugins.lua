local plugins = {
  {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  opts = {},
  },
  {
    "nvim-neotest/neotest",
    ft = { "go", "rust", "typescript", "javascriptreact", "typescriptreact" },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-neotest/neotest-go",
      "rouge8/neotest-rust",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require "custom.configs.neotest"
    end,
  },
  {
    "neovim/nvim-lspconfig",
    ft = { "go", "rust", "terraform", "typescript", "javascriptreact", "typescriptreact" },
    dependencies = {
      "ray-x/go.nvim",
    },
    config = function ()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end
  },
  {
    "VonHeikemen/lsp-zero.nvim",
    requires = {
		  -- LSP Support
		  {'neovim/nvim-lspconfig'},
		  {'williamboman/mason.nvim'},
		  {'williamboman/mason-lspconfig.nvim'},

		  -- Autocompletion
		  {'hrsh7th/nvim-cmp'},
		  {'hrsh7th/cmp-buffer'},
		  {'hrsh7th/cmp-path'},
		  {'saadparwaiz1/cmp_luasnip'},
		  {'hrsh7th/cmp-nvim-lsp'},
		  {'hrsh7th/cmp-nvim-lua'},
    },
    config = function()
        local lsp = require("lsp-zero")

        lsp.preset("recommended")

        lsp.ensure_installed({
          'gopls',
          'terraform-ls',
          'rust_analyzer',
        })
        lsp.on_attach(function(client, bufnr)
          -- local opts = {buffer = bufnr, remap = false}
          -- vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
          -- vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
          -- vim.keymap.set("n", "<leader>gws", function() vim.lsp.buf.workspace_symbol() end, opts)
          -- vim.keymap.set("n", "<leader>gd", function() vim.diagnostic.open_float() end, opts)
          -- vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
          -- vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
          -- vim.keymap.set("n", "<leader>gca", function() vim.lsp.buf.code_action() end, opts)
          -- vim.keymap.set("n", "<leader>grr", function() vim.lsp.buf.references() end, opts)
          -- vim.keymap.set("n", "<leader>grn", function() vim.lsp.buf.rename() end, opts)
          -- vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
        end)
        lsp.setup()
        vim.diagnostic.config({
          virtual_text = true
        })
     end,
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
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
        "stylua",
        "gopls",
        "gci",
        "golangci-lint",
        "rust-analyzer",
        "elixir-ls",
        "terraform-ls",
        "tflint",
        "mdformat",
        "cpptools",
        "codelldb",
        "buf-language-server", -- lsp (prototype, not feature-complete yet, rely on buf for now)
        "buf", -- formatter, linter
        "protolint", -- linter
      },
    },
  },
  {
    "mfussenegger/nvim-dap",
    init = function()
      require("core.utils").load_mappings("dap")
      -- require "custom.configs.dap"
    end,
    config = function()
		require("dap").adapters.codelldb = {
			type = 'server',
			host = '127.0.0.1',
			port = 13000,
			executable = {
				command = vim.fn.stdpath("data") .. "/mason/packages/codelldb/extension/adapter/codelldb",
				args = {"--port", "13000"},

				-- on windows you may have to uncomment this:
				-- detached = false,
			},
		}
	end,
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
    "ray-x/go.nvim",
    dependencies = {  -- optional packages
      "ray-x/guihua.lua",
    },
    -- opts = function ()
    --   return require "custom.configs.go"
    -- end,
    opts = {
      disable_defaults = false, -- true|false when true set false to all boolean settings and replace all table
      -- settings with {}
      go='go', -- go command, can be go[default] or go1.18beta1
      goimport='gopls', -- goimport command, can be gopls[default] or either goimport or golines if need to split long lines
      fillstruct = 'gopls', -- default, can also use fillstruct
      gofmt = 'gofumpt', --gofmt cmd,
      max_line_len = 128, -- max line length in golines format, Target maximum line length for golines
      tag_transform = false, -- can be transform option("snakecase", "camelcase", etc) check gomodifytags for details and more options
      tag_options = 'json=omitempty', -- sets options sent to gomodifytags, i.e., json=omitempty
      gotests_template = "", -- sets gotests -template parameter (check gotests for details)
      gotests_template_dir = "", -- sets gotests -template_dir parameter (check gotests for details)
      comment_placeholder = '' ,  -- comment_placeholder your cool placeholder e.g. 󰟓       
      icons = {breakpoint = '🧘', currentpos = '🏃'},  -- setup to `false` to disable icons setup
      verbose = true,  -- output loginf in messages
      lsp_cfg = false, -- true: use non-default gopls setup specified in go/lsp.lua
                       -- false: do nothing
                       -- if lsp_cfg is a table, merge table with with non-default gopls setup in go/lsp.lua, e.g.
                       --   lsp_cfg = {settings={gopls={matcher='CaseInsensitive', ['local'] = 'your_local_module_path', gofumpt = true }}}
      lsp_gofumpt = false, -- true: set default gofmt in gopls format to gofumpt
      lsp_on_attach = nil, -- nil: use on_attach function defined in go/lsp.lua,
                           --      when lsp_cfg is true
                           -- if lsp_on_attach is a function: use this function as on_attach function for gopls
      lsp_keymaps = true, -- set to false to disable gopls/lsp keymap
      lsp_codelens = true, -- set to false to disable codelens, true by default, you can use a function
      -- function(bufnr)
      --    vim.api.nvim_buf_set_keymap(bufnr, "n", "<space>F", "<cmd>lua vim.lsp.buf.formatting()<CR>", {noremap=true, silent=true})
      -- end
      -- to setup a table of codelens
      diagnostic = {  -- set diagnostic to false to disable vim.diagnostic setup
        hdlr = false, -- hook lsp diag handler and send diag to quickfix
        underline = true,
        -- virtual text setup
        virtual_text = { spacing = 0, prefix = '■' },
        signs = true,
        update_in_insert = false,
      },
      lsp_document_formatting = true,
      -- set to true: use gopls to format
      -- false if you want to use other formatter tool(e.g. efm, nulls)
      lsp_inlay_hints = {
        enable = true,
        -- hint style, set to 'eol' for end-of-line hints, 'inlay' for inline hints
        -- inlay only avalible for 0.10.x
        style = 'eol',
        -- Note: following setup only works for style = 'eol', you do not need to set it for 'inlay'
        -- Only show inlay hints for the current line
        only_current_line = true,
        -- Event which triggers a refersh of the inlay hints.
        -- You can make this "CursorMoved" or "CursorMoved,CursorMovedI" but
        -- not that this may cause higher CPU usage.
        -- This option is only respected when only_current_line and
        -- autoSetHints both are true.
        only_current_line_autocmd = "CursorHold",
        -- whether to show variable name before type hints with the inlay hints or not
        -- default: false
        show_variable_name = true,
        -- prefix for parameter hints
        parameter_hints_prefix = "󰊕 ",
        show_parameter_hints = true,
        -- prefix for all the other hints (type, chaining)
        other_hints_prefix = "=> ",
        -- whether to align to the lenght of the longest line in the file
        max_len_align = false,
        -- padding from the left if max_len_align is true
        max_len_align_padding = 1,
        -- whether to align to the extreme right or not
        right_align = false,
        -- padding from the right if right_align is true
        right_align_padding = 6,
        -- The color of the hints
        highlight = "Comment",
      },
      gopls_cmd = nil, -- if you need to specify gopls path and cmd, e.g {"/home/user/lsp/gopls", "-logfile","/var/log/gopls.log" }
      gopls_remote_auto = true, -- add -remote=auto to gopls
      gocoverage_sign = "█",
      sign_priority = 5, -- change to a higher number to override other signs
      dap_debug = true, -- set to false to disable dap
      dap_debug_keymap = true, -- true: use keymap for debugger defined in go/dap.lua
                               -- false: do not use keymap in go/dap.lua.  you must define your own.
                               -- Windows: Use Visual Studio keymap
      dap_debug_gui = {}, -- bool|table put your dap-ui setup here set to false to disable
      dap_debug_vt = { enabled_commands = true, all_frames = true }, -- bool|table put your dap-virtual-text setup here set to false to disable

      dap_port = 38697, -- can be set to a number, if set to -1 go.nvim will pick up a random port
      dap_timeout = 15, --  see dap option initialize_timeout_sec = 15,
      dap_retries = 20, -- see dap option max_retries
      build_tags = "tag1,tag2", -- set default build tags
      textobjects = true, -- enable default text objects through treesittter-text-objects
      test_runner = 'go', -- one of {`go`, `richgo`, `dlv`, `ginkgo`, `gotestsum`}
      verbose_tests = true, -- set to add verbose flag to tests deprecated, see '-v' option
      run_in_floaterm = false, -- set to true to run in a float window. :GoTermClose closes the floatterm
                               -- float term recommend if you use richgo/ginkgo with terminal color

      floaterm = {   -- position
        posititon = 'auto', -- one of {`top`, `bottom`, `left`, `right`, `center`, `auto`}
        width = 0.45, -- width of float window if not auto
        height = 0.98, -- height of float window if not auto
        title_colors = 'nord', -- default to nord, one of {'nord', 'tokyo', 'dracula', 'rainbow', 'solarized ', 'monokai'}
                                  -- can also set to a list of colors to define colors to choose from
                                  -- e.g {'#D8DEE9', '#5E81AC', '#88C0D0', '#EBCB8B', '#A3BE8C', '#B48EAD'}
      },
      trouble = true, -- true: use trouble to open quickfix
      test_efm = false, -- errorfomat for quickfix, default mix mode, set to true will be efm only
      luasnip = false, -- enable included luasnip snippets. you can also disable while add lua/snips folder to luasnip load
      --  Do not enable this if you already added the path, that will duplicate the entries
      on_jobstart = function(cmd) _=cmd end, -- callback for stdout
      on_stdout = function(err, data) _, _ = err, data end, -- callback when job started
      on_stderr = function(err, data)  _, _ = err, data  end, -- callback for stderr
      on_exit = function(code, signal, output)  _, _, _ = code, signal, output  end, -- callback for jobexit, output : string
      iferr_vertical_shift = 4 -- defines where the cursor will end up vertically from the begining of if err statement
    },
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
    "mrcjkb/rustaceanvim",
    version = "^3", -- Recommended
    ft = { "rust" },
    opts = {
      server = {
        on_attach = function(_, bufnr)
          -- register which-key mappings
          local wk = require("which-key")
          wk.register({
            ["<leader>cR"] = { function() vim.cmd.RustLsp("codeAction") end, "Code Action" },
            ["<leader>dr"] = { function() vim.cmd.RustLsp("debuggables") end, "Rust debuggables" },
          }, { mode = "n", buffer = bufnr })
        end,
        settings = {
          -- rust-analyzer language server configuration
          ["rust-analyzer"] = {
            cargo = {
              allFeatures = true,
              loadOutDirsFromCheck = true,
              runBuildScripts = true,
            },
            -- Add clippy lints for Rust.
            checkOnSave = {
              allFeatures = true,
              command = "clippy",
              extraArgs = { "--no-deps" },
            },
            procMacro = {
              enable = true,
              ignored = {
                ["async-trait"] = { "async_trait" },
                ["napi-derive"] = { "napi" },
                ["async-recursion"] = { "async_recursion" },
              },
            },
          },
        },
      }
    },
    config = function(_, opts)
      vim.g.rustaceanvim = opts
    end
  },
  {
    'saecki/crates.nvim',
    ft = {"rust","toml"},
    event = { "BufRead Cargo.toml" },
    dependencies = { 'nvim-lua/plenary.nvim' },
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
    "nvim-tree/nvim-web-devicons",
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
  },
  {
    "chrishrb/gx.nvim",
    event = { "BufEnter" },
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = function ()
      return require "custom.configs.gx"
    end,
    config = function(_, opts)
      require("gx").setup(opts)
    end
  },
  {
    "chentoast/marks.nvim",
    event = "VeryLazy",
    opts = function ()
      return require "custom.configs.marks"
    end,
    config = function(_, opts)
      require("marks").setup(opts)
    end
  },
  {
    'stevearc/conform.nvim',
    ft = { "go", "rust", "terraform", "lua", "markdown" },
    opts = function ()
      return require "custom.configs.conform"
    end,
    config = function(_, opts)
      require("conform").setup(opts)
    end
  },
  {
    'nvim-treesitter/nvim-treesitter-context',
    event = "VeryLazy",
    opts = function ()
      return require "custom.configs.treesitter-context"
    end,
    config = function(_, opts)
      require("treesitter-context").setup(opts)
    end
  }
}


return plugins
