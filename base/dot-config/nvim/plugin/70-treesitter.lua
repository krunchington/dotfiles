vim.pack.add({
    { src='https://github.com/nvim-treesitter/nvim-treesitter', version='main' },
    'https://github.com/nvim-treesitter/nvim-treesitter-textobjects'
})

require('nvim-treesitter').setup()
require('nvim-treesitter').install({
    'bash', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc',
    "rust", "javascript", "jsdoc", "typescript", "html"
})

require("nvim-treesitter-textobjects").setup({
    select = {
        enable = true,
        -- Automatically jump forward to textobj, similar to targets.vim
        lookahead = true,
    },
    swap = {
        enable = true,
    },
    move = {
        enable = true,
        set_jumps = true,
    }
})

local select = require('nvim-treesitter-textobjects.select')
local queries = {
    { mapping = "a=", query = "@assignment.outer", desc = "Select outer part of an assignment" },
    { mapping = "i=", query = "@assignment.inner", desc = "Select inner part of an assignment" },
    { mapping = "l=", query = "@assignment.lhs", desc = "Select left hand side of an assignment" },
    { mapping = "r=", query = "@assignment.rhs", desc = "Select right hand side of an assignment" },

    { mapping = "aa", query = "@parameter.outer", desc = "Select outer part of a parameter/argument" },
    { mapping = "ia", query = "@parameter.inner", desc = "Select inner part of a parameter/argument" },

    { mapping = "ai", query = "@conditional.outer", desc = "Select outer part of a conditional" },
    { mapping = "ii", query = "@conditional.inner", desc = "Select inner part of a conditional" },

    { mapping = "al", query = "@loop.outer", desc = "Select outer part of a loop" },
    { mapping = "il", query = "@loop.inner", desc = "Select inner part of a loop" },

    { mapping = "af", query = "@call.outer", desc = "Select outer part of a function call" },
    { mapping = "if", query = "@call.inner", desc = "Select inner part of a function call" },

    { mapping = "am", query = "@function.outer", desc = "Select outer part of a method/function definition" },
    { mapping = "im", query = "@function.inner", desc = "Select inner part of a method/function definition" },

    { mapping = "ac", query = "@class.outer", desc = "Select outer part of a class" },
    { mapping = "ic", query = "@class.inner", desc = "Select inner part of a class" },
}

for _,q in pairs(queries) do
    vim.keymap.set({'x','o'}, q.mapping, function() 
        select.select_textobject(q.query, 'textobjects')
    end, {desc = q.desc})
end

local swap = require('nvim-treesitter-textobjects.swap')
vim.keymap.set('n', '<leader>na', function()
    swap.swap_next('@parameter.inner')
end, { desc = 'swap with next parameter' })
vim.keymap.set('n', '<leader>nm', function()
    swap.swap_next('@function.outer')
end, { desc = 'swap with next function' })
vim.keymap.set('n', '<leader>pa', function()
    swap.swap_previous('@parameter.inner')
end, { desc = 'swap with previous parameter' })
vim.keymap.set('n', '<leader>pm', function()
    swap.swap_previous('@function.outer')
end, { desc = 'swap with previous function' })

local move_mappings = {
    goto_next_start = {
        ["]f"] = { query = "@call.outer", desc = "Next function call start" },
        ["]m"] = { query = "@function.outer", desc = "Next method/function def start" },
        ["]c"] = { query = "@class.outer", desc = "Next class start" },
        ["]i"] = { query = "@conditional.outer", desc = "Next conditional start" },
        ["]l"] = { query = "@loop.outer", desc = "Next loop start" },

        -- You can pass a query group to use query from `queries/<lang>/<query_group>.scm file in your runtime path.
        -- Below example nvim-treesitter's `locals.scm` and `folds.scm`. They also provide highlights.scm and indent.scm.
        ["]s"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
        ["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
    },
    goto_next_end = {
        ["]F"] = { query = "@call.outer", desc = "Next function call end" },
        ["]M"] = { query = "@function.outer", desc = "Next method/function def end" },
        ["]C"] = { query = "@class.outer", desc = "Next class end" },
        ["]I"] = { query = "@conditional.outer", desc = "Next conditional end" },
        ["]L"] = { query = "@loop.outer", desc = "Next loop end" },
    },
    goto_previous_start = {
        ["[f"] = { query = "@call.outer", desc = "Prev function call start" },
        ["[m"] = { query = "@function.outer", desc = "Prev method/function def start" },
        ["[c"] = { query = "@class.outer", desc = "Prev class start" },
        ["[i"] = { query = "@conditional.outer", desc = "Prev conditional start" },
        ["[l"] = { query = "@loop.outer", desc = "Prev loop start" },
    },
    goto_previous_end = {
        ["[F"] = { query = "@call.outer", desc = "Prev function call end" },
        ["[M"] = { query = "@function.outer", desc = "Prev method/function def end" },
        ["[C"] = { query = "@class.outer", desc = "Prev class end" },
        ["[I"] = { query = "@conditional.outer", desc = "Prev conditional end" },
        ["[L"] = { query = "@loop.outer", desc = "Prev loop end" },
    },
}

local move = require('nvim-treesitter-textobjects.move')
for k,q in pairs(move_mappings.goto_next_start) do
    vim.keymap.set({'x','n','o'}, k, function()
        move.goto_next_start(q.query, 'textobjects')
    end, {desc=q.desc})
end
for k,q in pairs(move_mappings.goto_next_end) do
    vim.keymap.set({'x','n','o'}, k, function()
        move.goto_next_end(q.query, 'textobjects')
    end, {desc=q.desc})
end
for k,q in pairs(move_mappings.goto_previous_start) do
    vim.keymap.set({'x','n','o'}, k, function()
        move.goto_previous_start(q.query, 'textobjects')
    end, {desc=q.desc})
end
for k,q in pairs(move_mappings.goto_previous_end) do
    vim.keymap.set({'x','n','o'}, k, function()
        move.goto_previous_end(q.query, 'textobjects')
    end, {desc=q.desc})
end

local ts_repeat_move = require "nvim-treesitter-textobjects.repeatable_move"
vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)
vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f_expr, { expr = true })
vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F_expr, { expr = true })
vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t_expr, { expr = true })
vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T_expr, { expr = true })
