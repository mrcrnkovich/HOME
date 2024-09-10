print("Hello Mike")

-- Leader ,
-- This has to be the first think you set
vim.g.mapleader = ','

-- Expand path, confirm if necessary in neovim
vim.opt.path:append('**')

-- Appearance
vim.opt.number         = true
vim.opt.relativenumber = true
vim.opt.cursorline     = true
vim.opt.signcolumn     = 'yes'
vim.opt.termguicolors  = true
vim.opt.background     = 'dark'
vim.g.gruvbox_material_background = 'soft'
vim.cmd.colorscheme('gruvbox-material')
vim.opt.scrolloff      = 4

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
-- Default to 'very magic' search
vim.keymap.set({ 'n', 'v', }, '/', [[/\v]] )
vim.opt.ignorecase = true
vim.opt.smartcase  = true
vim.opt.showmatch  = true

vim.opt.backup   = false
vim.opt.swapfile = false
vim.opt.undodir  = os.getenv("HOME") .. '/.nvim/undodir'
vim.opt.undofile = true

vim.opt.completeopt = { 'noinsert', 'menuone', 'preview', }
vim.opt.omnifunc    = 'syntaxcomplete#Complete'

vim.g.netrw_browse_split = 0
vim.g.netrw_banner       = 0
vim.g.netrw_winsize      = 25


-- UltiSnips
-- vim.g.UltiSnipsExpandTrigger = '<TAB>'
