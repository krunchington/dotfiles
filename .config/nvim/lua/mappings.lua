vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

local api = {}

api.autoformat = {
    {
        '<leader>f',
        function()
            require('conform').format { async = true, lsp_format = 'fallback' }
        end,
        mode = '',
        desc = '[F]ormat buffer',
    },
}

api.lsp = function(telescope, buffer, client)
    local map = function(keys, func, desc, mode)
        mode = mode or 'n'
        vim.keymap.set(mode, keys, func, { buffer = buffer, desc = 'LSP: ' .. desc })
    end
    map('gd', telescope.lsp_definitions, '[G]oto [D]efinition')
    map('gr', telescope.lsp_references, '[G]oto [R]eferences')
    map('gI', telescope.lsp_implementations, '[G]oto [I]mplementation')
    map('<leader>D', telescope.lsp_type_definitions, 'Type [D]efinition')
    map('<leader>ds', telescope.lsp_document_symbols, '[D]ocument [S]ymbols')
    map('<leader>ws', telescope.lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
    map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
    map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction', { 'n', 'x' })
    map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
    if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
        map('<leader>th', function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
        end, '[T]oggle Inlay [H]ints')
    end
end

api.cmp = function(cmd)
    return {
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        --  This will auto-import if your LSP supports it.
        --  This will expand snippets if the LSP sent a snippet.
        ['<C-y>'] = cmp.mapping.confirm { select = true },
        ['<C-Space>'] = cmp.mapping.complete {},
    }
end

api.diagnostics = {
    {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
    },
    {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
    },
    {
        "<leader>cs",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
    },
    {
        "<leader>cl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
    },
    {
        "<leader>xL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
    },
    {
        "<leader>xQ",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
    },
}

api.gitsigns = function(gitsigns, buffer)
    local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = buffer
        vim.keymap.set(mode, l, r, opts)
    end
    map('n', '<leader>tb', gitsigns.toggle_current_line_blame, { desc = '[T]oggle git show [b]lame line' })
    map('n', '<leader>tD', gitsigns.toggle_deleted, { desc = '[T]oggle git show [D]eleted' })
end

api.telescope = function(telescope)
    vim.keymap.set('n', '<leader>ff', telescope.find_files, {})
    vim.keymap.set('n', '<leader>fg', telescope.git_files, {})
    vim.keymap.set('n', '<leader>fw', function()
        local word = vim.fn.expand("<cword>")
        telescope.grep_string({ search = word })
    end)
    vim.keymap.set('n', '<leader>fW', function()
        local word = vim.fn.expand("<cWORD>")
        telescope.grep_string({ search = word })
    end)
    vim.keymap.set('n', '<leader>fs', function()
        telescope.grep_string({ search = vim.fn.input("Grep > ") })
    end)
    vim.keymap.set('n', '<leader>fh', telescope.help_tags, {})
end

return api
