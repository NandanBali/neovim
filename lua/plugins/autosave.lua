return {
  "okuuva/auto-save.nvim",
  cmd = "ASToggle", -- optional for lazy loading on command
  event = { "InsertLeave", "TextChanged" }, -- optional for lazy loading on trigger events
  opts = {
    enabled = true, -- start auto-save when the plugin is loaded
    execution_message = {
      enabled = true,
      message = function() -- message to print on save
        return ("AutoSave: saved at " .. vim.fn.strftime("%H:%M:%S"))
      end,
      dim = 0.18, -- dim the color of message
      cleaning_interval = 1250, -- automatically clean MsgArea after displaying message
    },
    trigger_events = {
      immediate_save = { "BufLeave", "FocusLost" }, -- vim events that trigger an immediate save
      defer_save = { "InsertLeave", "TextChanged" }, -- vim events that trigger a deferred save
      cancel_deferred_save = { "InsertEnter" }, -- vim events that cancel a pending deferred save
    },
    condition = nil, -- function that determines whether to save the current buffer
    write_all_buffers = false, -- write all buffers when the current one meets condition
    noautocmd = false, -- do not execute autocmds when saving
    debounce_delay = 1000, -- delay after which a pending save is executed
    debug = false,
  },
}

