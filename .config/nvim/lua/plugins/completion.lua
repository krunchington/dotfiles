return {
    {
        'hrsh7th/nvim-cmp',
        event = 'InsertEnter',
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-path',
        },
        config = function()
            -- See `:help cmp`
            local cmp = require 'cmp'
            cmp.setup {
                completion = { 
                    autocomplete = false,
                    completeopt = 'menu,menuone,noinsert' 
                },
                -- :help ins-completion
                mapping = cmp.mapping.preset.insert {
                    ['<C-n>'] = cmp.mapping.select_next_item(),
                    ['<C-p>'] = cmp.mapping.select_prev_item(),
                    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    --  This will auto-import if your LSP supports it.
                    --  This will expand snippets if the LSP sent a snippet.
                    ['<C-y>'] = cmp.mapping.confirm { select = true },
                    ['<C-Space>'] = cmp.mapping.complete {},
                },
                sources = {
                    { name = 'nvim_lsp' },
                    { name = 'path' },
                },
            }
        end,
    },
}
