return {
    {
        "nvim-telescope/telescope.nvim",

        tag = "0.1.8",

        dependencies = {
            "nvim-lua/plenary.nvim",
            { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
        },

        config = function()
            require('telescope').setup({})

            local telescope = require('telescope.builtin')
            require("mappings").telescope(telescope)
        end
    },
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
            -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
        },
        config = function()
            require("neo-tree").setup({})
            require("mappings").neotree()
        end
    },
}
