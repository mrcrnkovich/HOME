function LoadOptions()
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

    -- Searching
    vim.opt.ignorecase = true
    vim.opt.smartcase  = true
    vim.opt.showmatch  = true

    vim.opt.backup   = false
    vim.opt.swapfile = false
    vim.opt.undodir  = os.getenv("HOME") .. '/.nvim/undodir'
    vim.opt.undofile = true


    -- Completion settings
    vim.opt.completeopt = { 'noinsert', 'menuone', 'popup', }
    vim.opt.omnifunc    = 'syntaxcomplete#Complete'

    vim.g.netrw_browse_split = 0
    vim.g.netrw_banner       = 0
    vim.g.netrw_winsize      = 25
end

-- Vim Remaps
function LoadRemaps()
    -- This has to be the first thing you set
    vim.g.mapleader = ','

    --Terminal Setup
    vim.keymap.set('t', '<ESC>', [[<C-\><C-n>]])
    vim.keymap.set('t', '<C-v><ESC>', '<ESC>')

    --Quick Path completion
    vim.keymap.set('i', '<C-l>', '<C-x><C-l>')
    vim.keymap.set('i', '<C-f>', '<C-x><C-f>')
    vim.keymap.set('i', '<C-Space>', '<C-x><C-o>')

    --Set Open Netrw
    vim.keymap.set('n', '<Leader>t', vim.cmd.Explore)
    vim.keymap.set('n', '<Leader>T', vim.cmd.Vexplore)

    -- Clear Search Highlight
    vim.keymap.set('', '<leader><space>', ':let @/=""<CR>')

    --Window Splitting
    vim.keymap.set('n', '<Leader>v', vim.cmd.vsplit )
    vim.keymap.set('n', '<Leader>-', vim.cmd.split )

    --Set Quick Access menus
    vim.keymap.set('n', '<Leader>r', vim.cmd.reg)
    vim.keymap.set('n', '<Leader>b', vim.cmd.buffers)
    vim.keymap.set('n', '<Leader>m', vim.cmd.marks)

    --Quickfix List
    vim.keymap.set('n', '<Leader>q', vim.cmd.copen)
    vim.keymap.set('n', '[q',        vim.cmd.cnext)
    vim.keymap.set('n', ']q',        vim.cmd.cprevious)
    vim.keymap.set('n', '[Q',        vim.cmd.cnewer)
    vim.keymap.set('n', ']Q',        vim.cmd.cprevious)

    vim.keymap.set('n', '[b',        vim.cmd.bnext)
    vim.keymap.set('n', ']b',        vim.cmd.bprevious)

    -- Fuzzy Finders
    vim.keymap.set('n', '<Leader>f', ':find')
    vim.keymap.set('n', '<Leader>s', ':grep ')

    -- Markdown
    vim.keymap.set('i', '<Leader>cm', '- [ ] ')
end

function godoc(package, ...)
    local function set_options()
      vim.bo.swapfile = false
      vim.bo.buftype = 'nofile'
      vim.bo.bufhidden = 'unload'
      vim.bo.modified = false
      vim.bo.readonly = true
      vim.bo.modifiable = false
      vim.bo.filetype = 'godoc'
    end

    local function set_highlight()
      vim.cmd[[highlight godocTitle guifg=darkred gui=bold]]
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
  set_highlight()
end

function perldoc(package, ...)
    local function set_options()
      vim.bo.swapfile = false
      vim.bo.buftype = 'nofile'
      vim.bo.bufhidden = 'unload'
      vim.bo.modified = false
      vim.bo.readonly = true
      vim.bo.modifiable = false
      vim.bo.filetype = 'man'
    end

    local function set_highlight()
      vim.cmd[[highlight godocTitle guifg=darkred gui=bold]]
    end

  local page = vim.system({"perldoc", package,}, {text = true, timeout = 10000 }):wait()

  vim.cmd([[:vertical new<CR>]])
  vim.cmd.file({ 'perldoc://' .. package , mods = { silent = true } })

  vim.bo.modifiable = true
  vim.bo.readonly = false
  vim.bo.swapfile = false

  vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.split(page.stdout, '\n'))
  vim.cmd('1') -- Move cursor to first line
  set_options()
  set_highlight()
end

-- Custom status line
function StatusLine()
    function GetIndicators()
        local counts = vim.diagnostic.count()
        local errors = counts[vim.diagnostic.severity.ERROR] or 0
        local warnings = counts[vim.diagnostic.severity.WARN] or 0
        local warn_string = warnings > 0 and "%#DiagnosticWarn# " or "  "
        local error_string = errors > 0 and "%#DiagnosticError# " or "  "
        return warn_string .. error_string
    end

    local statusline = {
      '[ %{%v:lua.vim.api.nvim_get_mode().mode%} ]',
      ' %t',
      '%r',
      '%m',
      '%q',
      '%=',
      '%{&filetype}',
      ' %2p%%',
      ' %3l:%-2c ',
      ' [char] %4B',
      '%{%v:lua.GetIndicators()%}',
    }

    vim.o.statusline = table.concat(statusline, '')
