return {
  "akinsho/toggleterm.nvim",
  version = "*",
  keys = {
    { [[<C-\>]], desc = "Toggle terminal" },
    { "<leader>tt", desc = "Toggle terminal" },
    { "<leader>tf", desc = "Float terminal" },
    { "<leader>th", desc = "Horizontal terminal" },
    { "<leader>tv", desc = "Vertical terminal" },
  },
  config = function()
    require("toggleterm").setup {
      size = function(term)
        if term.direction == "horizontal" then
          return 15
        elseif term.direction == "vertical" then
          return math.floor(vim.o.columns * 0.4)
        end
        return 20
      end,
      open_mapping = [[<C-\>]],
      shade_terminals = true,
      start_in_insert = true,
      insert_mappings = true,
      terminal_mappings = true,
      direction = "horizontal",
      close_on_exit = true,
      shell = vim.o.shell,
      float_opts = {
        border = "curved",
        winblend = 3,
      },
    }

    local Terminal = require("toggleterm.terminal").Terminal
    local float_term = Terminal:new { direction = "float" }
    local h_term = Terminal:new { direction = "horizontal" }
    local v_term = Terminal:new { direction = "vertical" }

    vim.keymap.set("n", "<leader>tf", function() float_term:toggle() end, { desc = "Float terminal" })
    vim.keymap.set("n", "<leader>th", function() h_term:toggle() end, { desc = "Horizontal terminal" })
    vim.keymap.set("n", "<leader>tv", function() v_term:toggle() end, { desc = "Vertical terminal" })

    -- Navigate out of terminal with Ctrl+hjkl
    function _G.set_terminal_keymaps()
      local opts = { buffer = 0 }
      vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
      vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
      vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
      vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
      vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], opts)
    end

    vim.api.nvim_create_autocmd("TermOpen", {
      pattern = "term://*toggleterm#*",
      callback = function() set_terminal_keymaps() end,
    })
  end,
}
