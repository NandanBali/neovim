return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.configs").setup({
      -- A list of parser names, or "all"
      ensure_installed = {
        "javascript",
        "typescript",
        "tsx",
        "json",
        "css",
        "html",
        "lua",
        "vim",
        "vimdoc",
      },
      -- Install parsers synchronously (only applied to `ensure_installed`)
      sync_install = false,
      auto_install = true,
      highlight = {
        enable = true,
      },
      indent = { enable = true },
      -- Add textobjects for React components
      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ["aac"] = "@class.outer",
            ["iac"] = "@class.inner",
            ["aaf"] = "@function.outer",
            ["iaf"] = "@function.inner",
            ["aat"] = { query = "@block.outer", desc = "around tag" },
            ["iat"] = { query = "@block.inner", desc = "inside tag" },
          },
        },
      },
    })
  end,
}
