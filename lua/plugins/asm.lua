-- x86 / x86-64 assembly support (GAS / Intel / NASM / MASM).
-- LSP: asm-lsp (https://github.com/bergercookie/asm-lsp) — installed via Mason.
return {
  -- Ensure asm-lsp is installed via Mason.
  {
    "williamboman/mason-lspconfig.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      table.insert(opts.ensure_installed, "asm_lsp")
    end,
  },

  -- Filetype detection + lazy asm_lsp registration.
  -- Avoids a second `config` on nvim-lspconfig (which would overwrite lsp.lua).
  {
    "neovim/nvim-lspconfig",
    init = function()
      -- .asm/.nasm/.inc → nasm dialect; .s/.S keep the built-in 'asm' ft (GAS).
      vim.filetype.add({
        extension = {
          asm  = "nasm",
          nasm = "nasm",
          inc  = "nasm",
          s    = "asm",
          S    = "asm",
        },
      })

      -- Register and enable asm_lsp the first time an asm buffer is opened.
      local registered = false
      vim.api.nvim_create_autocmd("FileType", {
        pattern  = { "asm", "vmasm", "nasm", "masm" },
        callback = function()
          if registered then return end
          registered = true
          vim.lsp.config("asm_lsp", {
            filetypes    = { "asm", "vmasm", "nasm", "masm" },
            root_markers = { ".asm-lsp.toml", ".git" },
          })
          vim.lsp.enable({ "asm_lsp" })
        end,
      })
    end,
  },
}
