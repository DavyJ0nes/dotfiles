return {
  {
    "f-person/git-blame.nvim",
    event = "VeryLazy",
    config = function()
      vim.cmd(":GitBlameToggle") -- disable at startup
    end,
    keys = {
    -- toggle needs to be called twice; https://github.com/f-person/git-blame.nvim/issues/16
    { "<leader>gbl", ":GitBlameToggle<CR>", desc = "Blame line (toggle)", silent = true },
    { "<leader>gbs", ":GitBlameCopySHA<CR>", desc = "Copy SHA", silent = true },
    { "<leader>gbc", ":GitBlameCopyCommitURL<CR>", desc = "Copy commit URL", silent = true },
    { "<leader>gbf", ":GitBlameCopyFileURL<CR>", desc = "Copy file URL", silent = true },
    { "<leader>gbo", ":GitBlameOpenFileURL<CR>", desc = "Open file URL", silent = true },
  }
  },
}
