local config = function()
  local ok, lualine = pcall(require, 'lualine')
  if not ok then
    return
  end

  -- WATCH: there is no validation
  local theme = 'tokyonight'
  local loaded_extensions = { 'nvim-tree' }

  lualine.setup {
    options = {
      theme = theme,
      ignore_focus = { 'NvimTree' },
      globalstatus = true,
      extensions = loaded_extensions
    },
    sections = { lualine_x = { 'encoding', 'filetype' } }
  }
end

return {
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    lazy = false,
    config = config,
  }
}
