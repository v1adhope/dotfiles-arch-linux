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
end)

