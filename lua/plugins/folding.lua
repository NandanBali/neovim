-- nvim-ufo: modern folding with LSP/treesitter/indent providers.
-- Keybinds:
--   zR  — open all folds
--   zM  — close all folds
--   zr  — open one more fold level
--   zm  — close one more fold level
--   K   — peek fold (shows contents without opening it)
return {
  {
    "kevinhwang91/nvim-ufo",
    dependencies = { "kevinhwang91/promise-async" },
    event = { "BufReadPost", "BufNewFile" },
    keys = {
      { "zR", function() require("ufo").openAllFolds()  end, desc = "Open all folds" },
      { "zM", function() require("ufo").closeAllFolds() end, desc = "Close all folds" },
      { "zr", function() require("ufo").openFoldsExceptKinds() end, desc = "Open folds (except kinds)" },
      { "zm", function() require("ufo").closeFoldsWith() end, desc = "Close folds" },
      {
        "K",
        function()
          local winid = require("ufo").peekFoldedLinesUnderCursor()
          if not winid then
            vim.lsp.buf.hover()
          end
        end,
        desc = "Peek fold / Hover",
      },
    },
    opts = {
      -- Return nil for special/non-file buffers so ufo skips them entirely
      -- (avoids UfoFallbackException in plugin UIs like Lazy, Telescope, etc.)
      provider_selector = function(bufnr, filetype, buftype)
        if buftype ~= "" or filetype == "" then return end
        local ft_map = {
          haskell = { "treesitter", "indent" },
          cpp     = { "lsp", "indent" },
          c       = { "lsp", "indent" },
          ocaml   = { "treesitter", "indent" },
          cmake   = { "indent" },
          lua     = { "treesitter", "indent" },
        }
        return ft_map[filetype] or { "lsp", "indent" }
      end,

      -- Nicer fold text showing count of hidden lines
      fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate)
        local newVirtText = {}
        local suffix = (" 󰁂 %d lines "):format(endLnum - lnum)
        local sufWidth = vim.fn.strdisplaywidth(suffix)
        local targetWidth = width - sufWidth
        local curWidth = 0

        for _, chunk in ipairs(virtText) do
          local chunkText = chunk[1]
          local chunkWidth = vim.fn.strdisplaywidth(chunkText)
          if targetWidth > curWidth + chunkWidth then
            table.insert(newVirtText, chunk)
          else
            chunkText = truncate(chunkText, targetWidth - curWidth)
            local hlGroup = chunk[2]
            table.insert(newVirtText, { chunkText, hlGroup })
            chunkWidth = vim.fn.strdisplaywidth(chunkText)
            if curWidth + chunkWidth < targetWidth then
              suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
            end
            break
          end
          curWidth = curWidth + chunkWidth
        end

        table.insert(newVirtText, { suffix, "MoreMsg" })
        return newVirtText
      end,
    },
  },

  -- Visual fold level indicator in the sign column
  {
    "luukvbaal/statuscol.nvim",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      local builtin = require("statuscol.builtin")
      require("statuscol").setup({
        relculright = true,
        segments = {
          { text = { builtin.foldfunc },      click = "v:lua.ScFa" },
          { text = { "%s" },                  click = "v:lua.ScSa" },
          { text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
        },
      })
    end,
  },
}
