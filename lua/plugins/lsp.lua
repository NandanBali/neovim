-- LSP: Mason + mason-lspconfig + lspconfig + clangd_extensions
-- Servers: clangd (C/C++), neocmake (CMake)
-- Makefiles get syntax via treesitter (no stable LSP available)

local function on_attach(_, bufnr)
  local map = vim.keymap.set
  local b = { buffer = bufnr }
  map("n", "gd", vim.lsp.buf.definition, vim.tbl_extend("force", b, { desc = "Go to definition" }))
  map("n", "gD", vim.lsp.buf.declaration, vim.tbl_extend("force", b, { desc = "Go to declaration" }))
  map("n", "gr", vim.lsp.buf.references, vim.tbl_extend("force", b, { desc = "References" }))
  map("n", "gi", vim.lsp.buf.implementation, vim.tbl_extend("force", b, { desc = "Go to implementation" }))
  map("n", "gt", vim.lsp.buf.type_definition, vim.tbl_extend("force", b, { desc = "Go to type definition" }))
  map("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", b, { desc = "Hover documentation" }))
  map("n", "<C-k>", vim.lsp.buf.signature_help, vim.tbl_extend("force", b, { desc = "Signature help" }))
  map("n", "<leader>rn", vim.lsp.buf.rename, vim.tbl_extend("force", b, { desc = "Rename symbol" }))
  map("n", "<leader>ca", vim.lsp.buf.code_action, vim.tbl_extend("force", b, { desc = "Code action" }))
  map("n", "<leader>lf", function() vim.lsp.buf.format { async = true } end, vim.tbl_extend("force", b, { desc = "Format buffer" }))
  map("n", "[d", vim.diagnostic.goto_prev, vim.tbl_extend("force", b, { desc = "Previous diagnostic" }))
  map("n", "]d", vim.diagnostic.goto_next, vim.tbl_extend("force", b, { desc = "Next diagnostic" }))
  map("n", "<leader>ld", vim.diagnostic.open_float, vim.tbl_extend("force", b, { desc = "Line diagnostics" }))
end

return {
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    opts = {},
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      ensure_installed = { "clangd", "neocmake" },
      automatic_installation = true,
    },
  },
  {
    "p00f/clangd_extensions.nvim",
    ft = { "c", "cpp" },
    dependencies = {
      "neovim/nvim-lspconfig",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      vim.lsp.config("clangd", {
        capabilities = capabilities,
        on_attach = on_attach,
        cmd = {
          "clangd",
          "--background-index",
          "--clang-tidy",
          "--header-insertion=iwyu",
          "--completion-style=detailed",
          "--function-arg-placeholders",
          "--fallback-style=llvm",
          -- Required so clangd can locate GCC/Clang system headers (iostream etc.)
          "--query-driver=/usr/bin/g++*,/usr/bin/clang++*,/usr/local/bin/g++*,/usr/local/bin/clang++*",
        },
      })
      vim.lsp.enable("clangd")

      require("clangd_extensions").setup {
        memory_usage = { border = "rounded" },
        symbol_info = { border = "rounded" },
      }
    end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Use the nvim 0.11+ vim.lsp.config API (lspconfig v3 compatible)
      vim.lsp.config("neocmake", {
        capabilities = capabilities,
        on_attach = on_attach,
      })
      vim.lsp.enable("neocmake")

      vim.diagnostic.config {
        virtual_text = { prefix = "●" },
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
        float = {
          border = "rounded",
          source = "always",
          header = "",
          prefix = "",
        },
      }

      -- Rounded borders for LSP windows
      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
      vim.lsp.handlers["textDocument/signatureHelp"] =
        vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })
    end,
  },
}
