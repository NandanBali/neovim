return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "mxsdev/nvim-dap-vscode-js",
    "nvim-neotest/nvim-nio",
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")

    -- VS Code JS debugger
    require("dap-vscode-js").setup({
      node_path = "node",
      debugger_path = vim.fn.stdpath("data") .. "/lazy/vscode-js-debug",
      adapters = { "pwa-node", "pwa-chrome" },
    })

    -- Debug configurations
    for _, language in ipairs({ "typescript", "javascript" }) do
      dap.configurations[language] = {
        {
          type = "pwa-node",
          request = "launch",
          name = "Launch file",
          program = "${file}",
          cwd = "${workspaceFolder}",
          runtimeExecutable = "node",
        },
        {
          type = "pwa-node",
          request = "launch",
          name = "Debug Expo",
          cwd = "${workspaceFolder}",
          runtimeExecutable = "npx",
          args = { "expo", "start", "--dev-client" },
        },
      }
    end

    dapui.setup()
    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
      dapui.close()
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
      dapui.close()
    end
  end,
}
