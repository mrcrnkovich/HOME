local M = {}

local function doCommand(cmd, useTerminal, efm)
    local str_cmd = table.concat(cmd, " ")

    if useTerminal then
        vim.cmd(":horizontal terminal "..str_cmd)
        return
    end

    vim.fn.setqflist({}, " ", {
        title = str_cmd,
        lines = {},
    })

    vim.cmd.copen()
    vim.cmd.wincmd("p")

    local function on_event(err, data)
      if err then
          return
      end

      if data then
          vim.fn.setqflist({}, "a", {
            title = str_cmd,
            lines = vim.split(data, "\n", {trimempty=true}),
            efm = efm,
          })
      end
    end

    vim.system(cmd, {
      stdout = vim.schedule_wrap(on_event),
      stderr = vim.schedule_wrap(on_event),
      text   = true,
    })
end

function M.Setup()
  vim.api.nvim_create_autocmd('FileType', {
      pattern = 'go',
      callback = function(arg)
          vim.keymap.set('n', '<F11>', ':GoTestFunc<CR>')

          -- Setting up query for future use
          vim.treesitter.query.set(
              "go",
              "GoTestFindFunc",
              [[ [ ( function_declaration name: (identifier) @id ) ] ]]
          )

          vim.api.nvim_create_user_command('GoTestFunc', function(params)
              local function getCurrentTestFunc()
                  local currentBufnr = 0
                  local currentPos = vim.fn.getcurpos()

                  local rootNode = vim.treesitter.get_node({bufnr=currentBufnr}):root()
                  local query = vim.treesitter.query.get("go", "GoTestFindFunc")

                  for id,node,meta,match in query:iter_captures(rootNode, currentBufnr) do

                      local start_row,_,end_row,_ = node:parent():range()

                      if currentPos[2] > start_row and currentPos[2] < end_row then
                          local text = vim.treesitter.get_node_text(node, currentBufnr)
                          print(text)
                          return vim.treesitter.get_node_text(node, currentBufnr)
                      end
                  end

                  return
              end

              local currentFunc = getCurrentTestFunc()
              doCommand({"go", "test", "-v", "./...", "-run", currentFunc}, params.bang)
          end, {bang=true, nargs = 0})

          vim.api.nvim_create_user_command('GoTest', function(params)
              local go_test_cmd = 'go test ' .. params.args
              if params.bang then
                  vim.cmd(":horizontal terminal "..go_test_cmd)
              else
                  vim.cmd(":cexpr system('"..go_test_cmd.."')")
                  vim.cmd.cwindow()
              end
          end, {
              bang = true,
              nargs = '*',
              complete = function(argLead, cmdLine, pos) 
                  local result = {}
                  local currentBufnr = 0
                  local rootNode = vim.treesitter.get_node({bufnr=currentBufnr}):root()
                  local query = vim.treesitter.query.get("go", "GoTestFindFunc")
                  for id,node,meta,match in query:iter_captures(rootNode, currentBufnr) do
                      table.insert(result, vim.treesitter.get_node_text(node, currentBufnr))
                  end

                  return result
              end,
          })
      end,
  })

  vim.api.nvim_create_autocmd('FileType', {
      pattern = 'perl',
      callback = function(arg)
          vim.api.nvim_create_user_command('Prove', function(params)
              local efm = [[%A#\ Failed\ test\ \'%m\',%Z#\ at\ %f\ line\ %l.]]

              local cmd = {"prove"}
              vim.list_extend(cmd, params.fargs)
              doCommand(cmd, params.bang, efm)
          end, {
              bang = true,
              nargs = '*',
          })

          vim.api.nvim_create_user_command('Perl', function(params)
              local efm = [[%A#\ Failed\ test\ \'%m\',%Z#\ at\ %f\ line\ %l.]]

              local cmd = {"perl"}
              vim.list_extend(cmd, params.fargs)
              doCommand(cmd, params.bang, efm)
          end, {
              bang = true,
              nargs = '*',
          })
      end,
  })
end

return M
