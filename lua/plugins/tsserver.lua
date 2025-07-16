return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("lspconfig").tsserver.setup({
        on_attach = function(client, bufnr)
          local augroup = vim.api.nvim_create_augroup("LspAutoImport", { clear = true })
          vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.code_action({ context = { only = { "source.organizeImports" } }, apply = true })
            end,
          })
        end,
      })
    end,
  },
}


