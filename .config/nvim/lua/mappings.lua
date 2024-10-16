vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("x", "<leader>p", [["_dP]])
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])
vim.keymap.set({"n", "v"}, "<leader>d", [["_d]])

vim.keymap.set("n", "<up>", "<nop>")
vim.keymap.set("n", "<down>", "<nop>")
vim.keymap.set("n", "<left>", "<nop>")
vim.keymap.set("n", "<right>", "<nop>")

vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

local api = {}

api.autoformat = {
    {
        '<leader>f',
        function()
            require('conform').format { async = true, lsp_format = 'fallback' }
        end,
        mode = '',
        desc = '[F]ormat buffer',
    },
}

api.lsp = function(telescope, buffer, client)
    local map = function(keys, func, desc, mode)
        mode = mode or 'n'
        vim.keymap.set(mode, keys, func, { buffer = buffer, desc = 'LSP: ' .. desc })
    end
    map('gd', telescope.lsp_definitions, '[G]oto [D]efinition')
    map('gr', telescope.lsp_references, '[G]oto [R]eferences')
    map('gI', telescope.lsp_implementations, '[G]oto [I]mplementation')
    map('<leader>D', telescope.lsp_type_definitions, 'Type [D]efinition')
    map('<leader>ds', telescope.lsp_document_symbols, '[D]ocument [S]ymbols')
    map('<leader>ws', telescope.lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
    map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
    map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction', { 'n', 'x' })
    map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
    if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
        map('<leader>th', function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
        end, '[T]oggle Inlay [H]ints')
    end
end

api.cmp = function(cmp)
    return {
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        --  This will auto-import if your LSP supports it.
        --  This will expand snippets if the LSP sent a snippet.
        ['<C-y>'] = cmp.mapping.confirm { select = true },
        ['<C-Space>'] = cmp.mapping.complete {},
    }
end

api.diagnostics = {
    {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
    },
    {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
    },
    {
        "<leader>cs",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
    },
    {
        "<leader>cl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
    },
    {
        "<leader>xL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
    },
    {
        "<leader>xQ",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
    },
}

api.gitsigns = function(gitsigns, buffer)
    local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = buffer
        vim.keymap.set(mode, l, r, opts)
    end
    map('n', '<leader>tb', gitsigns.toggle_current_line_blame, { desc = '[T]oggle git show [b]lame line' })
    map('n', '<leader>tD', gitsigns.toggle_deleted, { desc = '[T]oggle git show [D]eleted' })
end

api.telescope = function(telescope)
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
end

api.treesitter = {
    select = {
        ["a="] = { query = "@assignment.outer", desc = "Select outer part of an assignment" },
        ["i="] = { query = "@assignment.inner", desc = "Select inner part of an assignment" },
        ["l="] = { query = "@assignment.lhs", desc = "Select left hand side of an assignment" },
        ["r="] = { query = "@assignment.rhs", desc = "Select right hand side of an assignment" },

        ["aa"] = { query = "@parameter.outer", desc = "Select outer part of a parameter/argument" },
        ["ia"] = { query = "@parameter.inner", desc = "Select inner part of a parameter/argument" },

        ["ai"] = { query = "@conditional.outer", desc = "Select outer part of a conditional" },
        ["ii"] = { query = "@conditional.inner", desc = "Select inner part of a conditional" },

        ["al"] = { query = "@loop.outer", desc = "Select outer part of a loop" },
        ["il"] = { query = "@loop.inner", desc = "Select inner part of a loop" },

        ["af"] = { query = "@call.outer", desc = "Select outer part of a function call" },
        ["if"] = { query = "@call.inner", desc = "Select inner part of a function call" },

        ["am"] = { query = "@function.outer", desc = "Select outer part of a method/function definition" },
        ["im"] = { query = "@function.inner", desc = "Select inner part of a method/function definition" },

        ["ac"] = { query = "@class.outer", desc = "Select outer part of a class" },
        ["ic"] = { query = "@class.inner", desc = "Select inner part of a class" },
    },
    swap = {
        next = {
            ["<leader>na"] = "@parameter.inner", -- swap parameters/argument with next
            ["<leader>nm"] = "@function.outer", -- swap function with next
        },
        prev = {
            ["<leader>pa"] = "@parameter.inner", -- swap parameters/argument with prev
            ["<leader>pm"] = "@function.outer", -- swap function with previous
        },
    },
    move = {
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
    },
    repeat_move = function(ts_repeat_move)
        -- vim way: ; goes to the direction you were moving.
        vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
        vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)
        -- Optionally, make builtin f, F, t, T also repeatable with ; and ,
        vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f)
        vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F)
        vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t)
        vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T)
    end
}

api.neotree = function()
    vim.keymap.set("n", "\\", "<cmd>Neotree toggle<CR>")
    return {
        ["Z"] = "expand_all_nodes",
    }
end

return api
