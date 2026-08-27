vim.lsp.config('rust_analyzer',{
    settings = {
        ['rust-analyzer'] = {
            check = { command = 'clippy' },
            checkOnSave = true
        }
    }
})
vim.lsp.enable('rust_analyzer')
