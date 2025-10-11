vim.g.mapleader = " "
vim.keymap.set("n", "<leader>e", vim.cmd.Ex)

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({"n", "v"}, "<leader>d", [["_d]])

vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)
vim.keymap.set("i", "jk", "<ESC>")

vim.keymap.set("n", "gd", vim.lsp.buf.definition)
vim.keymap.set("n", "K", vim.lsp.buf.hover)
vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol)
vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float)
vim.keymap.set("n", "<leader>dn", vim.diagnostic.goto_next)
vim.keymap.set("n", "<leader>dp", vim.diagnostic.goto_prev)
vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action)
vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references)
vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename)
vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help)

-- horizontal split with "
vim.keymap.set("n", "<leader>\"", ":new<CR>")
-- vertical split with %
vim.keymap.set("n", "<leader>%", ":vnew<CR>")
-- new tab with c (tmux like)
vim.keymap.set("n", "<leader>c", ":tabnew<CR>")
-- navigate between splits with alt hjkl
vim.keymap.set("n", "<A-j>", "<C-w><Down>")
vim.keymap.set("n", "<A-k>", "<C-w><Up>")
vim.keymap.set("n", "<A-h>", "<C-w><Left>")
vim.keymap.set("n", "<A-l>", "<C-w><Right>")
-- go to terminal mode with t
vim.keymap.set("n", "<leader>t", ":terminal<CR>")

-- set current tab with alt n
vim.keymap.set("n", "<A-1>", ":tabn 1<CR>")
vim.keymap.set("n", "<A-2>", ":tabn 2<CR>")
vim.keymap.set("n", "<A-3>", ":tabn 3<CR>")
vim.keymap.set("n", "<A-4>", ":tabn 4<CR>")
vim.keymap.set("n", "<A-5>", ":tabn 5<CR>")
vim.keymap.set("n", "<A-6>", ":tabn 6<CR>")
vim.keymap.set("n", "<A-7>", ":tabn 7<CR>")
vim.keymap.set("n", "<A-8>", ":tabn 8<CR>")
vim.keymap.set("n", "<A-9>", ":tabn 9<CR>")

-- leave terminal mode with jk too
vim.keymap.set("t", "jk", "<C-\\><C-n>")

-- Move lines up and down
vim.keymap.set("n", "<A-Up>", ":m-2<CR>")
vim.keymap.set("n", "<A-Down>", ":m+<CR>")
vim.keymap.set("v", "<A-Up>", ":m-2<CR>gv=gv")
vim.keymap.set("v", "<A-Down>", ":m'>+<CR>gv=gv")
