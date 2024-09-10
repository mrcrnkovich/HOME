-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
-- vim.cmd.packadd('packer.nvim')

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    -- Git
    use('tpope/vim-fugitive')

    use('jamessan/vim-gnupg')

    -- Fuzzy Find Everything
    use {
          'nvim-telescope/telescope.nvim', tag = '0.1.5',
          requires = { {'nvim-lua/plenary.nvim'} }
    }

    use {
        'nvim-treesitter/nvim-treesitter',
        run = function()
            local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
            ts_update()
        end,
    }

    use 'mfussenegger/nvim-dap'
    use 'leoluz/nvim-dap-go'

      -- Appearance Plugins
    use 'sainnhe/gruvbox-material'
    use('shaunsingh/nord.nvim')
    use({ "catppuccin/nvim", as = "catppuccin" })

	-- LSP Support
    use('neovim/nvim-lspconfig')

    -- Snippets
    use('L3MON4D3/LuaSnip')

      -- Autocomplete
    use('hrsh7th/nvim-cmp')
    use('hrsh7th/cmp-nvim-lsp')
    use('hrsh7th/cmp-buffer')
    use('hrsh7th/cmp-path')
    use('hrsh7th/cmp-cmdline')
    use('saadparwaiz1/cmp_luasnip')

end)
