return {
    {
        'nvim-treesitter/nvim-treesitter',
        lazy = false,
        priority = 2000,
        build = ':TSUpdate',
        event = { "BufReadPre", "BufNewFile" },
        main = 'nvim-treesitter.configs', -- Sets main module to use for opts
        dependencies = {
            "nvim-treesitter/nvim-treesitter-textobjects",
        },
        -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
        opts = {
            ensure_installed = { 'bash', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc',
                "rust", "javascript", "jsdoc", "typescript"},
            -- Autoinstall languages that are not installed
            auto_install = false,
            highlight = {
                enable = true,
                -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
                --  If you are experiencing weird indenting issues, add the language to
                --  the list of additional_vim_regex_highlighting and disabled languages for indent.
                additional_vim_regex_highlighting = { 'ruby' },
            },
            indent = { enable = true, disable = { 'ruby' } },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<C-space>",
                    node_incremental = "<C-space>",
                    scope_incremental = false,
                    node_decremental = "<bs>",
                },
            },
        },
    },
    -- There are additional nvim-treesitter modules that you can use to interact
    -- with nvim-treesitter. You should go explore a few and see what interests you:
    --
    --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
    --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
    --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        lazy = true,
        config = function()
            require("nvim-treesitter.configs").setup({
                textobjects = {
                    select = {
                        enable = true,
                        -- Automatically jump forward to textobj, similar to targets.vim
                        lookahead = true,
                        keymaps = require("mappings").treesitter.select,
                    },
                    swap = {
                        enable = true,
                        swap_next = require("mappings").treesitter.swap.next,
                        swap_previous = require("mappings").treesitter.swap.prev,
                    },
                    move = {
                        enable = true,
                        set_jumps = true,
                        goto_next_start = require("mappings").treesitter.move.goto_next_start,
                        goto_next_end = require("mappings").treesitter.move.goto_next_end,
                        goto_previous_start = require("mappings").treesitter.move.goto_previous_start,
                        goto_previous_end = require("mappings").treesitter.move.goto_previous_end,
                    }
                },
            })
            local ts_repeat_move = require("nvim-treesitter.textobjects.repeatable_move")
            require("mappings").treesitter.repeat_move(ts_repeat_move)
        end,
    },
}

