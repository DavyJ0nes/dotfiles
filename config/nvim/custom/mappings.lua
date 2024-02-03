local M = {}

M.disabled = {
  n = {
      ["<leader>rn"] = "",
      ["<leader>n"] = "",
      ["<C-a>"] = "",
      ["Z"] = "",
      ["ZZ"] = "",
      ["qq"] = "",
  }
}

M.general = {
  n = {
    -- tmux navigation in vim
    ["<C-h>"] = { "<cmd> TmuxNavigateLeft<CR>", "window left" },
    ["<C-l>"] = { "<cmd> TmuxNavigateRight<CR>", "window right" },
    ["<C-j>"] = { "<cmd> TmuxNavigateDown<CR>", "window down" },
    ["<C-k>"] = { "<cmd> TmuxNavigateUp<CR>", "window up" },
    -- diable arrows
    ["<Up>"] = { "<Nop>", "" },
    ["<Down>"] = { "<Nop>", "" },
    ["<Left>"] = { "<Nop>", "" },
    ["<Right>"] = { "<Nop>", "" },
    ["<leader>gfs"] = { "<cmd> GoFillStruct<CR>", "fill go struct" },
    -- ["<leader>ca"] = { "<cmd> GoCodeLenAct<CR>", "code lens actions" },
    ["gb"] = { "<C-o>", "go back" },
    ["ZQ"] = { "<cmd> q<CR>", "quit" },
    ["<leader>q"] = { "<cmd> q<CR>", "quit" },
    ["ZZ"] = { "<cmd> w<CR>", "save" },
    ["<leader>p"] = { "\"_dP", "paste without losing paste register" },
    -- TODO: does not work, needs fixing.
    -- ["<leader>fr"] = { "<cmd> %s/<C-r><C-w>/<CR>", "replace all occurences of selection in file"},
    ["<leader>son"] = { "<cmd> set spell spelllang=en_gb<CR>", "spellcheck on" },
    ["<leader>soff"] = { "<cmd> set nospell<CR>", "spellcheck on" },
    ["<leader>stp"] = {
      function()
        require('textcase').current_word('to_pascal_case')
      end,
      "switch text case to pascal",
    },
    ["<leader>sts"] = {
      function()
        require('textcase').current_word('to_snake_case')
      end,
      "switch text case to snake",
    },
    ["<leader>stc"] = {
      function()
        require('textcase').current_word('to_camel_case')
      end,
      "switch text case to camel",
    },
    ["<leader>grr"] = {
      function()
        vim.lsp.buf.references()
      end,
      "󰑊 LSP references",
    },
    ["<leader>gca"] = {
      function()
        vim.lsp.buf.code_action()
      end,
      "󰑊 LSP code_action",
    },
    ["<leader>grn"] = {
      function()
        vim.lsp.buf.rename()
      end,
      "󰑊 LSP rename",
    },
    ["<leader>gws"] = {
      function()
        vim.lsp.buf.workspace_symbol()
      end,
      "󰑊 LSP workspace_symbol",
    },
    ["<leader>gh"] = {
      function()
        vim.lsp.buf.hover()
      end,
      "󰑊 Hover definition",
    },
  },

  i = {
    ["<C-h>"] = {
      function()
        vim.lsp.buf.signature_help()
      end,
      "󰑊 Signature help",
    },
  },
}

M.dap = {
  plugin = true,
  n = {
    ["<leader>db"] = {
      "<cmd> DapToggleBreakpoint <CR>",
      "Add breakpoint at line",
    },
    ["<leader>do"] = {
      "<cmd> DapStepOver <CR>",
      "Dap Step Over",
    },
    ["<leader>dc"] = {
      "<cmd> DapContinue <CR>",
      "Dap Continue",
    },
    ["<leader>dr"] = {
      "<cmd> DapRerun <CR>",
      "Dap Rerun",
    },
    ["<leader>dq"] = {
      "<cmd> DapTerminate <CR>",
      "Dap Terminate",
    },
    ["<leader>dus"] = {
      function ()
        local widgets = require('dap.ui.widgets');
        local sidebar = widgets.sidebar(widgets.scopes);
        sidebar.open();
      end,
      "Open debugging sidebar",
    },
    ["<leader>dso"] = {
      function ()
        local widgets = require('dap.ui.widgets');
        local sidebar = widgets.sidebar(widgets.scopes);
        sidebar.open();
      end,
      "Open debugging sidebar",
    }
  },
}

