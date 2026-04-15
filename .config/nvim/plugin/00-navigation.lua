vim.pack.add({
    -- dependencies
    "https://github.com/nvim-lua/plenary.nvim",
    "https://github.com/MunifTanjim/nui.nvim",
    -- optional, but recommended
    "https://github.com/nvim-tree/nvim-web-devicons",

    -- file tree
    {
        src = 'https://github.com/nvim-neo-tree/neo-tree.nvim',
        version = vim.version.range('3')
    },
    -- fuzzy finder
    {
        src = 'https://github.com/nvim-telescope/telescope.nvim',
        version = vim.version.range('0.2')
    },
})

require('neo-tree').setup({
    window = {
        mappings = {
            ["Z"] = "expand_all_nodes",
        }
    }
})
vim.keymap.set('n', '\\', '<cmd>Neotree toggle<cr>')

local telescope = require("telescope.builtin")
vim.keymap.set('n', '<leader>ff', telescope.git_files, {})
vim.keymap.set('n', '<leader>fg', telescope.live_grep, {})
vim.keymap.set('n', '<leader>fb', telescope.buffers, {})
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
