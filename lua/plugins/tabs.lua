return {
  "akinsho/bufferline.nvim",
  version = "*",
  event = "VeryLazy",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    options = {
      mode = "buffers",
      diagnostics = "nvim_lsp",
      separator_style = "slant",
      always_show_bufferline = true,
      show_buffer_close_icons = false,
      show_close_icon = false,
    },
  },
  keys = {
    { "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Previous buffer" },
    { "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" },
    { "<leader>bp", "<cmd>BufferLinePick<cr>", desc = "Pick buffer" },
    { "<leader>bc", "<cmd>bdelete<cr>", desc = "Close buffer" },
    { "<leader>bo", "<cmd>%bd|e#|bd#<cr>", desc = "Close other buffers" },
    { "<leader>bn", "<cmd>enew<cr>", desc = "New buffer" },
  },
}
