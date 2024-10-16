return {
    {
        "neovim/nvim-lspconfig",
        lazy = false,
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',
        },
        config = function()
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())
            require('lspconfig').rust_analyzer.setup({
                capabilities = capabilities,
                settings = {
                    ["rust-analyzer"] = {
                        checkOnSave = { command = "clippy" }
                    }
                }
            })
            vim.api.nvim_create_autocmd('LspAttach', {
                group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
                callback = function(event)
                    local telescope = require('telescope.builtin')
                    local client = vim.lsp.get_client_by_id(event.data.client_id)
                    require("mappings").lsp(telescope, event.buf, client)
                    require("autocmds").lsp(client, event.buf)
                end
            })
        end
    }
}
