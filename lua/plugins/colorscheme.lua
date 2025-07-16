return {
  {
    "tanvirtin/monokai.nvim",
    priority = 1000,
    config = function()
      require('monokai').setup({
        palette = require('monokai').classic
      })
      vim.cmd.colorscheme("monokai")
    end,
  },
}
