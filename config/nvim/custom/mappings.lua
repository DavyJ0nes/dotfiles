local M = {}

M.disabled = {
  n = {
      ["<leader>rn"] = "",
      ["<leader>n"] = "",
      ["<C-a>"] = ""
  }
}

M.general = {
  n = {
    ["<C-h>"] = { "<cmd> TmuxNavigateLeft<CR>", "window left" },
    ["<C-l>"] = { "<cmd> TmuxNavigateRight<CR>", "window right" },
    ["<C-j>"] = { "<cmd> TmuxNavigateDown<CR>", "window down" },
    ["<C-k>"] = { "<cmd> TmuxNavigateUp<CR>", "window up" },
    ["<leader>q"] = { "<cmd> :enew<bar>bw #<CR>", "close buffer" },
  }
}

M.dap = {
  plugin = true,
  n = {
    ["<leader>db"] = {
      "<cmd> DapToggleBreakpoint <CR>",
      "Add breakpoint at line",
    },
    ["<leader>dus"] = {
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
        require('dap-go').debug_last()
      end,
      "Debug last go test"
    },
  }
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
    }
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
    ["<leader>rcr"] = {
      function()
        require("nvterm.terminal").toggle "float"
        require("nvterm.terminal").send("cargo run", "float")
      end,
      "Run cargo run in a floating window",
    },
  },
}

return M
