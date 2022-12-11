local status_ok, colorscheme = pcall(require, 'tokyonight')
if not status_ok then
  return
end

colorscheme.setup {
  style = 'storm',
  terminal_colors = true
}

local colorscheme = 'tokyonight'

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  return
end

