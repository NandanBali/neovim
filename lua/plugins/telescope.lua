return {
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      "nvim-telescope/telescope-ui-select.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    cmd = "Telescope",
    keys = {
      -- Files
      { "<leader>ff", "<cmd>Telescope find_files<CR>",                desc = "Find files" },
      { "<leader>fr", "<cmd>Telescope oldfiles<CR>",                  desc = "Recent files" },
      { "<leader>fb", "<cmd>Telescope buffers<CR>",                   desc = "Buffers" },
      { "<leader>fg", "<cmd>Telescope git_files<CR>",                 desc = "Git files" },
      -- Search
      { "<leader>sg", "<cmd>Telescope live_grep<CR>",                 desc = "Live grep" },
      { "<leader>sw", "<cmd>Telescope grep_string<CR>",               desc = "Grep word under cursor" },
      { "<leader>ss", "<cmd>Telescope current_buffer_fuzzy_find<CR>", desc = "Fuzzy find in buffer" },
      -- LSP
      { "<leader>ls", "<cmd>Telescope lsp_document_symbols<CR>",      desc = "Document symbols" },
      { "<leader>lS", "<cmd>Telescope lsp_workspace_symbols<CR>",     desc = "Workspace symbols" },
      { "<leader>lr", "<cmd>Telescope lsp_references<CR>",            desc = "References" },
      { "<leader>ld", "<cmd>Telescope lsp_definitions<CR>",           desc = "Definitions" },
      -- Git
      { "<leader>gc", "<cmd>Telescope git_commits<CR>",               desc = "Git commits" },
      { "<leader>gb", "<cmd>Telescope git_branches<CR>",              desc = "Git branches" },
      { "<leader>gs", "<cmd>Telescope git_status<CR>",                desc = "Git status" },
      -- Misc
      { "<leader>:",  "<cmd>Telescope command_history<CR>",           desc = "Command history" },
      { "<leader>sk", "<cmd>Telescope keymaps<CR>",                   desc = "Search keymaps" },
      { "<leader>sh", "<cmd>Telescope help_tags<CR>",                 desc = "Help tags" },
      { "<leader>sd", "<cmd>Telescope diagnostics<CR>",               desc = "Diagnostics" },
      { "<leader>sm", "<cmd>Telescope marks<CR>",                     desc = "Marks" },
    },
    config = function()
      local telescope = require("telescope")
      local actions   = require("telescope.actions")

      telescope.setup({
        defaults = {
          prompt_prefix   = "   ",
          selection_caret = "  ",
          path_display    = { "truncate" },
          sorting_strategy = "ascending",
          layout_config = {
            horizontal = { prompt_position = "top", preview_width = 0.55 },
            vertical   = { mirror = false },
            width = 0.87,
            height = 0.80,
            preview_cutoff = 120,
          },
          mappings = {
            i = {
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
              ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
              ["<Esc>"] = actions.close,
            },
          },
        },
        extensions = {
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter    = true,
            case_mode               = "smart_case",
          },
          ["ui-select"] = {
            require("telescope.themes").get_dropdown(),
          },
        },
      })

      telescope.load_extension("fzf")
      telescope.load_extension("ui-select")
    end,
  },
}
