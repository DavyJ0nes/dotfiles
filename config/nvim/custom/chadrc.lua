---@type ChadrcConfig
local M = {}

M.ui = {
  theme = 'chadracula',
  transparency = false,

  statusline = {
    theme = "minimal", -- default/vscode/vscode_colored/minimal
    separator_style = "round",
    overriden_modules = nil,
  },
  cmp = {
    icons = true,
    lspkind_text = true,
    style = "flat_dark", -- default/flat_light/flat_dark/atom/atom_colored
    border_color = "grey_fg", -- only applicable for "default" style, use color names from base30 variables
    selected_item_bg = "colored", -- colored / simple
  },

  nvdash = {
    load_on_startup = true,
    header = {
      "    (╯°□°)╯︵ ┻━┻             ",
      "              ┻━┻ ︵ ヽ(°□°ヽ)",
      "  ┻━┻ ︵ ＼\\('0')/／ ︵ ┻━┻  ",
    },
    buttons = {
      { "󰈔  Find File", "Spc f f", "Telescope find_files" },
      { "󰈚  Recent Files", "Spc f o", "Telescope oldfiles" },
      { "󰈭  Live Grep", "Spc f g", "Telescope live_grep" },
      { "  Bookmarks", "Spc m a", "Telescope marks" },
      { "", "", "" },
      { "󱠇", "Turn it up to max!!", "    " },
    },
  },
  cheatsheet = { theme = "simple" }, -- simple/grid
}
M.plugins = "custom.plugins"
M.mappings = require "custom.mappings"

return M
