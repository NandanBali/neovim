return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "main",
    dependencies = {
      { "github/copilot.vim" },
    },
    config = function()
      require("CopilotChat").setup({
        show_help = true,
      })
    end,
  },
}

