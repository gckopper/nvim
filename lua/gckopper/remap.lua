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
vim.keymap.set("n", "<leader>dn", function ()
    vim.diagnostic.jump({count = 1, float = true})
end)
vim.keymap.set("n", "<leader>dp", function ()
    vim.diagnostic.jump({count = -1, float = true})
end)
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
vim.keymap.set({"n", "i", "t"}, "<A-j>", "<C-\\><C-n><C-w><Down>")
vim.keymap.set({"n", "i", "t"}, "<A-k>", "<C-\\><C-n><C-w><Up>")
vim.keymap.set({"n", "i", "t"}, "<A-h>", "<C-\\><C-n><C-w><Left>")
vim.keymap.set({"n", "i", "t"}, "<A-l>", "<C-\\><C-n><C-w><Right>")
-- go to terminal mode with t
vim.keymap.set("n", "<leader>t", ":terminal<CR>")

-- set current tab with alt n
vim.keymap.set({"n", "i", "t"}, "<A-1>", "<C-\\><C-n>:tabn 1<CR>")
vim.keymap.set({"n", "i", "t"}, "<A-2>", "<C-\\><C-n>:tabn 2<CR>")
vim.keymap.set({"n", "i", "t"}, "<A-3>", "<C-\\><C-n>:tabn 3<CR>")
vim.keymap.set({"n", "i", "t"}, "<A-4>", "<C-\\><C-n>:tabn 4<CR>")
vim.keymap.set({"n", "i", "t"}, "<A-5>", "<C-\\><C-n>:tabn 5<CR>")
vim.keymap.set({"n", "i", "t"}, "<A-6>", "<C-\\><C-n>:tabn 6<CR>")
vim.keymap.set({"n", "i", "t"}, "<A-7>", "<C-\\><C-n>:tabn 7<CR>")
vim.keymap.set({"n", "i", "t"}, "<A-8>", "<C-\\><C-n>:tabn 8<CR>")
vim.keymap.set({"n", "i", "t"}, "<A-9>", "<C-\\><C-n>:tabn 9<CR>")

-- leave terminal mode with jk too
vim.keymap.set("t", "<ESC>", "<C-\\><C-n>")

-- Move lines up and down
vim.keymap.set("n", "<A-Up>", ":m-2<CR>")
vim.keymap.set("n", "<A-Down>", ":m+<CR>")
vim.keymap.set("v", "<A-Up>", ":m-2<CR>gv=gv")
vim.keymap.set("v", "<A-Down>", ":m'>+<CR>gv=gv")
