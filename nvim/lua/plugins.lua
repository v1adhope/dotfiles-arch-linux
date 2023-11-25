vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

local ok, packer = pcall(require, 'packer')
if not ok then
  return
end

return packer.startup(function(use)
  use 'wbthomason/packer.nvim'

  -- Colorcheme
  use 'folke/tokyonight.nvim'

  -- File explorer/ Search
  use {
    'nvim-tree/nvim-tree.lua',
    requires = {
      'nvim-tree/nvim-web-devicons'
    },
    tag = 'nightly'
  }
  use {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    requires = { { 'nvim-lua/plenary.nvim' } }
  }

  -- Statusline
  use 'nvim-lualine/lualine.nvim'

  -- LSP + mason + Autocomplete (requere node)
  use 'williamboman/mason.nvim'
  use 'williamboman/mason-lspconfig.nvim'
  use 'neovim/nvim-lspconfig'

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
  -- use "b0o/schemastore.nvim"

  -- Syntax Highlighting
  use {
    'HiPhish/rainbow-delimiters.nvim',
    requires = {
      'nvim-treesitter/nvim-treesitter',
      run = function()
        local ok, treesitter = pcall(require, 'nvim-treesitter.install')
        if not ok then
          return
        end

        local ts_update = treesitter.update({ with_sync = true })
        ts_update()
      end,
    }
  }

  -- Comment
  use 'terrortylor/nvim-comment'

  -- Formatting
  use 'cappyzawa/trim.nvim'

  -- Rust TODO: crates
  use 'simrat39/rust-tools.nvim'
  use 'Saecki/crates.nvim'

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    packer.sync()
  end
end)
