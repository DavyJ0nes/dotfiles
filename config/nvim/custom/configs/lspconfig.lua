local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities
local lspconfig = require("lspconfig")
local util = require "lspconfig/util"

-- local gopls_cfg = require "go.lsp".config()
lspconfig.gopls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "go", "gomod", "gosum", "gotmpl", "gohtmltmpl", "gotexttmpl" },
  message_level = vim.lsp.protocol.MessageType.Error,
  cmd = {"gopls"},
  root_dir = util.root_pattern("go.work", "go.mod", ".git"),
  flags = { allow_incremental_sync = true, debounce_text_changes = 500 },
  settings = {
    gopls = {
      gofumpt = true,
      codelenses = {
        gc_details = false,
        generate = true,
        regenerate_cgo = true,
        run_govulncheck = true,
        test = true,
        tidy = true,
        upgrade_dependency = true,
        vendor = true,
      },
      hints = {
        assignVariableTypes = true,
        compositeLiteralFields = true,
        compositeLiteralTypes = true,
        constantValues = true,
        functionTypeParameters = true,
        parameterNames = true,
        rangeVariableTypes = true,
      },
      completeUnimported = true,
      usePlaceholders = true,
      analyses = {
        unusedparams = true,
        atomic = true,
      },
      matcher = 'Fuzzy',
    },
  },
})

lspconfig.terraformls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = {"terraform"},
  cmd = {"terraform-ls", "serve"},
  root_dir = util.root_pattern(".terraform", ".git"),
}

-- lspconfig.bufls.setup{}
