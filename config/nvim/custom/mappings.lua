local M = {}

M.disabled = {
  n = {
      ["<leader>rn"] = "",
      ["<leader>n"] = "",
      ["<C-a>"] = "",
  }
}

M.general = {
  n = {
    ["<C-h>"] = { "<cmd> TmuxNavigateLeft<CR>", "window left" },
    ["<C-l>"] = { "<cmd> TmuxNavigateRight<CR>", "window right" },
    ["<C-j>"] = { "<cmd> TmuxNavigateDown<CR>", "window down" },
    ["<C-k>"] = { "<cmd> TmuxNavigateUp<CR>", "window up" },
    ["<leader>gfs"] = { "<cmd> GoFillStruct<CR>", "fill go struct" },
    ["gb"] = { "<C-o>", "go back" },
    ["ZP"] = { "<cmd> w<CR>", "save" },
    -- TODO: does not work, needs fixing.
    -- ["<leader>fr"] = { "<cmd> %s/<C-r><C-w>/<CR>", "replace all occurences of selection in file"},
    ["<leader>so"] = { "<cmd> set spell spelllang=en_gb<CR>", "spellcheck on" },
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
  }
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
    ["<leader>dgt"] = {
      function()
        require('dap-go').debug_test()
      end,
      "Debug go test"
    },
    ["<leader>dgl"] = {
      function()
        require('dap-go').debug_last_test()
      end,
      "Debug last go test"
    },
  }
}

M.development = {
  n = {
    ["gd"] = {
      function()
        vim.lsp.buf.definition()
      end,
      "󰑊 Go to definition",
    },
    ["gi"] = {
      function()
        vim.lsp.buf.implementation()
      end,
      "󰑊 Go to implementation",
    },
    ["gr"] = {
      function()
        vim.lsp.buf.references()
      end,
      "󰑊 Go to implementation",
    },
  },
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
    ["<leader>td"] = {
      function()
        require("neotest").run.run({ strategy = "dap" })
      end,
      "Debug test",
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
    ["<leader>tld"] = {
      function()
        require("neotest").run.run_last({ strategy = "dap" })
      end,
      "Debug last test",
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
    ["<leader>fg"] = {
      function()
        require("custom.utils").live_grep_from_project_git_root()
      end,
      "Live grep",
    },
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
