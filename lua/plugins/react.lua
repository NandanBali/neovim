return {
  -- Automatically close JSX tags
  {
    "windwp/nvim-ts-autotag",
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },

  -- Snippets for React
  {
    "rafamadriz/friendly-snippets",
  },
}
