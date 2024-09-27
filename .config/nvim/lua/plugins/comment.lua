return {
    {
        'numToStr/Comment.nvim',
        opts = {},
        lazy=false,
        init = function()
            -- :h comment.config to see defaults, including keybindings
            require("Comment").setup()
        end
    }
}
