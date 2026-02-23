return {
  "Civitasv/cmake-tools.nvim",
  ft = { "cmake", "cpp", "c" },
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require("cmake-tools").setup {
      cmake_command = "cmake",
      cmake_regenerate_on_save = true,
      cmake_generate_options = { "-DCMAKE_EXPORT_COMPILE_COMMANDS=1" },
      cmake_build_directory = "build/${variant:buildType}",
      cmake_build_directory_prefix = "",
      cmake_build_options = {},
      cmake_console_size = 10,
      cmake_console_position = "belowright",
      cmake_show_console = "always",
      cmake_dap_configuration = {
        name = "cpp",
        type = "codelldb",
        request = "launch",
      },
      cmake_executor = {
        name = "toggleterm",
        opts = {
          direction = "horizontal",
          auto_scroll = true,
          singleton = true,
        },
      },
    }

    local map = vim.keymap.set
    map("n", "<leader>cmg", "<cmd>CMakeGenerate<cr>", { desc = "CMake: Generate" })
    map("n", "<leader>cmb", "<cmd>CMakeBuild<cr>", { desc = "CMake: Build" })
    map("n", "<leader>cmr", "<cmd>CMakeRun<cr>", { desc = "CMake: Run" })
    map("n", "<leader>cmd", "<cmd>CMakeDebug<cr>", { desc = "CMake: Debug" })
    map("n", "<leader>cmt", "<cmd>CMakeSelectBuildTarget<cr>", { desc = "CMake: Select build target" })
    map("n", "<leader>cml", "<cmd>CMakeSelectLaunchTarget<cr>", { desc = "CMake: Select launch target" })
    map("n", "<leader>cmx", "<cmd>CMakeClean<cr>", { desc = "CMake: Clean" })
    map("n", "<leader>cms", "<cmd>CMakeStop<cr>", { desc = "CMake: Stop" })
  end,
}
