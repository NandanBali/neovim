-- Go tooling.
-- LSP (gopls) lives in lsp.lua. conform formatters (goimports + gofumpt) also live there.
-- This file owns:
--   - non-LSP CLI installs via mason-tool-installer (gofumpt, goimports, golangci-lint, delve)
--   - DAP integration via nvim-dap-go (delve)
--   - <leader>G build/test/run keymaps via toggleterm
return {
  -- which-key group for <leader>G (ft-scoped to go)
  {
    "folke/which-key.nvim",
    optional = true,
    opts = {
      spec = {
        { "<leader>G", group = "Go", icon = " ", ft = { "go" } },
      },
    },
  },

  -- Ensure non-LSP Go CLIs are installed via Mason.
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      ensure_installed = {
        "gofumpt",
        "goimports",
        "golangci-lint",
        "delve",
      },
      auto_update  = false,
      run_on_start = true,
    },
  },

  -- DAP for Go (reuses nvim-dap + dap-ui from cpp.lua).
  {
    "leoluz/nvim-dap-go",
    ft = "go",
    dependencies = {
      "mfussenegger/nvim-dap",
      "rcarriga/nvim-dap-ui",
    },
    opts = {},
  },

  -- Build/test/run keymaps via toggleterm (mirrors c.lua's pattern).
  {
    "akinsho/toggleterm.nvim",
    optional = true,
    ft = { "go" },
    config = function()
      local map = function(lhs, rhs, desc)
        vim.keymap.set("n", lhs, rhs, { desc = desc })
      end

      map("<leader>Gb", "<cmd>TermExec cmd='go build ./...'<CR>",   "go build")
      map("<leader>Gr", "<cmd>TermExec cmd='go run .'<CR>",          "go run .")
      map("<leader>Gt", "<cmd>TermExec cmd='go test ./...'<CR>",     "go test")
      map("<leader>GT", "<cmd>TermExec cmd='go test -v ./...'<CR>",  "go test -v")
      map("<leader>Gm", "<cmd>TermExec cmd='go mod tidy'<CR>",       "go mod tidy")
      map("<leader>Gv", "<cmd>TermExec cmd='go vet ./...'<CR>",      "go vet")
      map("<leader>Gl", "<cmd>TermExec cmd='golangci-lint run'<CR>", "golangci-lint")

      -- Test only the function under the cursor (delve-driven).
      map("<leader>Gd", function() require("dap-go").debug_test() end,        "Debug test under cursor")
      map("<leader>GD", function() require("dap-go").debug_last_test() end,   "Debug last test")
    end,
  },
}
