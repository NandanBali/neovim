local opt = vim.opt

-- UI
opt.number = true
opt.relativenumber = true
opt.signcolumn = "yes"
opt.cursorline = true
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.termguicolors = true
opt.showmode = false
opt.laststatus = 3          -- global statusline
opt.splitbelow = true
opt.splitright = true
opt.colorcolumn = "100"

-- Editing
opt.expandtab = true
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.smartindent = true
opt.wrap = false
opt.linebreak = true

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true

-- Completion
opt.completeopt = { "menu", "menuone", "noselect" }
opt.pumheight = 10

-- Files
opt.undofile = true
opt.undolevels = 10000
opt.backup = false
opt.swapfile = false
opt.updatetime = 200
opt.timeoutlen = 300

-- Folding — nvim-ufo manages the actual folding logic;
-- these settings are required for it to work.
opt.foldcolumn = "1"
opt.foldlevel = 99          -- start with all folds open
opt.foldlevelstart = 99
opt.foldenable = true

-- Clipboard
opt.clipboard = "unnamedplus"

-- Misc
opt.mouse = "a"
opt.virtualedit = "block"
opt.inccommand = "split"
opt.confirm = true
opt.formatoptions = "jcroqlnt"
opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep"
