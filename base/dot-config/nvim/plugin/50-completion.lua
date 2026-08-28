vim.pack.add({
    {src='https://github.com/saghen/blink.cmp', version=vim.version.range('1')},
    'https://github.com/windwp/nvim-autopairs'
})

require('blink.cmp').setup({
    keymap = {preset='default'},
    fuzzy = {implementation='lua'},
    completion = {
        menu = {auto_show = false}
    }
})

require('nvim-autopairs').setup()

