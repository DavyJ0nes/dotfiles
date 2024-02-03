vim.g.dap_virtual_text = true
vim.opt.colorcolumn = "80,120"
vim.wo.relativenumber = true
vim.opt.termguicolors = true
vim.opt.mouse = ""
vim.cmd('nnoremap Z <Nop>')
vim.cmd('nnoremap ZZ <Nop>')

vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'Enable inlay hints',
  callback = function(event)
    local id = vim.tbl_get(event, 'data', 'client_id')
    local client = id and vim.lsp.get_client_by_id(id)
    if client == nil or not client.supports_method('textDocument/inlayHint') then
      return
    end

    -- warning: this api is not stable yet
    vim.lsp.inlay_hint.enable(event.buf, true)
  end,
})
