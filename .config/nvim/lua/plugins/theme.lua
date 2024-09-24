return {
    {
        "scottmckendry/cyberdream.nvim",
        lazy = false,
        priority = 1000,
        opts = {
            transparent = true,
        },
        init = function()
            vim.cmd.colorscheme 'cyberdream'
        end
    }
}
