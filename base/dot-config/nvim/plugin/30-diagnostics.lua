vim.pack.add({
    'https://github.com/j-hui/fidget.nvim', 
    'https://github.com/nvim-lualine/lualine.nvim',
    'https://github.com/folke/trouble.nvim'
})

require('lualine').setup({
    extensions = {
        {
            filetypes = {'neo-tree'},
            sections = {}
        }
    }
})
local trouble = require('trouble')
vim.keymap.set('n', '<leader>xx', function()
    trouble.toggle('diagnostics')
end, {desc = "Diagnostics (Trouble)"});
vim.keymap.set('n', '<leader>xX', function() 
    trouble.filter({buf = 0})
    trouble.toggle('diagnostics') 
end, {desc = "Buffer Diagnostics (Trouble)"});

-- require('trouble').setup({
--     keys = {
--         {
--             "<leader>xx",
--             "<cmd>Trouble diagnostics toggle<cr>",
--             desc = "Diagnostics (Trouble)",
--         },
--         {
--             "<leader>xX",
--             "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
--             desc = "Buffer Diagnostics (Trouble)",
--         },
--         {
--             "<leader>cs",
--             "<cmd>Trouble symbols toggle focus=false<cr>",
--             desc = "Symbols (Trouble)",
--         },
--         {
--             "<leader>cl",
--             "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
--             desc = "LSP Definitions / references / ... (Trouble)",
--         },
--         {
--             "<leader>xL",
--             "<cmd>Trouble loclist toggle<cr>",
--             desc = "Location List (Trouble)",
--         },
--         {
--             "<leader>xQ",
--             "<cmd>Trouble qflist toggle<cr>",
--             desc = "Quickfix List (Trouble)",
--         },
--     }
-- })
