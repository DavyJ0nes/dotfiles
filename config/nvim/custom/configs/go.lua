local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

-- this doesn't work currently. Ignoring in plugins configuration.
local opts = {
  lsp_cfg = {
    capabilities = capabilities,
    -- other setups
  },
  fillstruct = 'fillstruct',
  max_line_len = 120,
  lsp_inlay_hints = {
    enable = true,
    style = 'inlay',
    only_current_line = true,
    show_variable_name = true,
    -- prefix for parameter hints
    parameter_hints_prefix = "󰊕 ",
    show_parameter_hints = true,
    -- prefix for all the other hints (type, chaining)
    other_hints_prefix = "=> ",
  },
  trouble = true,
  lsp_keymaps = false,
  diagnostic = {
    hdlr = true,
    underline = true,
    virtual_text = true,
    signs = true,
    update_in_insert = false,
  },
  icons = { breakpoint = "", currentpos = "" },
  gocoverage_sign = "│",
  -- lsp_diag_virtual_text = { space = 0, prefix = "" },
}

vim.api.nvim_set_hl(0, "goCoverageUncover", { fg = "#F1FA8C" })
vim.api.nvim_set_hl(0, "goCoverageUncovered", { fg = "#e8274b" })
vim.api.nvim_set_hl(0, "goCoverageCovered", { fg = "#50fa7b" })

return opts
