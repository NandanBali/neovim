-- Walk up `levels` directories from cwd. `levels=0` returns cwd itself.
local function ancestor(levels)
  local dir = vim.fn.getcwd()
  for _ = 1, (levels or 1) do
    dir = vim.fn.fnamemodify(dir, ":h")
  end
  return dir
end

-- Best-effort project root: nearest ancestor containing a VCS / project marker.
-- Falls back to cwd when no marker is found.
local function project_root()
  local markers = { ".git", ".hg", ".svn", "Makefile", "CMakeLists.txt", "package.json", "Cargo.toml", "stack.yaml", "cabal.project", "dune-project" }
  local found = vim.fs.find(markers, { upward = true, path = vim.fn.expand("%:p:h") })[1]
  if found then return vim.fn.fnamemodify(found, ":h") end
  return vim.fn.getcwd()
end

local function pick_dir(prompt, on_choice)
  vim.ui.input(
    { prompt = prompt, default = vim.fn.getcwd() .. "/", completion = "dir" },
    function(input)
      if not input or input == "" then return end
      local expanded = vim.fn.expand(input)
      if vim.fn.isdirectory(expanded) ~= 1 then
        vim.notify("Not a directory: " .. expanded, vim.log.levels.ERROR)
        return
      end
      on_choice(expanded)
    end
  )
end

local function find_files_in(dir)
  require("telescope.builtin").find_files({ cwd = dir, hidden = false })
end

local function live_grep_in(dir)
  require("telescope.builtin").live_grep({ cwd = dir })
end

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
      -- Files in parent / ancestor directories
      { "<leader>fF", function() find_files_in(ancestor(1)) end,      desc = "Find files (parent dir)" },
      { "<leader>fR", function() find_files_in(project_root()) end,   desc = "Find files (project root)" },
      { "<leader>fH", function() find_files_in(vim.fn.expand("$HOME")) end, desc = "Find files ($HOME)" },
      { "<leader>fU", function() pick_dir("Find files in: ", find_files_in) end, desc = "Find files (pick dir)" },
      -- Search
      { "<leader>sg", "<cmd>Telescope live_grep<CR>",                 desc = "Live grep" },
      { "<leader>sw", "<cmd>Telescope grep_string<CR>",               desc = "Grep word under cursor" },
      { "<leader>ss", "<cmd>Telescope current_buffer_fuzzy_find<CR>", desc = "Fuzzy find in buffer" },
      -- Grep in parent / ancestor directories
      { "<leader>sG", function() live_grep_in(ancestor(1)) end,       desc = "Live grep (parent dir)" },
      { "<leader>sR", function() live_grep_in(project_root()) end,    desc = "Live grep (project root)" },
      { "<leader>sU", function() pick_dir("Live grep in: ", live_grep_in) end, desc = "Live grep (pick dir)" },
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
        pickers = {
          find_files = {
            -- Allow following symlinks and searching hidden dirs when explicitly requested
            -- via opts; defaults stay quiet for performance on large parent trees.
            follow = true,
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
