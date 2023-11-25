local ok, telescope = pcall(require, 'telescope')
if not ok then
  return
end

telescope.setup {}

local ok, builtin = pcall(require, 'telescope.builtin')
if not ok then
  return
end

vim.keymap.set('n', 'ff', builtin.find_files, {})
vim.keymap.set('n', 'fg', builtin.live_grep, {})
-- vim.keymap.set('n', 'fb', builtin.buffers, {})
-- vim.keymap.set('n', 'fh', builtin.help_tags, {})
