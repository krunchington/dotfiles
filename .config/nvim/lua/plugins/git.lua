return {
    {
        'lewis6991/gitsigns.nvim',
        lazy = false,
        priority = 2000,
        opts = {
            current_line_blame = true,
            current_line_blame_opts = {
                virt_text_pos = 'eol',
                delay = 0,
            },
            on_attach = function(bufnr)
                local gitsigns = require 'gitsigns'

                local function map(mode, l, r, opts)
                    opts = opts or {}
                    opts.buffer = bufnr
                    vim.keymap.set(mode, l, r, opts)
                end
                map('n', '<leader>tb', gitsigns.toggle_current_line_blame, { desc = '[T]oggle git show [b]lame line' })
                map('n', '<leader>tD', gitsigns.toggle_deleted, { desc = '[T]oggle git show [D]eleted' })
            end
        }
    },
}
