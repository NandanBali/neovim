local keymap = vim.keymap

keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode" })

keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })



keymap.set("n", "<leader>w", "<cmd>w<CR>", { desc = "Save file" })

keymap.set("n", "<leader>q", "<cmd>q<CR>", { desc = "Quit" })

keymap.set("n", "<leader>wq", "<cmd>wq<CR>", { desc = "Save and quit" })



-- These create new windows by splitting the current one
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split vertically" })     -- Creates vertical split (side by side)
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split horizontally" })   -- Creates horizontal split (top and bottom)
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Equal split sizes" })    -- Makes all splits equal size
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })


keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })   -- Move to window on the left
keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to bottom window" }) -- Move to window below
keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to top window" })    -- Move to window above
keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

-- navigating between tabs
keymap.set("n", "<C-Left>", "<cmd>bprevious<CR>", { desc = "Previous buffer (tab)" })
keymap.set("n", "<C-Right>", "<cmd>bnext<CR>", { desc = "Next buffer (tab)" })

keymap.set("v", "<S-Tab>", "<gv", { desc = "Indent left" })   -- Indent left and keep selection
keymap.set("v", "<Tab>", ">gv", { desc = "Indent right" })

keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move text down" }) -- Move selection down
keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move text up" })

keymap.set("n", "<leader>bn", "<cmd>bnext<CR>", { desc = "Next buffer" })      -- Go to next open file
keymap.set("n", "<leader>bp", "<cmd>bprevious<CR>", { desc = "Previous buffer" }) -- Go to previous open file
keymap.set("n", "<leader>bd", "<cmd>bdelete<CR>", { desc = "Delete buffer" })

keymap.set('n', '<leader>e', ':Neotree toggle<CR>', { noremap = true, silent = true })

keymap.set('n', '<Leader>fd', ':Telescope file_browser<CR>', { noremap = true, silent = true })
