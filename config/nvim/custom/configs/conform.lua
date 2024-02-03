local opts = {
  formatters = {
    mdformat = {
      prepend_args = { "--number", "--wrap", "80" },

    },
  },
  formatters_by_ft = {
    lua = { "stylua" },
    terraform = { "terraform_fmt" },
    -- markdown = { "mdformat" },
    go = { "gofmt", "golines", "goimports", "gci" },
    rust = { "rustfmt" },
  },
  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 500,
    lsp_fallback = true,
  },
}

return opts


