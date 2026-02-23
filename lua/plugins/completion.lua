return {
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lua",
      "onsails/lspkind.nvim",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
    },
    config = function()
      local cmp = require("cmp")
      local cmp_types = require("cmp.types")
      local lspkind = require("lspkind")
      local luasnip = require("luasnip")

      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup {
        preselect = cmp.PreselectMode.Item,
        completion = {
          completeopt = "menu,menuone,noinsert",
          keyword_length = 1,
        },
        snippet = {
          expand = function(args) luasnip.lsp_expand(args.body) end,
        },
        mapping = cmp.mapping.preset.insert {
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm { select = true },
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        },
        sources = {
          { name = "nvim_lsp", priority = 1000, keyword_length = 1 },
          { name = "buffer", priority = 850, keyword_length = 1 },
          { name = "luasnip", priority = 450, keyword_length = 1 },
          { name = "path", priority = 300 },
          { name = "nvim_lua", priority = 200 },
        },
        sorting = {
          comparators = {
            function(entry1, entry2)
              local snippet = cmp_types.lsp.CompletionItemKind.Snippet
              local kind1, kind2 = entry1:get_kind(), entry2:get_kind()
              if kind1 == snippet and kind2 ~= snippet then return false end
              if kind2 == snippet and kind1 ~= snippet then return true end
            end,
            cmp.config.compare.offset,
            cmp.config.compare.exact,
            cmp.config.compare.score,
            cmp.config.compare.kind,
            cmp.config.compare.sort_text,
            cmp.config.compare.length,
            cmp.config.compare.order,
          },
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        formatting = {
          fields = { "kind", "abbr", "menu" },
          format = lspkind.cmp_format {
            mode = "symbol_text",
            maxwidth = 50,
            ellipsis_char = "...",
            menu = {
              nvim_lsp = "[LSP]",
              buffer = "[Buf]",
              luasnip = "[Snip]",
              path = "[Path]",
              nvim_lua = "[Lua]",
            },
          },
        },
      }

      cmp.setup.filetype({ "c", "cpp" }, {
        sources = {
          { name = "nvim_lsp", priority = 1000, keyword_length = 1 },
          { name = "buffer", priority = 900, keyword_length = 1 },
          { name = "luasnip", priority = 450, keyword_length = 1 },
          { name = "path", priority = 300 },
        },
      })
    end,
  },
}
