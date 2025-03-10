return {
    { 'j-hui/fidget.nvim', opts = {} },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 
            'nvim-tree/nvim-web-devicons',
            -- 'nvim-lua/lsp-status.nvim'
        },
        config = function()
            require("lualine").setup({
                extensions = {
                    { 
                        filetypes = {"neo-tree"}, 
                        sections = {} 
                    },
                },
            })
        end
    },
    {
        "folke/trouble.nvim",
        opts = {}, -- for default options, refer to the configuration section for custom setup.
        cmd = "Trouble",
        keys = require("mappings").diagnostics,
    }
}
