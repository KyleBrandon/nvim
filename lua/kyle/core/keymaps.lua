-- set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

keymap.set("n", "<leader>x", ":!chmod +x %<CR>")
-- keymap.set("n", "<C-f>", ":silent !tmux neww tmux-sessionizer<CR>")
keymap.set("n", "<leader>r", ":redo<CR>")

-- append next line and keep cursor position
keymap.set("n", "J", "mzJ`z")

-- key cursor posltion centered 1/2 page jumping
keymap.set("n", "<C-d>", "<C-d>zz")
keymap.set("n", "<C-u>", "<C-u>zz")

-- keep cursor position centered when searching
keymap.set("n", "n", "nzzzv")
keymap.set("n", "N", "Nzzzv")

-- preserve registeer when copying over text
keymap.set("x", "<leader>p", [["_dP]])

-- System clipboard yanking
keymap.set({ "n", "v" }, "<leader>y", [["+y]])
keymap.set("n", "<leadaer>Y", [["+Y]])

-- format buffer
keymap.set("n", "<leader>f", vim.lsp.buf.format)

-- clear search highlights
keymap.set("n", "<leader>nn", ":nohl<CR>")

-- window management
keymap.set("n", "<leader>sv", "<C-w>v") -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s") -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=") -- make split windows equal width & height
keymap.set("n", "<leader>sx", ":close<CR>") -- close current split window
keymap.set("n", "<leader>so", ":only<CR>") -- close all split windows except current

keymap.set("n", "<leader>to", ":tabnew<CR>") -- open new tab
keymap.set("n", "<leader>tx", ":tabclose<CR>") -- close current tab
keymap.set("n", "<leader>tn", ":tabn<CR>") --  go to next tab
keymap.set("n", "<leader>tp", ":tabp<CR>") --  go to previous tab

-- buffer management
keymap.set("n", "<leader><leader>", "<C-^>") -- switch between last two buffers

-- setup git support with vim-fugitive
-- keymap.set("n", "<leader>gs", vim.cmd.Git)

-- setup undo tree
-- keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)

-- Add * and # support to search for current selection
-- keymap.set("x", "*", "<C-u>call <SID>v_set_search()<CR>/<C-R>=@/<CR><CR>")
-- keymap.set("x", "#", "<C-u>call <SID>v_set_search()<CR>?<C-R>=@/<CR><CR>")

-- local v_set_search = function()
-- 	local temp = vim.fn.getreg("s") -- save search register
-- 	vim.cmd.normal('gv"sy') -- reselect last visual selection
-- 	vim.fn.setreg("/", "\\V" .. vim.fn.substitue(vim.fn.escape(temp, "/\\"), "\\n", "\\\\n", "g"))
-- 	vim.fn.setreg("s", temp) -- save search register
-- end
