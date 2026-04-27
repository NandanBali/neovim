return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    keys = {
      -- Quick toggles
      { "<leader>tt", "<cmd>ToggleTerm direction=horizontal<CR>", desc = "Terminal (horizontal)" },
      { "<leader>tv", "<cmd>ToggleTerm direction=vertical<CR>",   desc = "Terminal (vertical)" },
      { "<leader>tf", "<cmd>ToggleTerm direction=float<CR>",      desc = "Terminal (float)" },
      { "<leader>ta", "<cmd>ToggleTermToggleAll<CR>",              desc = "Toggle all terminals" },
      -- Convenience: Ctrl+\ to toggle the float terminal from anywhere
      { "<C-\\>",     "<cmd>ToggleTerm direction=float<CR>",      desc = "Toggle float terminal",  mode = { "n", "t", "i" } },
    },
    opts = {
      size = function(term)
        if term.direction == "horizontal" then return 15
        elseif term.direction == "vertical" then return math.floor(vim.o.columns * 0.4)
        end
      end,
      open_mapping = nil,    -- we set our own mappings above
      direction = "float",
      float_opts = {
        border = "curved",
        winblend = 3,
      },
      highlights = {
        FloatBorder = { link = "FloatBorder" },
      },
      shade_terminals = true,
      shell = vim.o.shell,
      persist_mode = true,
      auto_scroll = true,
    },
    config = function(_, opts)
      require("toggleterm").setup(opts)

      -- In terminal mode: Esc or jk goes back to normal mode
      local function set_terminal_keymaps()
        local bufopts = { buffer = 0 }
        vim.keymap.set("t", "<Esc>",   [[<C-\><C-n>]], bufopts)
        vim.keymap.set("t", "jk",      [[<C-\><C-n>]], bufopts)
        vim.keymap.set("t", "<C-h>",   [[<C-\><C-n><C-w>h]], bufopts)
        vim.keymap.set("t", "<C-j>",   [[<C-\><C-n><C-w>j]], bufopts)
        vim.keymap.set("t", "<C-k>",   [[<C-\><C-n><C-w>k]], bufopts)
        vim.keymap.set("t", "<C-l>",   [[<C-\><C-n><C-w>l]], bufopts)
      end

      vim.api.nvim_create_autocmd("TermOpen", {
        pattern = "term://*",
        callback = set_terminal_keymaps,
      })
    end,
  },
}
