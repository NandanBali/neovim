return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end,
  config = function()
    local wk = require("which-key")
    
    wk.setup({
      plugins = {
        marks = true,
        registers = true,
        spelling = {
          enabled = true,
          suggestions = 20,
        },
      },
      window = {
        border = "rounded",
        position = "bottom",
        margin = { 1, 0, 1, 0 },
        padding = { 2, 2, 2, 2 },
      },
      layout = {
        height = { min = 4, max = 25 },
        width = { min = 20, max = 50 },
        spacing = 3,
        align = "left",
      },
    })

    -- Register key mappings with descriptions
    wk.register({
      ["<leader>"] = {
        f = {
          name = "Find (Telescope)",
          f = { "<cmd>Telescope find_files<cr>", "Find files" },
          g = { "<cmd>Telescope live_grep<cr>", "Live grep" },
          b = { "<cmd>Telescope buffers<cr>", "Find buffers" },
          h = { "<cmd>Telescope help_tags<cr>", "Help tags" },
          r = { "<cmd>Telescope oldfiles<cr>", "Recent files" },
        },
        w = { "<cmd>w<CR>", "Save file" },
        q = { "<cmd>q<CR>", "Quit" },
        s = {
          name = "Split",
          v = { "<C-w>v", "Split vertically" },
          h = { "<C-w>s", "Split horizontally" },
          e = { "<C-w>=", "Equal splits" },
          x = { "<cmd>close<CR>", "Close split" },
        },
        b = {
          name = "Buffer",
          n = { "<cmd>bnext<CR>", "Next buffer" },
          p = { "<cmd>bprevious<CR>", "Previous buffer" },
          d = { "<cmd>bdelete<CR>", "Delete buffer" },
        },
        t = {
          name = "Tab",
          n = { "<cmd>tabnew<CR>", "New tab" },
          c = { "<cmd>tabclose<CR>", "Close tab" },
          ["]"] = { "<cmd>tabnext<CR>", "Next tab" },
          ["["] = { "<cmd>tabprev<CR>", "Previous tab" },
        },
        n = {
          h = { ":nohl<CR>", "Clear highlights" },
        },
      },
    })

    -- Function to show all keybinds
    local function show_all_keybinds()
      wk.show({ mode = "n", auto = true })
    end

    -- Bind F1 to show all keybinds
    vim.keymap.set("n", "<F1>", show_all_keybinds, { desc = "Show all keybinds" })
  end,
}
