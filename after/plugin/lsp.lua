local lspconfig = require('lspconfig')

local lsp_defaults = lspconfig.util.default_config

lsp_defaults.capabilities = vim.tbl_deep_extend(
    'force',
    lsp_defaults.capabilities,
    require('cmp_nvim_lsp').default_capabilities()
)

lspconfig['lua_ls'].setup({
    single_file_support = true,
    capabilities = lsp_defaults.capabilities,
})
lspconfig['pyright'].setup({
    capabilities = lsp_defaults.capabilities,
})
lspconfig['cssls'].setup({
    capabilities = lsp_defaults.capabilities,
})
lspconfig['html'].setup({
    capabilities = lsp_defaults.capabilities,
})
lspconfig['gopls'].setup({
    capabilities = lsp_defaults.capabilities,
})
lspconfig['clangd'].setup({
    capabilities = lsp_defaults.capabilities,
})
lspconfig['rust_analyzer'].setup({
    capabilities = lsp_defaults.capabilities,
})

lspconfig['texlab'].setup({
    capabilities = lsp_defaults.capabilities,
    settings = {
        texlab = {
            auxDirectory = ".aux",
            bibtexFormatter = "texlab",
            build = {
                args = { "-X", "compile", "%f", "--synctex", "--keep-logs", "--keep-intermediates", "-o", "./.aux" },
                executable = "tectonic",
                forwardSearchAfter = true,
                onSave = true
            },
            chktex = {
                onEdit = false,
                onOpenAndSave = false
            },
            diagnosticsDelay = 300,
            formatterLineLength = 80,
            latexFormatter = "latexindent",
            latexindent = {
                modifyLineBreaks = false
            },
            forwardSearch = {
                executable = "okular",
                args = {"--unique","file:%p#src:%l%f"},
            }
        }
    }
})

vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }

require('luasnip.loaders.from_vscode').lazy_load()

local cmp = require('cmp')
local luasnip = require('luasnip')

local select_opts = { behavior = cmp.SelectBehavior.Select }

cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end
    },
    sources = {
        { name = 'path' },
        { name = 'nvim_lsp', keyword_length = 1 },
        { name = 'buffer',   keyword_length = 3 },
        { name = 'luasnip',  keyword_length = 2 },
    },
    window = {
        documentation = cmp.config.window.bordered()
    },
    mapping = {
        ['<Up>'] = cmp.mapping.select_prev_item(select_opts),
        ['<Down>'] = cmp.mapping.select_next_item(select_opts),
        ['<C-n>'] = cmp.mapping.select_next_item(select_opts),

        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
        ['<C-d>'] = cmp.mapping.scroll_docs(4),

        ['<C-e>'] = cmp.mapping.abort(),
        ['<C-y>'] = cmp.mapping.confirm({ select = true }),
        ['<CR>'] = cmp.mapping.confirm({ select = false }),

        ['<C-f>'] = cmp.mapping(function(fallback)
            if luasnip.jumpable(1) then
                luasnip.jump(1)
            else
                fallback()
            end
        end, { 'i', 's' }),

        ['<C-b>'] = cmp.mapping(function(fallback)
            if luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { 'i', 's' }),

        ['<Tab>'] = cmp.mapping(function(fallback)
            local col = vim.fn.col('.') - 1

            if cmp.visible() then
                cmp.select_next_item(select_opts)
            elseif col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
                fallback()
            else
                cmp.complete()
            end
        end, { 'i', 's' }),

        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item(select_opts)
            else
                fallback()
            end
        end, { 'i', 's' }),
    },
})
