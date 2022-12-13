local status_ok, lualine = pcall(require, 'lualine')
if not status_ok then
  return
end

-- TODO: No verification
local theme = 'tokyonight'
local loaded_extensions = 'nvim-tree'

lualine.setup {
  options = {
    theme = theme,
    ignore_focus = { 'NvimTree' },
    globalstatus = true,
    extensions = { loaded_extensions }
  },
  sections = { lualine_x = { 'encoding', 'filetype' } }
}

