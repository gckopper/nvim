return function (vim)
    vim.api.nvim_create_user_command("Ltex", function(opts)
        vim.lsp.config('ltex', {
            settings = {
                ltex = {
                    language = opts.args,
                    enabled = { "bibtex", "markdown", "tex", "restructuredtext", "latex", "html", "xhtml", "yaml", "toml" }
                },
            },
            filetypes = { "bib", "gitcommit", "markdown", "org", "plaintex", "rst", "rnoweb", "tex", "pandoc", "quarto", "rmd", "context", "html", "xhtml", "mail", "toml", "yaml", "javascript", "javascriptreact", "typescript", "typescriptreact" }
        })
        vim.lsp.enable('ltex')
    end, { desc = "Start ltex for a given language", nargs = 1 })
end
