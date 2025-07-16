
return {
  "akinsho/toggleterm.nvim",
  version = "*",
  config = function()
    require("toggleterm").setup({
      shell = "pwsh",
      open_mapping = [[<c-t>]],
      direction = "float",
    })
  end,
}
