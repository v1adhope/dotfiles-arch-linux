function Map(mode, lhs, rhs, options)
  local default_options = { noremap = true }
  if options then
    default_options = vim.tbl_extend('force', default_options, options)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, default_options)
end