end

-- This started off as a port of
-- the Base16 package, Tomorrow-Night
-- https://github.com/chriskempson/tomorrow-theme/blob/master/vim/colors/Tomorrow-Night.vim
function Base16_Colorscheme(settings)
    -- Going down a rabbit hole of syntax highlighting
    local highlight = function(name, val)
        -- where 0 is the global setting for all buffers
        -- https://neovim.io/doc/user/api.html#nvim_set_hl()
        vim.api.nvim_set_hl(0, name, val)
    end

	-- Vim Highlighting
    -- If you want to set the background to transparent use bg=none for "Normal"
    -- and "NonText" otherwise use settings.background
    if settings.transparent then
        highlight("Normal",       { fg=settings.foreground, bg=none })
        highlight("NonText",      { fg=settings.selection,  bg=none }) 
    else
        highlight("Normal",       { fg=settings.foreground, bg=settings.background })
        highlight("NonText",      { fg=settings.selection,  bg=settings.background }) 
    end
	highlight("LineNr",       { fg=settings.selection }) 
	highlight("SpecialKey",   { fg=settings.selection }) 
	highlight("Search",       { fg=settings.background, bg=settings.yellow })
	highlight("TabLine",      { fg=settings.window, bg=settings.foreground, reverse=true })
	highlight("TabLineFill",  { fg=settings.window, bg=settings.foreground, reverse=true })
	highlight("StatusLine",   { fg=settings.window, bg=settings.yellow,     reverse=true })
	highlight("StatusLineNC", { fg=settings.window, bg=settings.foreground, reverse=true })
	highlight("VertSplit",    { fg=settings.window, bg=settings.window })
	highlight("Visual",       { bg=settings.selection })
	highlight("Directory",    { fg=settings.blue  })
	highlight("ModeMsg",      { fg=settings.green })
	highlight("MoreMsg",      { fg=settings.green })
	highlight("Question",     { fg=settings.green })
	highlight("WarningMsg",   { fg=settings.red   })
	highlight("MatchParen",   { bg=settings.selection })
	highlight("Folded",       { fg=settings.comment, bg=settings.background })
	highlight("FoldColumn",   { bg=settings.background  })
    highlight("CursorLine",   { bg=settings.line })
    highlight("CursorColumn", { bg=settings.line })
    highlight("PMenu",        { fg=settings.foreground, bg=settings.selection })
    highlight("PMenuSel",     { fg=settings.foreground, bg=settings.selection, reverse=true })
    highlight("SignColumn",   { bg=settings.background })
    highlight("ColorColumn",  { bg=settings.line })
    highlight("vimCommand",   { fg=settings.red })

    -- Standard Highlighting
 	highlight("Comment",     { fg=settings.comment })
	highlight("Todo",        { fg=settings.foreground, bg=settings.background, bold=true })
	highlight("Title",       { fg=settings.comment })
	highlight("Identifier",  { fg=settings.red })
	highlight("Statement",   { fg=settings.foreground })
	highlight("Conditional", { fg=settings.foreground })
	highlight("Repeat",      { fg=settings.foreground })
	highlight("Structure",   { fg=settings.purple })
	highlight("Function",    { fg=settings.blue   })
	highlight("Constant",    { fg=settings.orange })
	highlight("Keyword",     { fg=settings.orange })
	highlight("String",      { fg=settings.green })
	highlight("Special",     { fg=settings.foreground })
	highlight("PreProc",     { fg=settings.purple })
	highlight("Operator",    { fg=settings.aqua })
	highlight("Type",        { fg=settings.blue })
	highlight("Define",      { fg=settings.purple })
	highlight("Include",     { fg=settings.blue })

    -- C Highlighting
    highlight("cType",         { fg=settings.yellow })
	highlight("cStorageClass", { fg=settings.purple })
	highlight("cConditional",  { fg=settings.purple })
	highlight("cRepeat",       { fg=settings.purple })

	-- Go Highlighting
	highlight("goDirective",   { fg=settings.purple })
	highlight("goDeclaration", { fg=settings.purple })
	highlight("goStatement",   { fg=settings.purple })
	highlight("goConditional", { fg=settings.purple })
	highlight("goConstants",   { fg=settings.orange })
	highlight("goTodo",        { fg=settings.yellow, bold=true })
	highlight("goDeclType",    { fg=settings.blue   })
	highlight("goBuiltins",    { fg=settings.purple })
	highlight("goRepeat",      { fg=settings.purple })
	highlight("goLabel",       { fg=settings.purple })

	-- Lua Highlighting
   	highlight("luaStatement",  { fg=settings.purple })
   	highlight("luaRepeat",     { fg=settings.purple })
   	highlight("luaCondStart",  { fg=settings.purple })
   	highlight("luaCondElseif", { fg=settings.purple })
   	highlight("luaCond",       { fg=settings.purple })
   	highlight("luaCondEnd",    { fg=settings.purple })

    -- Perl Highlighting
	highlight("perlStatement",   { fg=settings.purple })
	highlight("perlConditional", { fg=settings.purple })
	highlight("perlTodo",        { fg=settings.yellow, bold=true })


    -- Other options to be set
    vim.opt.number         = true
    vim.opt.relativenumber = true
    -- vim.opt.cursorline     = true
    vim.opt.signcolumn     = 'yes'
    vim.opt.termguicolors  = true
    vim.opt.scrolloff      = 4
