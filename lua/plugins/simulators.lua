
return {
  "dimaportenko/telescope-simulators.nvim",
  dependencies = {
    "nvim-telescope/telescope.nvim",
  },
  config = function()
    require("telescope").load_extension("simulators")
  end,
}
