return {
  -- CMake integration
  {
    "Civitasv/cmake-tools.nvim",
    ft = { "cmake", "cpp", "c" },
    dependencies = { "akinsho/toggleterm.nvim" },
    keys = {
      { "<leader>cg", "<cmd>CMakeGenerate<CR>",      desc = "CMake generate" },
      { "<leader>cb", "<cmd>CMakeBuild<CR>",          desc = "CMake build" },
      { "<leader>cr", "<cmd>CMakeRun<CR>",            desc = "CMake run" },
      { "<leader>cd", "<cmd>CMakeDebug<CR>",          desc = "CMake debug" },
      { "<leader>cs", "<cmd>CMakeSelectBuildType<CR>",desc = "CMake select build type" },
      { "<leader>ct", "<cmd>CMakeSelectBuildTarget<CR>", desc = "CMake select target" },
      { "<leader>cC", "<cmd>CMakeClean<CR>",          desc = "CMake clean" },
      { "<leader>cx", "<cmd>CMakeClose<CR>",          desc = "CMake close runner" },
    },
    opts = {
      cmake_executor = {
        name = "toggleterm",
        opts = {
          direction = "horizontal",
          auto_scroll = true,
          close_on_exit = false,
          singleton = true,
        },
      },
      cmake_runner = {
        name = "toggleterm",
        opts = {
          direction = "horizontal",
          auto_scroll = true,
          close_on_exit = false,
          singleton = true,
        },
      },
      cmake_build_directory = "build/${variant:buildType}",
      cmake_generate_options = { "-DCMAKE_EXPORT_COMPILE_COMMANDS=1" },
    },
  },

  -- DAP (debugger)
  {
    "mfussenegger/nvim-dap",
    keys = {
      { "<leader>db", "<cmd>lua require('dap').toggle_breakpoint()<CR>", desc = "Toggle breakpoint" },
      { "<leader>dB", function()
          require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
        end, desc = "Conditional breakpoint" },
      { "<leader>dc", "<cmd>lua require('dap').continue()<CR>",          desc = "DAP continue" },
      { "<leader>dn", "<cmd>lua require('dap').step_over()<CR>",         desc = "DAP step over" },
      { "<leader>di", "<cmd>lua require('dap').step_into()<CR>",         desc = "DAP step into" },
      { "<leader>do", "<cmd>lua require('dap').step_out()<CR>",          desc = "DAP step out" },
      { "<leader>dr", "<cmd>lua require('dap').repl.open()<CR>",         desc = "DAP REPL" },
      { "<leader>dq", "<cmd>lua require('dap').terminate()<CR>",         desc = "DAP terminate" },
    },
    config = function()
      local dap = require("dap")
      -- codelldb for C/C++ (installed via Mason)
      dap.adapters.codelldb = {
        type = "server",
        port = "${port}",
        executable = {
          command = vim.fn.stdpath("data") .. "/mason/bin/codelldb",
          args    = { "--port", "${port}" },
        },
      }
      local cpp_config = {
        {
          name    = "Launch file",
          type    = "codelldb",
          request = "launch",
          program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
          end,
          cwd            = "${workspaceFolder}",
          stopOnEntry    = false,
          args           = {},
        },
      }
      dap.configurations.cpp = cpp_config
      dap.configurations.c   = cpp_config
    end,
  },

  -- DAP UI
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    keys = {
      { "<leader>du", function() require("dapui").toggle() end, desc = "Toggle DAP UI" },
      { "<leader>de", function() require("dapui").eval()  end,  desc = "DAP eval expr", mode = { "n", "v" } },
    },
    config = function()
      local dap, dapui = require("dap"), require("dapui")
      dapui.setup()
      dap.listeners.after.event_initialized["dapui_config"]  = function() dapui.open() end
      dap.listeners.before.event_terminated["dapui_config"]  = function() dapui.close() end
      dap.listeners.before.event_exited["dapui_config"]      = function() dapui.close() end
    end,
  },

  -- Mason DAP integration (auto-installs codelldb)
  {
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = { "williamboman/mason.nvim", "mfussenegger/nvim-dap" },
    cmd = { "DapInstall", "DapUninstall" },
    opts = {
      ensure_installed = { "codelldb" },
      automatic_installation = true,
      handlers = {},
    },
  },
}
