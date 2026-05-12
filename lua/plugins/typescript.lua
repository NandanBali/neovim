-- TypeScript / JavaScript tooling.
-- LSP is owned by typescript-tools.nvim (NOT nvim-lspconfig). Do not enable ts_ls in lsp.lua.
-- ESLint LSP and prettierd formatter are wired up in lsp.lua.
return {
  -- which-key group for <leader>T (TypeScript-specific actions, ft-scoped)
  {
    "folke/which-key.nvim",
    optional = true,
    opts = {
      spec = {
        { "<leader>T", group = "TypeScript", icon = " ",
          ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" } },
      },
    },
  },

  -- Ensure non-LSP CLIs (tsserver binary + prettierd) are installed via Mason.
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      ensure_installed = {
        "typescript-language-server",
        "prettierd",
      },
      auto_update  = false,
      run_on_start = true,
    },
  },

  -- Lua-native TS/JS LSP client (wraps tsserver directly).
  {
    "pmizio/typescript-tools.nvim",
    ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    opts = {
      on_attach = function(_, bufnr)
        local map = function(lhs, rhs, desc)
          vim.keymap.set("n", lhs, rhs, { buffer = bufnr, desc = desc })
        end
        map("<leader>To", "<cmd>TSToolsOrganizeImports<CR>",    "Organize imports")
        map("<leader>Ti", "<cmd>TSToolsAddMissingImports<CR>",  "Add missing imports")
        map("<leader>Tu", "<cmd>TSToolsRemoveUnused<CR>",       "Remove unused")
        map("<leader>Tr", "<cmd>TSToolsRenameFile<CR>",         "Rename file")
        map("<leader>Tf", "<cmd>TSToolsFixAll<CR>",             "Fix all")
      end,
      settings = {
        tsserver_file_preferences = {
          includeInlayParameterNameHints              = "all",
          includeInlayFunctionParameterTypeHints      = true,
          includeInlayVariableTypeHints               = true,
          includeInlayPropertyDeclarationTypeHints    = true,
          includeInlayFunctionLikeReturnTypeHints     = true,
          includeInlayEnumMemberValueHints            = true,
        },
        expose_as_code_action = "all",
      },
    },
  },
}