M.dap_go = {
  plugin = true,
  n = {
    ["<leader>dt"] = {
      function()
        require('dap-go').debug_test()
      end,
      "Debug go test"
    },
    ["<leader>dtl"] = {
      function()
        require('dap-go').debug_last_test()
      end,
      "Debug last go test"
    },
  }
}

M.development = {
}

M.test = {
  -- plugin = true,
  n = {
    ["<leader>tt"] = {
      function()
        require("neotest").run.run()
      end,
      "Run neotest",
    },
    ["<leader>tf"] = {
      function()
        require("neotest").run.run(vim.fn.expand "%")
      end,
      "Run neotest on whole file",
    },
    ["<leader>tl"] = {
      function()
        require("neotest").run.run_last()
      end,
      "Run last test",
    },
    ["<leader>ts"] = {
      function()
        require("neotest").summary.toggle()
      end,
      "Toggle Test Summary",
    },
    ["<leader>to"] = {
      function()
        require("neotest").output.open({ enter = true })
      end,
      "Toggle Test Output panel",
    },
    ["<leader>tw"] = {
      function()
        require("neotest").watch.toggle()
      end,
      "Toggle test watch",
    },
  },
}

M.crates = {
  plugin = true,
  n = {
    ["<leader>rcu"] = {
      function ()
        require('crates').upgrade_all_crates()
      end,
      "update crates"
    },
    ["<leader>rcv"] = {
      function ()
        require('crates').show_versions_popup()
      end,
      "show crate versions"
    },
    ["<leader>rcD"] = {
      function ()
        require('crates').open_documentation()
      end,
      "show crate documentation"
    },
    ["<leader>rcf"] = {
      function ()
        require('crates').show_features_popup()
      end,
      "show crate features"
    },
    ["<leader>rcd"] = {
      function ()
        require('crates').show_dependencies_popup()
      end,
      "show crate dependencies"
    },

    ["<leader>rr"] = { "<cmd> Cargo run<CR>", "window up" },
  }
}

M.development = {
  plugin = true,
  n = {
    ["<C-space>"] = {
      function ()
        require('rust-tools').hover_actions.hover_actions()
      end,
      "Show rust hover actions"
    },
  }
}

M.nvterm = {
  plugin = true,

  t = {
    -- toggle in terminal mode
    ["<C-q>"] = {
      function()
        require("nvterm.terminal").toggle "float"
      end,
      "Toggle floating term",
    },
  },

  n = {
    -- toggle in normal mode
    ["<leader>ft"] = {
      function()
        require("nvterm.terminal").toggle "float"
      end,
      "Toggle floating term",
    },
  },
}

M.telescope = {
  plugin = true,

  n = {
    -- find
    ["<leader>ff"] = {
      function()
        require("custom.utils").find_files_from_project_git_root()
      end,
      "Find files",
    },
    ["<leader>fa"] = { "<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>", "Find all" },
    ["<leader>fb"] = { "<cmd> Telescope buffers <CR>", "Find buffers" },
    ["<leader>fh"] = { "<cmd> Telescope help_tags <CR>", "Help page" },
    ["<leader>fo"] = { "<cmd> Telescope oldfiles <CR>", "Find oldfiles" },
    ["<leader>fz"] = { "<cmd> Telescope current_buffer_fuzzy_find <CR>", "Find in current buffer" },

    -- git
    ["<leader>cm"] = { "<cmd> Telescope git_commits <CR>", "Git commits" },
    ["<leader>gt"] = { "<cmd> Telescope git_status <CR>", "Git status" },

    -- pick a hidden term
    ["<leader>pt"] = { "<cmd> Telescope terms <CR>", "Pick hidden term" },

    -- theme switcher
    ["<leader>th"] = { "<cmd> Telescope themes <CR>", "Nvchad themes" },

    ["<leader>ma"] = { "<cmd> Telescope marks <CR>", "telescope bookmarks" },
  },
}

return M
