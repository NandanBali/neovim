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
            accept = "<C-Tab>",
            next = "<nop>",
            prev = "<nop>",
            dismiss = "<nop>",
          },
        },
        panel = { enabled = false },
      })
    end,
  },
}


