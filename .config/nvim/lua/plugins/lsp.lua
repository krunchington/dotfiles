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
            local border = {
                { '╭', 'FloatBorder' },
                { '─', 'FloatBorder' },
                { '╮', 'FloatBorder' },
                { '│', 'FloatBorder' },
                { '╯', 'FloatBorder' },
                { '─', 'FloatBorder' },
                { '╰', 'FloatBorder' },
                { '│', 'FloatBorder' },
            }

            local handlers = {
                ['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {border=border}),
                ['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, {border=border}),
            }

            vim.diagnostic.config({
                float = {border = border},
            })
            require('lspconfig').rust_analyzer.setup({
                capabilities = capabilities,
                handlers = handlers,
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
    },
    {
        "vxpm/rust-expand-macro.nvim",
        config = function()

            vim.keymap.set('n', '<leader>em', require('rust-expand-macro').expand_macro, { desc = 'Rust [E]xpand [M]acro'})
        end
    },
}
