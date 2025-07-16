return {
  {
    "zbirenbaum/copilot.lua",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        suggestion = {
          enabled = true,
          auto_trigger = true,
          debounce = 75,
          keymap = {
            accept = "<C-l>",
            next = "<C-j>",
            prev = "<C-k>",
            dismiss = "<C-h>",
          },
        },
        panel = { enabled = false },
      })
    end,
  },
}

