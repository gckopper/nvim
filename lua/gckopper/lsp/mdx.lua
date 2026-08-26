return function (vim)
    vim.filetype.add({extension={mdx="mdx"}})
    vim.lsp.enable('mdx_analyzer')
end
