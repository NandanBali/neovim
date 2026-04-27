return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      "nvim-treesitter/nvim-treesitter-context",
    },
    main = "nvim-treesitter",   -- tells lazy to call require("nvim-treesitter").setup(opts)
    opts = {
      ensure_installed = {
        "c", "cpp", "rust", "haskell", "ocaml", "ocaml_interface", "lua", "vim", "vimdoc",
        "cmake", "make", "bash", "json", "yaml", "toml",
        "asm", "nasm",
        "markdown", "markdown_inline", "regex",
      },
      auto_install = true,
      highlight = { enable = true },
      indent    = { enable = true },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection    = "<C-space>",
          node_incremental  = "<C-space>",
          scope_incremental = "<C-s>",
          node_decremental  = "<bs>",
        },
      },
      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner",
            ["aa"] = "@parameter.outer",
            ["ia"] = "@parameter.inner",
            ["ab"] = "@block.outer",
            ["ib"] = "@block.inner",
          },
        },
        move = {
          enable    = true,
          set_jumps = true,
          goto_next_start     = { ["]f"] = "@function.outer", ["]c"] = "@class.outer" },
          goto_next_end       = { ["]F"] = "@function.outer", ["]C"] = "@class.outer" },
          goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer" },
          goto_previous_end   = { ["[F"] = "@function.outer", ["[C"] = "@class.outer" },
        },
        swap = {
          enable        = true,
          swap_next     = { ["<leader>a"] = "@parameter.inner" },
          swap_previous = { ["<leader>A"] = "@parameter.inner" },
        },
      },
    },
    config = function(_, opts)
      require("nvim-treesitter").setup(opts)

      -- Treesitter context (shows current function/class at top of window)
      require("treesitter-context").setup({
        enable     = true,
        max_lines  = 4,
        trim_scope = "outer",
      })
    end,
  },
}
