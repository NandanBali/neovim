local opt = vim.opt

opt.number = true
opt.relativenumber = true
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.smartindent = true
opt.wrap = false
opt.termguicolors = true
opt.splitbelow = true
opt.splitright = true
opt.scrolloff = 8
opt.signcolumn = "yes"
opt.updatetime = 250
opt.timeoutlen = 300
opt.undofile = true
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = false
opt.incsearch = true
opt.clipboard = "unnamedplus"
opt.mouse = "a"
opt.cursorline = true
opt.completeopt = { "menu", "menuone", "noselect" }

-- Auto-save: write buffers on common events (insert leave, text change, focus lost, buf leave)
local autosave_group = vim.api.nvim_create_augroup("AutoSave", { clear = true })
vim.api.nvim_create_autocmd({ "InsertLeave", "TextChanged", "TextChangedI", "FocusLost", "BufLeave" }, {
  group = autosave_group,
  pattern = "*",
  callback = function()
    local bufnr = vim.api.nvim_get_current_buf()
    local name = vim.api.nvim_buf_get_name(bufnr)
    if name == "" then return end
    local buftype = vim.api.nvim_buf_get_option(bufnr, "buftype")
    if buftype ~= "" then return end
    local modified = vim.api.nvim_buf_get_option(bufnr, "modified")
    if not modified then return end
    pcall(vim.api.nvim_buf_call, bufnr, function() vim.cmd("silent! write") end)
  end,
})

