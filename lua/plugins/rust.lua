return {
  -- rustaceanvim: modern rust-analyzer + DAP wrapper.
  -- Configures itself — do NOT add rust_analyzer to nvim-lspconfig or mason-lspconfig.
  {
    "mrcjkb/rustaceanvim",
    version = "^6",
    lazy = false, -- plugin is already lazy via ftplugin
    ft = { "rust" },
    dependencies = { "mfussenegger/nvim-dap" },
    config = function()
      local mason_bin = vim.fn.stdpath("data") .. "/mason/bin"
      local codelldb  = mason_bin .. "/codelldb"
      local liblldb   = vim.fn.stdpath("data") .. "/mason/packages/codelldb/extension/lldb/lib/liblldb.so"

      vim.g.rustaceanvim = {
        tools = {
          float_win_config = { border = "rounded" },
        },
        server = {
          on_attach = function(_, bufnr)
            local map = function(mode, lhs, rhs, desc)
              vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
            end
            map("n", "gd",         vim.lsp.buf.definition,      "Go to definition")
            map("n", "gD",         vim.lsp.buf.declaration,     "Go to declaration")
            map("n", "gi",         vim.lsp.buf.implementation,  "Go to implementation")
            map("n", "gr",         vim.lsp.buf.references,      "References")
            map("n", "gy",         vim.lsp.buf.type_definition, "Type definition")
            map("n", "<leader>lf", function() vim.lsp.buf.format({ async = true }) end, "Format")
            map("n", "<leader>la", function() vim.cmd.RustLsp("codeAction") end, "Code action")
            map("n", "<leader>ln", vim.lsp.buf.rename,          "Rename")
            map("n", "<leader>lh", vim.lsp.buf.signature_help,  "Signature help")
            map("n", "<leader>rr", function() vim.cmd.RustLsp("runnables") end,    "Rust runnables")
            map("n", "<leader>rd", function() vim.cmd.RustLsp("debuggables") end,  "Rust debuggables")
            map("n", "<leader>rm", function() vim.cmd.RustLsp("expandMacro") end,  "Expand macro")
            map("n", "<leader>rp", function() vim.cmd.RustLsp("parentModule") end, "Parent module")
            map("n", "K",          function() vim.cmd.RustLsp({ "hover", "actions" }) end, "Hover actions")
          end,
          default_settings = {
            ["rust-analyzer"] = {
              cargo        = { allFeatures = true, loadOutDirsFromCheck = true, runBuildScripts = true },
              checkOnSave  = { allFeatures = true, command = "clippy", extraArgs = { "--no-deps" } },
              procMacro    = { enable = true },
              inlayHints   = { lifetimeElisionHints = { enable = "always" } },
            },
          },
        },
        dap = (vim.fn.executable(codelldb) == 1) and {
          adapter = require("rustaceanvim.config").get_codelldb_adapter(codelldb, liblldb),
        } or nil,
      }
    end,
  },

  -- crates.nvim: completion + version info inside Cargo.toml
  {
    "saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      completion = {
        cmp = { enabled = true },
        crates = { enabled = true },
      },
      lsp = {
        enabled        = true,
        actions        = true,
        completion     = true,
        hover          = true,
      },
    },
  },
}
