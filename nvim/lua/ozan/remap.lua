
-- enter in normal mode to insert a new line after the current line
vim.keymap.set("n", "<CR>", "o<Esc>")

-- select line(s) and move them around
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- close the current buffer
vim.keymap.set("n", ":bd", ":bp <BAR> bd #<CR>")

-- move between buffers
vim.keymap.set("n", "<S-H>", ":bp<CR>")
vim.keymap.set("n", "<S-L>", ":bn<CR>")

-- replace word under cursor
vim.keymap.set("n", "<leader>r", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>")

-- "move half page up/down" to stay in the middle of the page
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- "search up/down" to stay in the middle of the page
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- paste without modifying the yanked value
vim.keymap.set("n", "<leader>p", "\"+y")
