return {
  -- Status line
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    config = function()
      require("lualine").setup {
        options = {
          theme = "carbonfox",
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
          globalstatus = true,
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch", "diff", "diagnostics" },
          lualine_c = { { "filename", path = 1 } },
          lualine_x = { "encoding", "fileformat", "filetype" },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },
      }
    end,
  },
  -- Icons
  { "nvim-tree/nvim-web-devicons", lazy = true },
  -- Keybinding hints
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      preset = "modern",
      delay = 400,
    },
    config = function(_, opts)
      local wk = require("which-key")
      wk.setup(opts)
      wk.add {
        { "<leader>b", group = "Buffers/Tabs" },
        { "<leader>d", group = "Debug (DAP)" },
        { "<leader>f", group = "Find (Telescope)" },
        { "<leader>h", group = "Git hunks" },
        { "<leader>x", group = "Trouble diagnostics" },
        { "<leader>cm", group = "CMake" },
        { "<leader>t", group = "Terminal" },
        { "<leader>l", group = "LSP" },
        { "<leader>r", group = "Rename" },
        { "<leader>c", group = "Code" },
      }
    end,
  },
  -- Indent guides
  {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPost", "BufNewFile" },
    main = "ibl",
    opts = {
      indent = {
        char = "│",
        smart_indent_cap = true,
      },
      scope = {
        enabled = true,
        show_start = true,
        show_end = true,
        show_exact_scope = true,
        injected_languages = false,
        include = {
          node_type = {
            c = {
              "function_definition",
              "struct_specifier",
              "if_statement",
              "for_statement",
              "while_statement",
              "switch_statement",
              "compound_statement",
            },
            cpp = {
              "namespace_definition",
              "class_specifier",
              "struct_specifier",
              "template_declaration",
              "template_function",
              "template_method",
              "function_definition",
              "lambda_expression",
              "if_statement",
              "for_statement",
              "while_statement",
              "switch_statement",
              "try_statement",
              "catch_clause",
              "compound_statement",
            },
          },
        },
        exclude = {
          node_type = {
            c = { "translation_unit" },
            cpp = { "translation_unit" },
          },
        },
      },
    },
  },
}
