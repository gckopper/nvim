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

-- leave terminal mode with jk too
vim.keymap.set("t", "<ESC>", "<C-\\><C-n>")

-- Move lines up and down
vim.keymap.set("n", "<M-up>", ":m-2<cr>")
vim.keymap.set("n", "<M-down>", ":m+<cr>")
vim.keymap.set("v", "<M-Up>", ":m-2<CR>gv=gv")
vim.keymap.set("v", "<M-Down>", ":m'>+<CR>gv=gv")

local function split(direction)
    return function()
        local buf = vim.api.nvim_create_buf(false, false)
        vim.api.nvim_open_win(buf, true, {split = direction})
    end
end
-- splits with alt+wasd
vim.keymap.set({"t", "i", "n"}, "<M-w>", split("above"))
vim.keymap.set({"t", "i", "n"}, "<M-a>", split("left"))
vim.keymap.set({"t", "i", "n"}, "<M-s>", split("below"))
vim.keymap.set({"t", "i", "n"}, "<M-d>", split("right"))

-- vertical split with alt+c
vim.keymap.set("n", "<M-c>", ":tabnew<CR>")
vim.keymap.set({"t", "i"}, "<M-c>", "<C-\\><C-n>:tabnew<CR>")

-- navigate between splits with alt hjkl
vim.keymap.set({"n", "i", "t"}, "<M-j>", "<C-\\><C-n><C-w><Down>")
vim.keymap.set({"n", "i", "t"}, "<M-k>", "<C-\\><C-n><C-w><Up>")
vim.keymap.set({"n", "i", "t"}, "<M-h>", "<C-\\><C-n><C-w><Left>")
vim.keymap.set({"n", "i", "t"}, "<M-l>", "<C-\\><C-n><C-w><Right>")

-- go to terminal mode with t
vim.keymap.set("n", "<leader>t", function()
    vim.cmd('terminal')
    vim.cmd('startinsert')
end)

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

vim.api.nvim_create_autocmd({'BufEnter'}, {
    callback = function (_)
        if vim.bo.buftype == 'terminal' then
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

local function resize(width, height)
    return function ()
        local win_width = vim.api.nvim_win_get_width(0)
        vim.api.nvim_win_set_width(0, win_width + 1 * width)
        local win_height = vim.api.nvim_win_get_height(0)
        vim.api.nvim_win_set_height(0, win_height + 1 * height)
    end
end

-- resize windows
vim.keymap.set({"n", "t", "v"}, "<M-S-k>", resize(0, -1))
vim.keymap.set({"n", "t", "v"}, "<M-S-j>", resize(0, 1))
vim.keymap.set({"n", "t", "v"}, "<M-S-h>", resize(1, 0))
vim.keymap.set({"n", "t", "v"}, "<M-S-l>", resize(-1, 0))
