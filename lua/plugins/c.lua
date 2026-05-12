-- Plain-Makefile / single-file C ergonomics.
-- LSP (clangd), treesitter, clang_format, and codelldb DAP all live in
-- lsp.lua / treesitter.lua / cpp.lua. This file only adds make/gcc shortcuts
-- for projects that don't use CMake.
return {
  -- which-key group for <leader>e (ft-scoped to C)
  {
    "folke/which-key.nvim",
    optional = true,
    opts = {
      spec = {
        { "<leader>e", group = "C build", icon = " ", ft = { "c" } },
      },
    },
  },

  {
    "akinsho/toggleterm.nvim",
    optional = true,
    ft = { "c" },
    config = function()
      local map = function(lhs, rhs, desc)
        vim.keymap.set("n", lhs, rhs, { desc = desc })
      end

      map("<leader>em", "<cmd>TermExec cmd='make'<CR>",       "make")
      map("<leader>ec", "<cmd>TermExec cmd='make clean'<CR>", "make clean")
      map("<leader>er", "<cmd>TermExec cmd='make run'<CR>",   "make run")
      map("<leader>et", "<cmd>TermExec cmd='make test'<CR>",  "make test")

      -- Single-file compile of current buffer with debug flags.
      map("<leader>eg", function()
        local file = vim.fn.expand("%:p")
        local out  = vim.fn.expand("%:p:r")
        vim.cmd(("TermExec cmd='gcc -Wall -Wextra -O0 -g %q -o %q'"):format(file, out))
      end, "gcc compile current file")

      -- Run the compiled binary (same name as buffer, without extension).
      map("<leader>eR", function()
        local out = vim.fn.expand("%:p:r")
        vim.cmd(("TermExec cmd=%q"):format(out))
      end, "Run compiled binary")
    end,
  },
}
