local M = {}

local function godoc(cmd, package, ...)
  local function set_options()
    vim.bo.swapfile = false
    vim.bo.buftype = 'nofile'
    vim.bo.bufhidden = 'unload'
    vim.bo.modified = false
    vim.bo.readonly = true
    vim.bo.modifiable = false
    vim.bo.filetype = 'godoc'
  end

  local page = vim.system({"go", "doc", "-all", package}, {text = true, timeout = 10000 }):wait()

  vim.cmd([[:vertical new<CR>]])
  vim.cmd.file({ 'godoc://'..package , mods = { silent = true } })

  vim.bo.modifiable = true
  vim.bo.readonly = false
  vim.bo.swapfile = false

  vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.split(page.stdout, '\n'))
  vim.cmd('1') -- Move cursor to first line
  set_options()
end

function M.Setup()
  vim.api.nvim_create_user_command('Godoc',
    function(params)
      godoc({"go", "doc", "-all"}, params.args)
      vim.cmd[[highlight godocTitle guifg=darkred gui=bold]]
    end,
    { nargs = 1 }
  )
end

return M
