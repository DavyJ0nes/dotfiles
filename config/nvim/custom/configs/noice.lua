local present, noice = pcall(require, "noice")

if not present then
  return
end

noice.setup {
  notify = {
    enabled = true,
    view = "notify",
  },
  lsp = {
  -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
      ["cmp.entry.get_documentation"] = true,
    },
    hover = {
      enabled = false,
    },
    signature = {
      enabled = false,
    },
  },
  -- you can enable a preset for easier configuration
  presets = {
    bottom_search = true, -- use a classic bottom cmdline for search
    command_palette = true, -- position the cmdline and popupmenu together
    long_message_to_split = true, -- long messages will be sent to a split
    inc_rename = false, -- enables an input dialog for inc-rename.nvim
    lsp_doc_border = false, -- add a border to hover docs and signature help
  },
  routes = {
    {
      view = "notify",
      filter = {
        event = "msg_showmode"
      },
    },
    {
      filter = {
        event = "msg_show",
        kind = "",
        any = {

          -- Edit
          { find = "%d+ less lines" },
          { find = "%d+ fewer lines" },
          { find = "%d+ more lines" },
          { find = "%d+ change;" },
          { find = "%d+ line less;" },
          { find = "%d+ more lines?;" },
          { find = "%d+ fewer lines;?" },
          { find = '".+" %d+L, %d+B' },
          { find = "%d+ lines yanked" },
          { find = "^Hunk %d+ of %d+$" },
          { find = "%d+L, %d+B$" },

          -- Save
          { find = " bytes written" },

          -- Redo/Undo
          { find = " changes; before #" },
          { find = " changes; after #" },
          { find = "1 change; before #" },
          { find = "1 change; after #" },

          -- Yank
          { find = " lines yanked" },

          -- Move lines
          { find = " lines moved" },
          { find = " lines indented" },

          -- Bulk edit
          { find = " fewer lines" },
          { find = " more lines" },
          { find = "1 more line" },
          { find = "1 line less" },

          -- General messages
          { find = "Already at newest change" },
          { find = "Already at oldest change" },
          { find = "E21: Cannot make changes, 'modifiable' is off" },
        },
      },
      opts = { skip = true },
    },
  },
}