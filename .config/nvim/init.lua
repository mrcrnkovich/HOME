print("hello mike")

-- Expand path
vim.opt.path:append('**')

-- File Formatting
vim.opt.modelines     = 0
vim.opt.wrap          = false
vim.opt.textwidth     = 80
vim.opt.formatoptions = 'tcqrn1'
vim.opt.tabstop       = 4
vim.opt.softtabstop   = 4
vim.opt.shiftwidth    = 4
vim.opt.expandtab     = true

vim.opt.more = false

vim.cmd.colorscheme("tomorrow")

-- Searching
vim.opt.ignorecase = true
vim.opt.smartcase  = true
vim.opt.showmatch  = true
vim.opt.wildoptions = "fuzzy,pum,tagfile"

vim.opt.backup   = false
vim.opt.swapfile = false
vim.opt.undodir  = os.getenv("HOME") .. '/.nvim/undodir'
vim.opt.undofile = true

-- Other options to be set
vim.opt.number         = true
vim.opt.relativenumber = true
vim.opt.signcolumn     = 'yes'
vim.opt.termguicolors  = true
vim.opt.scrolloff      = 4
vim.opt.cursorline     = true
vim.opt.background     = 'light'

-- Completion settings
vim.opt.completeopt = { 'noinsert', 'menuone', 'popup', }
vim.opt.omnifunc    = 'syntaxcomplete#Complete'

vim.g.netrw_browse_split = 0
vim.g.netrw_banner       = 0
vim.g.netrw_winsize      = 25

-- Setup LSPs
vim.lsp.enable('gopls')
vim.lsp.enable('perl-navigator')

-- Disable line numbers in terminal
vim.api.nvim_create_autocmd("TermOpen", {
  group = augroup,
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.signcolumn = "no"
  end,
})

-- Custom status line
function gitBranch()
  local result = vim.system({'/usr/bin/git', '--no-pager', '--no-advice', 'branch', '--show-current'},{text = true}):wait()
  if result.stderr then
    vim.notify_once(result.stderr, vim.log.levels.WARN)
  end
  --trim trailing newline before return
  return string.sub(result.stdout, 1, -2)
end

vim.o.statusline = table.concat(
  {
    ' %{v:lua.gitBranch()}', '|', '%t', '%r', '%m',
    '%=',
    '%3l:%-3c', '%2p%%', '%y',
  },
  ' '
)

-- Vim Remaps
-- This has to be the first thing you set
vim.g.mapleader = ','
vim.keymap.set('i', 'jj', '<ESC>')

--Terminal Setup
vim.keymap.set('t', '<ESC>', [[<C-\><C-n>]])
vim.keymap.set('t', '<C-v><ESC>', '<ESC>')

--Quick Path completion
vim.keymap.set('i', '<C-l>', '<C-x><C-l>')
vim.keymap.set('i', '<C-f>', '<C-x><C-f>')
vim.keymap.set('i', '<C-Space>', '<C-x><C-o>')

-- Set Open Netrw
vim.keymap.set('n', '<Leader>t', vim.cmd.Explore)
vim.keymap.set('n', '<Leader>T', vim.cmd.Vexplore)

-- Clear Search Highlight
vim.keymap.set('', '<leader><space>', ':let @/=""<CR>')

-- Window Splitting
vim.keymap.set('n', '<Leader>v', vim.cmd.vsplit )
vim.keymap.set('n', '<Leader>-', vim.cmd.split )

--Set Quick Access menus
vim.keymap.set('n', '<Leader>r', vim.cmd.reg)
vim.keymap.set('n', '<Leader>b', vim.cmd.buffers)
vim.keymap.set('n', '<Leader>m', vim.cmd.marks)

--Quickfix List
vim.keymap.set('n', '<F12>',     ':wa | make ')
vim.keymap.set('n', '<Leader>q', vim.cmd.cwindow)
vim.keymap.set('n', '[q',        vim.cmd.cnext)
vim.keymap.set('n', ']q',        vim.cmd.cprevious)
vim.keymap.set('n', '[Q',        vim.cmd.cnewer)
vim.keymap.set('n', ']Q',        vim.cmd.colder)

vim.keymap.set('n', '[b',        vim.cmd.bnext)
vim.keymap.set('n', ']b',        vim.cmd.bprevious)

-- Fuzzy Finders
vim.keymap.set('n', '<Leader>f', ':find ')
vim.keymap.set('n', '<Leader>s', ':grep ')

-- Markdown
vim.keymap.set('i', '<Leader>cm', '- [ ] ')

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- See `:help vim.diagnostic.*` for documentation on any of the below functions
    vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
    vim.keymap.set('n', '<space>q', vim.diagnostic.setqflist)

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', '<A-k>', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<leader>a', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', 'gq', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})

function git_find(arg, cmdcomplete)
end

vim.cmd[[
	    " Use the 'git ls-files' output
	func FindGitFiles(cmdarg, cmdcomplete)
		let fnames = systemlist('git ls-files')
		return fnames->filter('v:val =~? a:cmdarg')
	endfunc
	set findfunc=FindGitFiles
]]

vim.api.nvim_create_autocmd('TextYankPost', {
    group = vim.api.nvim_create_augroup('yank_highlight', { clear = true }),
    desc = 'Highlight on yank',
    callback = function()
        vim.hl.on_yank { higroup = 'Visual' }
    end,
})

vim.api.nvim_create_user_command('Float', function(params)
  myText = [[
    hello world
    hello world
    hello world
    hello world
]]

  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_open_win(buf,true,
    {
      relative = "cursor",
      row = 1,
      col = 0,
      height =  8,
      width  = 50,
      zindex = 50,
    }
  )
  vim.api.nvim_paste(myText, false, -1)
  vim.api.nvim_set_option_value("buftype", "prompt", {buf=buf})
  vim.fn.prompt_setcallback(buf,
    function(text)
        vim.api.nvim_buf_set_lines(buf, -2, -2, false, { "you entered: " ..text })
    end
  )
  vim.cmd.startinsert()
end, { nargs = '*' })

require("nvim-tools").Setup()
