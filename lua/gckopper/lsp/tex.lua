return function (vim)
    vim.lsp.config('texlab', {
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
                    executable = "zathura",
                    args = { "--synctex-forward", "%l:1:%f", "%p" },
                }
            }
        }
    })

    vim.lsp.enable('texlab')
end
