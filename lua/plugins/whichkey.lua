return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      preset = "modern",
      delay = 400,
      icons = {
        mappings = true,
        keys = {
          Up = " ", Down = " ", Left = " ", Right = " ",
          C = "󰘴 ", M = "󰘵 ", S = "󰘶 ", CR = "󰌑 ",
          Esc = "󱊷 ", Space = "󱁐 ",
        },
      },
      spec = {
        -- Group labels (the cheatsheet organises around these)
        { "<leader>b",  group = "Buffers",    icon = "󰓩 " },
        { "<leader>f",  group = "Find/Files", icon = " " },
        { "<leader>g",  group = "Git",        icon = " " },
        { "<leader>l",  group = "LSP",        icon = " " },
        { "<leader>s",  group = "Search",     icon = " " },
        { "<leader>t",  group = "Terminal",   icon = " " },
        { "<leader>d",  group = "Debug/DAP",  icon = " " },
        { "<leader>c",  group = "Code",       icon = " " },
        { "<leader>h",  group = "Haskell",    icon = "λ " },
        { "<leader>x",  group = "Diagnostics",icon = " " },

        -- Buffer operations
        { "<leader>bd", "<cmd>bdelete<CR>",          desc = "Delete buffer",      icon = " " },
        { "<leader>bn", "<cmd>bnext<CR>",             desc = "Next buffer",        icon = " " },
        { "<leader>bN", "<cmd>bprevious<CR>",         desc = "Prev buffer",        icon = " " },
        { "<leader>bo", "<cmd>%bd|e#|bd#<CR>",        desc = "Close others",       icon = "󱡈 " },

        -- Window splits
        { "<leader>wv", "<cmd>vsplit<CR>",  desc = "Vertical split",   icon = " " },
        { "<leader>wh", "<cmd>split<CR>",   desc = "Horizontal split", icon = " " },
        { "<leader>wc", "<cmd>close<CR>",   desc = "Close window",     icon = "󰅙 " },
        { "<leader>ww", "<C-w>w",           desc = "Switch window",    icon = "󰁔 " },
        { "<leader>w",  group = "Windows",  icon = "󱂬 " },

        -- Lazy
        { "<leader>L",  "<cmd>Lazy<CR>",           desc = "Lazy plugin manager", icon = "󰒲 " },
        { "<leader>li", "<cmd>LspInfo<CR>",        desc = "LSP info",            icon = " " },
        { "<leader>lf", "<cmd>lua vim.lsp.buf.format({ async = true })<CR>",
          desc = "Format buffer", icon = " " },
        { "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<CR>",
          desc = "Code action",   icon = " " },
        { "<leader>ln", "<cmd>lua vim.lsp.buf.rename()<CR>",
          desc = "Rename symbol", icon = "󰑕 " },

        -- Diagnostics (trouble)
        { "<leader>xx", "<cmd>Trouble diagnostics toggle<CR>",              desc = "Diagnostics (Trouble)" },
        { "<leader>xb", "<cmd>Trouble diagnostics toggle filter.buf=0<CR>", desc = "Buffer diagnostics" },
        { "<leader>xl", "<cmd>Trouble loclist toggle<CR>",                  desc = "Location list" },
        { "<leader>xq", "<cmd>Trouble qflist toggle<CR>",                   desc = "Quickfix list" },

        -- Code
        { "<leader>cc", "<cmd>lua vim.lsp.buf.incoming_calls()<CR>", desc = "Incoming calls" },
        { "<leader>co", "<cmd>lua vim.lsp.buf.outgoing_calls()<CR>", desc = "Outgoing calls" },
        { "<leader>ci", "<cmd>lua vim.lsp.buf.implementation()<CR>", desc = "Go to implementation" },
        { "<leader>ct", "<cmd>lua vim.lsp.buf.type_definition()<CR>",desc = "Type definition" },
      },
    },
    keys = {
      { "<leader>?", function() require("which-key").show({ global = false }) end, desc = "Buffer keymaps (which-key)" },
    },
  },
}
