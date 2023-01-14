local ok, tree = pcall(require, "nvim-tree")
if not ok then
  return
end

-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

tree.setup {
  disable_netrw = true,
  sort_by = case_sensitive,
  diagnostics = {
    enable = true,
    -- TODO: later maybe will be changed
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = ""
    }
  },
  git = { ignore = false },
  renderer = {
    indent_markers = { enable = true },
    icons = { git_placement = 'after' }
  },
  -- view = { number = true }
}
