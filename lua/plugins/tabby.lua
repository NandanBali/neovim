return {
  {
    "nanozuki/tabby.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },  -- optional, for icons
    opts = {},  -- you can customize options or leave default
    config = function(_, opts)
      require("tabby").setup(opts)

      -- Optional: show tabline always
      vim.o.showtabline = 2
    end,
  },
}

