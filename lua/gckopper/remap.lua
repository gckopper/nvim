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
vim.keymap.set({"n", "i", "t"}, "<M-j>", "<C-\\><C-n><C-w><Down>")
vim.keymap.set({"n", "i", "t"}, "<M-k>", "<C-\\><C-n><C-w><Up>")
vim.keymap.set({"n", "i", "t"}, "<M-h>", "<C-\\><C-n><C-w><Left>")
vim.keymap.set({"n", "i", "t"}, "<M-l>", "<C-\\><C-n><C-w><Right>")
-- go to terminal mode with t
vim.keymap.set("n", "<leader>t", ":terminal<CR>")

-- set current tab with alt n
for i = 1, 9 do
    local key_combo = string.format("<M-%d>", i)
    vim.keymap.set({"n", "i", "t"}, key_combo, function ()
        local tabs = vim.api.nvim_list_tabpages()
        if #tabs >= i then
            vim.api.nvim_set_current_tabpage(tabs[i])
        end
    end)
end

vim.api.nvim_create_autocmd({'WinEnter'}, {
    callback = function (_)
        if vim.api.nvim_get_mode()['mode'] == 'nt' then
            vim.cmd('startinsert')
        end
    end
})

-- move tabs
for i = 1, 9 do
    local key_combo = string.format("<M-S-%d>", i)
    vim.keymap.set({"n", "i", "t"}, key_combo, function ()
        local is_before = vim.api.nvim_tabpage_get_number(0) > i and 1 or 0
        vim.cmd(string.format("tabm %d", i - is_before))
    end)
end

-- leave terminal mode with jk too
vim.keymap.set("t", "<ESC>", "<C-\\><C-n>")

-- Move lines up and down
vim.keymap.set("n", "<A-Up>", ":m-2<CR>")
vim.keymap.set("n", "<A-Down>", ":m+<CR>")
vim.keymap.set("v", "<A-Up>", ":m-2<CR>gv=gv")
vim.keymap.set("v", "<A-Down>", ":m'>+<CR>gv=gv")
