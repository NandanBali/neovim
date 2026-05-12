return {
  -- Mason: LSP/DAP/linter installer
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    build = ":MasonUpdate",
    opts = {
      ui = { border = "rounded", icons = { package_installed = "✓", package_pending = "➜", package_uninstalled = "✗" } },
    },
  },

  -- mason-lspconfig bridge (installation only)
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      ensure_installed = {
        "clangd",    -- C/C++
        "lua_ls",    -- Lua
        "eslint",    -- JS/TS lint diagnostics + code actions
        "gopls",     -- Go
        -- ocamllsp is installed via opam, not Mason
        -- ts_ls is owned by typescript-tools.nvim (typescript.lua)
      },
      automatic_installation = true,
    },
  },

  -- nvim-lspconfig: provides default server configs (filetypes, cmd, root detection).
  -- Setup is done via vim.lsp.config / vim.lsp.enable (nvim 0.11 API).
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Rounded borders for LSP float windows
      vim.lsp.handlers["textDocument/hover"]         = vim.lsp.with(vim.lsp.handlers.hover,          { border = "rounded" })
      vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })

      vim.diagnostic.config({
        virtual_text     = { prefix = "●" },
        signs            = true,
        underline        = true,
        update_in_insert = false,
        float            = { border = "rounded", source = "always" },
      })

      local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
      end

      -- Shared config applied to ALL servers (capabilities + keymaps)
      vim.lsp.config("*", {
        capabilities = capabilities,
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
          map("n", "<leader>la", vim.lsp.buf.code_action,     "Code action")
          map("v", "<leader>la", vim.lsp.buf.code_action,     "Code action (range)")
          map("n", "<leader>ln", vim.lsp.buf.rename,          "Rename")
          map("n", "<leader>lh", vim.lsp.buf.signature_help,  "Signature help")
          -- Hover: works on the symbol under cursor (n) and at the start of a selection (v).
          -- For C this shows the variable's type, declaration, and any clangd docs.
          map({ "n", "v" }, "<leader>lk", vim.lsp.buf.hover, "Hover (type info)")
          -- Top-level info dialog: shows signature, type, and documentation in
          -- one floating window. Leader is <Space>, so this stays normal-mode
          -- only; <C-k> below covers insert mode without eating literal spaces.
          map("n", "<leader>K", vim.lsp.buf.hover, "Info dialog (signature + docs)")
          map("i", "<C-k>",     vim.lsp.buf.signature_help, "Signature help (insert)")
          -- Toggle inlay hints (parameter names, deduced types, etc.) for this buffer.
          map("n", "<leader>lI", function()
            vim.lsp.inlay_hint.enable(
              not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }),
              { bufnr = bufnr }
            )
          end, "Toggle inlay hints")
          -- Enable inlay hints by default for buffers whose server supports them
          -- (no-op for servers that don't, e.g. lua_ls in older versions).
          vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
        end,
      })

      -- clangd (C/C++)
      vim.lsp.config("clangd", {
        cmd = {
          "clangd",
          "--background-index",
          "--clang-tidy",
          "--header-insertion=iwyu",
          "--completion-style=detailed",
          "--function-arg-placeholders",
          "--fallback-style=llvm",
        },
        init_options = {
          usePlaceholders    = true,
          completeUnimported = true,
          clangdFileStatus   = true,
        },
        -- clangd uses utf-16 offsets
        capabilities = vim.tbl_deep_extend("force", capabilities, {
          offsetEncoding = { "utf-16" },
        }),
      })


      -- Lua (for editing this nvim config)
      vim.lsp.config("lua_ls", {
        settings = {
          Lua = {
            runtime     = { version = "LuaJIT" },
            diagnostics = { globals = { "vim" } },
            workspace   = { library = vim.api.nvim_get_runtime_file("", true), checkThirdParty = false },
            telemetry   = { enable = false },
          },
        },
      })

      -- OCaml
      vim.lsp.config("ocamllsp", {})

      -- gopls (Go)
      vim.lsp.config("gopls", {
        settings = {
          gopls = {
            gofumpt           = true,
            staticcheck       = true,
            usePlaceholders   = true,
            completeUnimported = true,
            analyses = {
              unusedparams = true,
              unusedwrite  = true,
              shadow       = true,
              nilness      = true,
              useany       = true,
            },
            hints = {
              assignVariableTypes    = true,
              compositeLiteralFields = true,
              compositeLiteralTypes  = true,
              constantValues         = true,
              functionTypeParameters = true,
              parameterNames         = true,
              rangeVariableTypes     = true,
            },
          },
        },
      })

      -- ESLint (JS/TS lint via LSP). Auto-fix on save when attached, but
      -- skip when the buffer is being saved from insert mode so that an
      -- in-flight edit isn't reformatted out from under the cursor.
      vim.lsp.config("eslint", {
        on_attach = function(_, bufnr)
          vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            callback = function()
              if vim.fn.mode():sub(1, 1) == "i" then return end
              vim.cmd("EslintFixAll")
            end,
          })
        end,
      })

      -- Enable all servers
      vim.lsp.enable({ "clangd", "lua_ls", "ocamllsp", "eslint", "gopls" })
    end,
  },

  -- clangd extra features (inlay hints, AST view)
  {
    "p00f/clangd_extensions.nvim",
    ft = { "c", "cpp" },
    opts = {
      inlay_hints = { inline = true },
      ast = {
        role_icons = { type = "", declaration = "", expression = "󰏦", specifier = "", statement = "", ["template argument"] = "" },
        kind_icons = { Compound = "", Recovery = "", TranslationUnit = "", PackExpansion = "", TemplateTypeParm = "", TemplateTemplateParm = "", TemplateParamObject = "" },
      },
    },
  },

  -- Formatting
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      { "<leader>lf", function() require("conform").format({ async = true, lsp_fallback = true }) end, desc = "Format buffer" },
    },
    opts = {
      formatters_by_ft = {
        c               = { "clang_format" },
        cpp             = { "clang_format" },
        lua             = { "stylua" },
        haskell         = { "fourmolu" },
        ocaml           = { "ocamlformat" },
        javascript      = { "prettierd", "prettier", stop_after_first = true },
        javascriptreact = { "prettierd", "prettier", stop_after_first = true },
        typescript      = { "prettierd", "prettier", stop_after_first = true },
        typescriptreact = { "prettierd", "prettier", stop_after_first = true },
        json            = { "prettierd", "prettier", stop_after_first = true },
        jsonc           = { "prettierd", "prettier", stop_after_first = true },
        css             = { "prettierd", "prettier", stop_after_first = true },
        html            = { "prettierd", "prettier", stop_after_first = true },
        markdown        = { "prettierd", "prettier", stop_after_first = true },
        go              = { "goimports", "gofumpt" },
      },
      -- Skip auto-format when saving while still in insert mode — prevents
      -- the formatter from reshaping the buffer mid-edit (e.g. on `:w` from
      -- an `<Esc>:w` shortcut that fires before the mode change settles).
      format_on_save = function(_)
        if vim.fn.mode():sub(1, 1) == "i" then return end
        return { timeout_ms = 500, lsp_fallback = true }
      end,
    },
  },
}
