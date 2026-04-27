-- haskell-tools.nvim — do NOT use nvim-lspconfig for HLS.
-- This plugin manages HLS directly and provides extra features.
return {
  {
    "mrcjkb/haskell-tools.nvim",
    version = "^4",
    ft = { "haskell", "lhaskell", "cabal", "cabalproject" },
    dependencies = { "nvim-telescope/telescope.nvim" },
    init = function()
      -- Config must be set before the plugin loads
      vim.g.haskell_tools = {
        hls = {
          on_attach = function(client, bufnr, ht)
            local map = function(lhs, rhs, desc)
              vim.keymap.set("n", lhs, rhs, { buffer = bufnr, desc = desc })
            end

            -- Standard LSP
            map("gd",          vim.lsp.buf.definition,     "Go to definition")
            map("gi",          vim.lsp.buf.implementation, "Go to implementation")
            map("gr",          vim.lsp.buf.references,     "References")
            map("<leader>la",  vim.lsp.buf.code_action,    "Code action")
            map("<leader>ln",  vim.lsp.buf.rename,         "Rename symbol")
            map("<leader>lf",  function() vim.lsp.buf.format({ async = true }) end, "Format")

            -- Haskell-specific
            map("<leader>hs", ht.hoogle.hoogle_signature,          "Hoogle: signature search")
            map("<leader>he", ht.lsp.buf_eval_all,                  "Evaluate all")
            map("<leader>hr", "<cmd>HaskellRepl<CR>",               "Open GHCi REPL")
            map("<leader>hR", "<cmd>HaskellRepl expand<CR>",        "REPL for file")
            map("<leader>ht", "<cmd>HaskellRunTests<CR>",           "Run tests")

            -- Cabal targets via Telescope
            map("<leader>hc", require("telescope").extensions.ht.package_hsfiles,  "Browse Cabal hs-files")
            map("<leader>hg", require("telescope").extensions.ht.package_grep,     "Grep Cabal package")
          end,
          settings = {
            haskell = {
              formattingProvider   = "fourmolu",
              checkParents         = "CheckOnSave",
              checkProject         = true,
              maxCompletions       = 40,
              plugin = {
                stan = { globalOn = true },
                tactics = {
                  globalOn = true,
                  config = {
                    auto_gas    = 4,
                    hole_severity = nil,
                    max_use_ctor_actions = 5,
                    timeout_duration = 2,
                    bind_operator_ty = "m a -> (a -> m b) -> m b",
                  },
                },
              },
            },
          },
        },
        tools = {
          repl = {
            handler = "toggleterm",
            -- auto-detect cabal vs stack
            prefer_cabal_repl = function(root)
              return require("haskell-tools.project.util").is_cabal_project(root)
            end,
          },
          hover = {
            border = "rounded",
            stylize_markdown = false,
          },
          definition = {
            hoogle_signature_fallback = true,
          },
        },
      }
    end,
  },}
