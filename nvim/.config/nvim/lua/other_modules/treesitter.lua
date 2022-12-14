local ok, treesitter = pcall(require, 'nvim-treesitter.configs')
if not ok then
  return
end

-- Treesitter based folding
--vim.api.nvim_create_autocmd({ 'BufEnter', 'BufAdd', 'BufNew', 'BufNewFile', 'BufWinEnter' }, {
--  group = vim.api.nvim_create_augroup('TS_FOLD_WORKAROUND', {}),
--  callback = function()
--    vim.opt.foldmethod = 'expr'
--    vim.opt.foldexpr   = 'nvim_treesitter#foldexpr()'
--  end
--})

treesitter.setup {
  ensure_install = { 'all' },
  sync_install = false,
  auto_install = true,
  highlight = {
    enable = true,
    disable = { '' }
  }
}
