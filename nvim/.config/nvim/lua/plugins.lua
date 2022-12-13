vim.cmd [[packadd packer.nvim]]

-- Automatically run :PackerCompile whenever plugins.lua
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- Colorcheme
  use 'folke/tokyonight.nvim'

  -- File explorer
  use {
    'nvim-tree/nvim-tree.lua',
    requires = {
      'nvim-tree/nvim-web-devicons'
    },
    tag = 'nightly'
  }

  -- Statusline
  use 'nvim-lualine/lualine.nvim'

  -- LSP
  use 'neovim/nvim-lspconfig'

  -- Autocomplete
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'saadparwaiz1/cmp_luasnip'
  use 'hrsh7th/cmp-buffer'
  use {
    'L3MON4D3/LuaSnip',
    tag = 'v1.*'
  }
  use 'windwp/nvim-autopairs'
end)

