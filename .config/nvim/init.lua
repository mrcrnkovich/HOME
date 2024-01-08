
require('mrcrnkovich.packer')
require('mrcrnkovich.set')
require('mrcrnkovich.remap')
require('mrcrnkovich.lsp')

local use_completion = os.getenv("NVIM_CMP") or false
if use_completion then
    require('mrcrnkovich.cmp')
end

-- Load snippets from ~/.config/nvim/LuaSnip/
require("luasnip.loaders.from_lua").load({paths = "~/.config/nvim/lua/LuaSnip/"})
require("luasnip").config.set_config({
  enable_autosnippets = true,
  store_selection_keys = "<Tab>",
})

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

local Format = augroup('Format', {})
local TestCompile = augroup('TestCompile', {})

-- Need to include getcurpos and setpos to save / restore the
-- cursor position upon save
autocmd('BufWrite', {
    group   = Format,
    pattern = '*.go',
    callback = function()
        old_pos = vim.api.nvim_win_get_cursor(0)
        vim.cmd([[:%!goimports]])
        vim.api.nvim_win_set_cursor(0, old_pos)
    end,
})

autocmd('BufWrite', {
    group   = Format,
    pattern = '*.{t,pm,pl}',
    callback = function()
        old_pos = vim.api.nvim_win_get_cursor(0)
        vim.cmd([[:%!perltidy]])
        vim.api.nvim_win_set_cursor(0, old_pos)
    end,
})

autocmd('BufWrite', {
    group   = Format,
    pattern = '*.py',
    callback = function()
        old_pos = vim.api.nvim_win_get_cursor(0)
        vim.cmd([[:%!black --quiet -]])
        vim.api.nvim_win_set_cursor(0, old_pos)
    end,
})

--default
autocmd( 'FileType' , {
    group = TestCompile,
    pattern = '*',
    callback = function()
        vim.keymap.set('n', '<Leader>c', ':make<CR>')
    end,
})

--specifc overrides
autocmd( 'FileType' , {
    group = TestCompile,
    pattern = '*.go',
    callback = function()
        vim.keymap.set('n', '<Leader>c', ':GoTest<CR>')
    end,
})

autocmd( 'FileType' , {
    group = TestCompile,
    pattern = 'perl',
    callback = function()
        vim.keymap.set('n', '<Leader>c', ':!perl -c %<CR>')
    end,
})

