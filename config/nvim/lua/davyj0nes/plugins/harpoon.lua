return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },

  config = function(_, opts)
    local harpoon = require("harpoon")
    local keymap = vim.keymap -- for conciseness
    harpoon:setup(opts)

    keymap.set("n", "<leader>a", function() harpoon:list():add() end, { desc = "Add file to harpoon" })
    keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Open harpoon list" })

    -- keymap.set("n", "<C-1>", function() harpoon:list():select(1) end, { desc = "Go to harpoon 1" })
    -- keymap.set("n", "<C-2>", function() harpoon:list():select(2) end, { desc = "Go to harpoon 2" })
    -- keymap.set("n", "<C-3>", function() harpoon:list():select(3) end, { desc = "Go to harpoon 3" })
    -- keymap.set("n", "<C-4>", function() harpoon:list():select(4) end, { desc = "Go to harpoon 4" })
    --
    -- Toggle previous & next buffers stored within Harpoon list
    -- keymap.set("n", "<C-S-E>", function() harpoon:list():prev() end, { desc = "Go to prev harpoon mark" })
    keymap.set("n", "<C-N>", function() harpoon:list():next() end, { desc = "Go to next harpoon mark" })
  end
}
