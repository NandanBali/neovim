-- Neovim options configuration
-- This file sets up basic Neovim behavior and appearance

local opt = vim.opt

-- Line numbers
opt.number = true
opt.relativenumber = true

-- Tabs & indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true

-- Line wrapping
opt.wrap = false

-- Search settings
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = false

-- Appearance
opt.termguicolors = true
opt.signcolumn = "yes"
opt.cursorline = true

-- Backspace
opt.backspace = "indent,eol,start"

-- Clipboard (Windows specific)
opt.clipboard = "unnamedplus"

-- Split windows
opt.splitright = true
opt.splitbelow = true

-- File handling
opt.swapfile = false
opt.backup = false

-- Scrolling
opt.scrolloff = 8
opt.sidescrolloff = 8

-- Performance
opt.updatetime = 250
opt.timeoutlen = 300
