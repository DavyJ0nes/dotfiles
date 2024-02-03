local dap = require('dap')
local mason_registry = require("mason-registry")
local codelldb_root = mason_registry.get_package("codelldb"):get_install_path() .. "/extension/"
local codelldb_path = codelldb_root .. "adapter/codelldb"
local liblldb_path = codelldb_root .. "lldb/lib/liblldb.so"

dap.adapters.codelldb = {
  type = "server",
  port = "${port}",
  executable = {
    command = "/Users/davyjones/.vscode/extensions/vadimcn.vscode-lldb-1.10.0/adapter/codelldb",
    -- command = codelldb_path,
    args = { "--port", "${port}" },
    -- args = { "--liblldb", liblldb_path, "--port", "${port}" },
  },
}
