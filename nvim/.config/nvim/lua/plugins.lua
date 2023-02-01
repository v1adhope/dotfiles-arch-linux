-- Automatically installing and set up packer.nvim
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
    print "Installing packer close and reopen Neovim..."
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

-- Automatically run :PackerCompile whenever plugins.lua
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

local ok, packer = pcall(require, 'packer')
if not ok then
  return
end

local ok, ts = pcall(require, 'nvim-treesitter.install')
if not ok then
  return
end

-- Correct work after update/ first install
local function ts_update()
  ts.update({ with_sync = true })
end

return packer.startup(function(use)
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

  -- LSP + mason
  use 'williamboman/mason.nvim'
  use 'williamboman/mason-lspconfig.nvim'
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
  use 'rafamadriz/friendly-snippets'

  -- Syntax Highlighting
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ts_update()
  }

  -- Comment
  use 'terrortylor/nvim-comment'

  -- Formatting
  use 'cappyzawa/trim.nvim'

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    packer.sync()
  end
end)
