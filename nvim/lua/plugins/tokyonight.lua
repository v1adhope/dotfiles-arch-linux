local config = function()
  local ok, colorscheme = pcall(require, 'tokyonight')
  if not ok then
    return
  end

  colorscheme.setup {
    style = 'storm',
    terminal_colors = true
  }

  local theme = 'tokyonight'

  local ok, _ = pcall(vim.cmd, 'colorscheme ' .. theme)
  if not ok then
    return
  end
end

return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = config,
  }
}
