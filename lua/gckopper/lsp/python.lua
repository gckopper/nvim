return function(vim)
    vim.lsp.config('ruff', {
        cmd = { 'uv', 'run', 'ruff', 'server' },
        filetypes = { 'python' },
        root_markers = { 'pyproject.toml', 'ruff.toml', '.ruff.toml', '.git' },
    })

    vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup('lsp_attach_disable_ruff_hover', { clear = true }),
        callback = function(args)
            local client = vim.lsp.get_client_by_id(args.data.client_id)
            if client == nil then
                return
            end
            if client.name == 'ruff' then
                client.server_capabilities.hoverProvider = false
                -- lazily defines the remap so that we can filter
                -- for ruff's client id and avoid conflicts with
                -- pyright
                vim.keymap.set("n", "<leader>vi", function()
                    vim.lsp.buf.code_action({
                        apply = true,
                        filter = function(action, id)
                            if client.id ~= id then
                                return false
                            end
                            return action.kind == 'source.organizeImports.ruff'
                        end
                    })
                end)
            end
        end,
        desc = 'LSP: Disable hover capability from Ruff',
    })

    vim.lsp.enable('ruff')

    vim.lsp.config('pyright', {
        cmd = { 'uv', 'run', 'pyright-langserver', '--stdio' },
        settings = {
            pyright = {
                -- Using Ruff's import organizer
                disableOrganizeImports = true,
            },
        },
    })

    vim.lsp.enable('pyright')
end
