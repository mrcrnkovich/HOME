require('mrcrnkovich.packer')
require('mrcrnkovich.set')
require('mrcrnkovich.remap')
require('mrcrnkovich.lsp')

local use_completion = os.getenv("NVIM_CMP") or true
if use_completion then
    require('mrcrnkovich.cmp')
end

-- Load snippets from ~/.config/nvim/LuaSnip/
require("luasnip").config.set_config({
  enable_autosnippets = true,
  store_selection_keys = "<Tab>",
})

require("luasnip.loaders.from_lua").load({paths = "~/.config/nvim/lua/LuaSnip/"})
require("luasnip.loaders.from_snipmate").lazy_load({paths = "~/.config/nvim/snips/"})

require('dap-go').setup()

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

local Format = augroup('Format', {})
local TestCompile = augroup('TestCompile', {})

autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
    local params = vim.lsp.util.make_range_params()
    params.context = {only = {"source.organizeImports"}}
    -- buf_request_sync defaults to a 1000ms timeout. Depending on your
    -- machine and codebase, you may want longer. Add an additional
    -- argument after params if you find that you have to write the file
    -- twice for changes to be saved.
    -- E.g., vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 3000)
    local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params)
    for cid, res in pairs(result or {}) do
      for _, r in pairs(res.result or {}) do
        if r.edit then
          local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
          vim.lsp.util.apply_workspace_edit(r.edit, enc)
        end
      end
    end
    vim.lsp.buf.format({async = false})
  end
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

