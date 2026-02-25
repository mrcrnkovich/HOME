vim.api.nvim_create_autocmd({'BufEnter', 'BufWinEnter'}, {
  group = vim.api.nvim_create_augroup('UserGoSnips', {}),
  pattern = {'*.go'},
  callback = function(ev)
    local snips = {
      ife  = 'if err != nil {\n\treturn fmt.Errorf("${1:add context} %w", err)\n}\n',
      ifre = 'if err := $1; err != nil {\n\treturn fmt.Errorf("${2:add context} %w",err)}\n}\n',
      trun = 't.Run(${1:name}, func(t *testing.T) {\n\n})'
    }
    for k in pairs(snips) do
      vim.keymap.set('i', k, function() vim.snippet.expand(snips[k]) end)
    end

    vim.keymap.set('i', 'fn', function()
      local params = ''
      local paramCount = vim.fn.input("Number of parameters? ", "1")
      for i=3,paramCount+2 do
        params = params .. ", ${"..i..":parameter}"
      end
      local snip ='// $1 ${2:description}\nfunc ${1:funcName}(ctx context.Context'..params..') {\n}\n'
      vim.snippet.expand(snip)
    end)
  end,
})