end

function LoadLSP()
    -- LSP setup
    vim.api.nvim_create_autocmd('FileType', {
        pattern = 'go',
        callback = function(arg)
            vim.lsp.start({
                name = "gopls",
                cmd = { os.getenv("HOME") .. "/go/bin/gopls"},
                root_dir = vim.fs.root(arg.buf, {'go.mod', 'go.sum'}),
            })
        end,
    })

    vim.api.nvim_create_autocmd('FileType', {
        pattern = 'perl',
        callback = function(arg)
            vim.lsp.start({
                name = "perl-navigator",
                cmd = {"node", os.getenv("HOME").."/.local/share/PerlNavigator/server/out/server.js", "--stdio" },
                root_dir = vim.fs.root(arg.buf, {'cpanfile'}),
            })
        end,
    })

    -- Global mappings.
    -- See `:help vim.diagnostic.*` for documentation on any of the below functions
    vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
    vim.keymap.set('n', '<space>q', vim.diagnostic.setqflist)

    -- Use LspAttach autocommand to only map the following keys
    -- after the language server attaches to the current buffer
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('UserLspConfig', {}),
      callback = function(ev)
        -- Enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local opts = { buffer = ev.buf }
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
        vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
        vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
        vim.keymap.set('n', '<space>wl', function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, opts)
        vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
        vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
        vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        vim.keymap.set('n', '<space>f', function()
          vim.lsp.buf.format { async = true }
        end, opts)
      end,
    })

    local Format = vim.api.nvim_create_augroup('Format', {})
    vim.api.nvim_create_autocmd("BufWritePre", {
      group   = Format,
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
end

function main()
    print("Hello Mike")    -- Just so we know this file loaded

    LoadOptions()
    LoadRemaps()

    StatusLine()
    local dark_mode = {
        foreground = "#cccccc",
        background = "#2d2d2d",
        selection  = "#515151",
        line       = "#393939",
        comment    = "#999999",
        red        = "#f2777a",
        orange     = "#f99157",
        yellow     = "#ffcc66",
        green      = "#99cc99",
        aqua       = "#66cccc",
        blue       = "#6699cc",
        purple     = "#cc99cc",
        window     = "#4d5057",
        transparent = false,
    }

    local light_mode = {
        foreground = "#4d4d4c",
        background = "#ffffff",
        selection = "#d6d6d6",
        line = "#efefef",
        comment = "#8e908c",
        red = "#c82829",
        orange = "#f5871f",
        yellow = "#eab700",
        green = "#718c00",
        aqua = "#3e999f",
        blue = "#4271ae",
        purple = "#8959a8",
        window = "#efefef",
        transparent = false,
    }

    vim.opt.background = 'light'
    Base16_Colorscheme(light_mode)

    LoadLSP()


  local triggers = {"."}
  vim.api.nvim_create_autocmd("InsertCharPre", {
    buffer = vim.api.nvim_get_current_buf(),
    callback = function()
      if vim.fn.pumvisible() == 1 or vim.fn.state("m") == "m" then
        return
      end
      local char = vim.v.char
      if vim.list_contains(triggers, char) then
        local key = vim.keycode("<C-x><C-o>")
        vim.api.nvim_feedkeys(key, "m", false)
      end
    end
  })
end

main()


vim.api.nvim_create_user_command('Godoc', function(params)
    godoc(params.args)
end , {
    nargs = 1,
})


vim.api.nvim_create_user_command('GoTest', function(params)
    local go_test_cmd = 'go test ' .. params.args
    if params.bang then
        vim.cmd(":cexpr system('"..go_test_cmd.."')")
    else
        vim.cmd(":vertical terminal "..go_test_cmd)
    end
end, {
    bang = true,
    nargs = '*',
})


vim.api.nvim_create_user_command('Perldoc', function(params)
    perldoc(params.args)
end , {
    nargs = 1,
})

vim.api.nvim_create_user_command('Prove', function(params)
    local go_test_cmd = 'prove ' .. params.args
    if params.bang then
        vim.cmd(":cexpr system('"..go_test_cmd.."')")
    else
        vim.cmd(":vertical terminal "..go_test_cmd)
    end
end, {
    bang = true,
    nargs = '*',
})

