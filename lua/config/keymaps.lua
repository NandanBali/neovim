local map = vim.keymap.set

-- Window navigation
map("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Move to bottom window" })
map("n", "<C-k>", "<C-w>k", { desc = "Move to top window" })
map("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

-- Resize windows
map("n", "<C-Up>", ":resize -2<CR>", { silent = true, desc = "Decrease window height" })
map("n", "<C-Down>", ":resize +2<CR>", { silent = true, desc = "Increase window height" })
map("n", "<C-Left>", ":vertical resize -2<CR>", { silent = true, desc = "Decrease window width" })
map("n", "<C-Right>", ":vertical resize +2<CR>", { silent = true, desc = "Increase window width" })

-- Move lines in visual mode
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Stay in indent mode
map("v", "<", "<gv", { desc = "Outdent selection" })
map("v", ">", ">gv", { desc = "Indent selection" })

-- Save / quit
map("n", "<C-s>", ":w<CR>", { silent = true, desc = "Save file" })
map("n", "<leader>q", ":q<CR>", { desc = "Quit" })

-- Clear search highlights
map("n", "<Esc>", ":noh<CR>", { silent = true, desc = "Clear highlights" })

-- Better paste (keep register on visual paste)
map("v", "p", '"_dP', { desc = "Paste without yanking" })
