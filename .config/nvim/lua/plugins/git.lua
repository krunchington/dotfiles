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
                require("mappings").gitsigns(gitsigns, bufnr)
            end
        }
    },
}
