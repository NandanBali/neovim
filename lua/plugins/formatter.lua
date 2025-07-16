return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  config = function()
    require("conform").setup({
      formatters_by_ft = {
        javascript = { "prettier" },
        typescript = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
        json = { "prettier" },
        css = { "prettier" },
        html = { "prettier" },
        lua = { "stylua" },
      },
      -- Set up format on save
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
      },
    })

    -- Add a keymap to format manually
    vim.keymap.set({ "n", "v" }, "<leader>fm", function()
      require("conform").format({
        lsp_fallback = true,
        async = false,
        timeout_ms = 500,
      })
    end, { desc = "Format file or range" })
  end,
}
