require("lazy").setup({
    "neovim/nvim-lspconfig",
    'hrsh7th/nvim-cmp',     -- Required
    {'L3MON4D3/LuaSnip'},
    'hrsh7th/cmp-nvim-lsp', -- Required
    -- the colorscheme should be available when starting Neovim
    {
        "folke/tokyonight.nvim",
        lazy = false, -- make sure we load this during startup if it is your main colorscheme
        priority = 1000, -- make sure to load this before all the other start plugins
        config = function()
            -- load the colorscheme here
            vim.cmd([[colorscheme tokyonight]])
        end,
    },
})
