-- OCaml tooling.
-- LSP (ocamllsp), treesitter, and formatting are handled in lsp.lua / treesitter.lua.
-- This file adds: utop REPL, dune build keybinds, .ml/.mli switcher, which-key group.
return {
  -- which-key group for <leader>m
  {
    "folke/which-key.nvim",
    optional = true,
    opts = {
      spec = {
        { "<leader>m", group = "OCaml", icon = " ", ft = { "ocaml", "ocaml_interface", "dune" } },
      },
    },
  },

  -- toggleterm: utop REPL + dune commands
  {
    "akinsho/toggleterm.nvim",
    optional = true,
    ft = { "ocaml", "ocaml_interface", "dune" },
    config = function()
      local Terminal = require("toggleterm.terminal").Terminal

      local utop = Terminal:new({
        cmd          = "utop",
        direction    = "horizontal",
        close_on_exit = false,
        hidden        = true,
      })

      local map = function(lhs, rhs, desc, mode)
        vim.keymap.set(mode or "n", lhs, rhs, { desc = desc })
      end

      -- REPL
      map("<leader>mr", function() utop:toggle() end, "Open utop REPL")

      -- Send current line to utop
      map("<leader>ml", function()
        local line = vim.api.nvim_get_current_line()
        utop:send(line .. " ;;", true)
      end, "Send line to utop")

      -- Send visual selection to utop
      vim.keymap.set("v", "<leader>ml", function()
        local s = vim.fn.line("'<") - 1
        local e = vim.fn.line("'>")
        local lines = vim.api.nvim_buf_get_lines(0, s, e, false)
        utop:send(table.concat(lines, "\n") .. " ;;", true)
      end, { desc = "Send selection to utop" })

      -- Dune
      map("<leader>mb", "<cmd>TermExec cmd='dune build'<CR>",         "Dune build")
      map("<leader>mt", "<cmd>TermExec cmd='dune test'<CR>",          "Dune test")
      map("<leader>mc", "<cmd>TermExec cmd='dune clean'<CR>",         "Dune clean")
      map("<leader>mw", "<cmd>TermExec cmd='dune build --watch'<CR>", "Dune build --watch")

      -- Switch between .ml and .mli
      map("<leader>ms", function()
        local file = vim.fn.expand("%:p")
        if file:match("%.mli$") then
          vim.cmd("edit " .. file:gsub("%.mli$", ".ml"))
        elseif file:match("%.ml$") then
          local mli = file:gsub("%.ml$", ".mli")
          if vim.fn.filereadable(mli) == 1 then
            vim.cmd("edit " .. mli)
          else
            vim.notify("No .mli file found", vim.log.levels.WARN)
          end
        end
      end, "Switch .ml / .mli")
    end,
  },
}
