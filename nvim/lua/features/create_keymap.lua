Map = function(mode, lhs, rhs, options)
  local default_options = { noremap = true, silent = true }
  if options then
    default_options = vim.tbl_extend('force', default_options, options)
  end
  vim.keymap.set(mode, lhs, rhs, default_options)
end
