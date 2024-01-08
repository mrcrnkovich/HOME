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

      -- Appearance Plugins
    use('itchyny/lightline.vim')
    use('morhetz/gruvbox')

    -- Go specific
    -- use('fatih/vim-go')

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
