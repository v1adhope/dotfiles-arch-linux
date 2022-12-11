local status_ok, lualine = pcall(require, 'lualine')
if not status_ok then
  return
end

-- No verification TODO
local lualine_theme = 'tokyonight'
local loaded_extensions = 'nvim-tree'

lualine.setup {
  options = {
    theme = lualine_theme,
    ignore_focus = {'NvimTree'},
    globalstatus = true,
    extensions = {loaded_extensions}
  },
  sections = {lualine_x = {'encoding', 'filetype'}}
}

