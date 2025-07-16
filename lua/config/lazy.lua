-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy with plugins
require("lazy").setup({
  { import = "plugins" },
}, {
  defaults = {
    lazy = false, -- should plugins be lazy-loaded?
  },
  install = {
    colorscheme = { "habamax" }, -- try to load this colorscheme when starting an installation during startup
  },
  checker = {
    enabled = true,
    notify = false,
  },
  change_detection = {
    notify = false,
  },
})
