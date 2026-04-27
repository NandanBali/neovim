-- Quality-of-life plugins
return {
  -- Autopairs
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {
      check_ts = true,
      ts_config = { lua = { "string" }, javascript = { "template_string" } },
    },
    config = function(_, opts)
      local autopairs = require("nvim-autopairs")
      autopairs.setup(opts)
      -- integrate with cmp
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
  },

  -- Comments
  {
    "numToStr/Comment.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {},
  },

  -- Surround
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    opts = {},
  },

  -- Git signs
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      signs = {
        add          = { text = "▎" },
        change       = { text = "▎" },
        delete       = { text = "" },
        topdelete    = { text = "" },
        changedelete = { text = "▎" },
        untracked    = { text = "▎" },
      },
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns
        local map = function(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
        end
        map("n", "]h", gs.next_hunk,                      "Next hunk")
        map("n", "[h", gs.prev_hunk,                      "Prev hunk")
        map("n", "<leader>gp", gs.preview_hunk,           "Preview hunk")
        map("n", "<leader>gr", gs.reset_hunk,             "Reset hunk")
        map("n", "<leader>gR", gs.reset_buffer,           "Reset buffer")
        map("n", "<leader>gS", gs.stage_buffer,           "Stage buffer")
        map("n", "<leader>gu", gs.undo_stage_hunk,        "Undo stage hunk")
        map("n", "<leader>gd", gs.diffthis,               "Diff this")
        map("n", "<leader>gD", function() gs.diffthis("~") end, "Diff ~HEAD")
        map("n", "<leader>gB", function() gs.blame_line({ full = true }) end, "Blame line")
        map("n", "<leader>gT", gs.toggle_current_line_blame, "Toggle blame")
      end,
    },
  },

  -- Trouble (pretty diagnostics)
  {
    "folke/trouble.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",
    cmd = "Trouble",
    keys = {
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<CR>",              desc = "Diagnostics" },
      { "<leader>xb", "<cmd>Trouble diagnostics toggle filter.buf=0<CR>", desc = "Buffer diagnostics" },
      { "<leader>xl", "<cmd>Trouble loclist toggle<CR>",                  desc = "Location list" },
      { "<leader>xq", "<cmd>Trouble qflist toggle<CR>",                   desc = "Quickfix list" },
    },
    opts = { use_diagnostic_signs = true },
  },

  -- Flash (better motion)
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      { "s",     function() require("flash").jump()              end, desc = "Flash jump",              mode = { "n", "x", "o" } },
      { "S",     function() require("flash").treesitter()        end, desc = "Flash treesitter",        mode = { "n", "x", "o" } },
      { "r",     function() require("flash").remote()            end, desc = "Flash remote",            mode = "o" },
      { "R",     function() require("flash").treesitter_search() end, desc = "Flash treesitter search", mode = { "x", "o" } },
      { "<C-s>", function() require("flash").toggle()            end, desc = "Toggle flash search",     mode = "c" },
    },
  },

  -- Todo comments
  {
    "folke/todo-comments.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    event = { "BufReadPost", "BufNewFile" },
    keys = {
      { "]t",         function() require("todo-comments").jump_next() end, desc = "Next todo comment" },
      { "[t",         function() require("todo-comments").jump_prev() end, desc = "Prev todo comment" },
      { "<leader>st", "<cmd>TodoTelescope<CR>", desc = "Search todos" },
    },
    opts = {},
  },

  -- Fuzzy word search in buffer
  {
    "kevinhwang91/nvim-hlslens",
    event = "BufReadPost",
    opts = { calm_down = true, nearest_only = true },
  },

  -- Better quickfix
  {
    "kevinhwang91/nvim-bqf",
    ft = "qf",
    opts = { preview = { winblend = 0 } },
  },
}
