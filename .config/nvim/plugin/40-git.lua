vim.pack.add({'https://github.com/lewis6991/gitsigns.nvim'})
local gitsigns = require('gitsigns')
gitsigns.setup({
    current_line_blame = true,
    current_line_blame_opts = {
        virt_text_pos = 'eol',
        delay = 0,
    },
    on_attach = function(bufnr)
        local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = buffer
            vim.keymap.set(mode, l, r, opts)
        end
        map('n', ']c', function()
            if vim.wo.diff then
                vim.cmd.normal { ']c', bang = true }
            else
                gitsigns.nav_hunk 'next'
            end
        end, { desc = 'Jump to next git [c]hange' })

        map('n', '[c', function()
            if vim.wo.diff then
                vim.cmd.normal { '[c', bang = true }
            else
                gitsigns.nav_hunk 'prev'
            end
        end, { desc = 'Jump to previous git [c]hange' })
        map('v', '<leader>hr', function()
            gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, { desc = 'git [r]eset hunk' })
        map('n', '<leader>hr', gitsigns.reset_hunk, { desc = 'git [r]eset hunk' })
        map('n', '<leader>tb', gitsigns.toggle_current_line_blame, { desc = '[T]oggle git show [b]lame line' })
        map('n', '<leader>tD', gitsigns.toggle_deleted, { desc = '[T]oggle git show [D]eleted' })
        map('n', '<leader>hd', gitsigns.diffthis, { desc = 'git [d]iff against index' })
    end
})
