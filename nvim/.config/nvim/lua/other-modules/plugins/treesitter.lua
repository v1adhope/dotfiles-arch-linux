local ok, treesitter = pcall(require, 'nvim-treesitter.configs')
if not ok then
  return
end

-- Treesitter based folding
-- vim.api.nvim_create_autocmd({ 'BufEnter', 'BufAdd', 'BufNew', 'BufNewFile', 'BufWinEnter' }, {
--   group = vim.api.nvim_create_augroup('TS_FOLD_WORKAROUND', {}),
--   callback = function()
--     vim.opt.foldmethod = 'expr'
--     vim.opt.foldexpr   = 'nvim_treesitter#foldexpr()'
--   end
-- })

-- https://github.com/neovim/neovim/pull/17099
local ok, rainbow = pcall(require, 'ts-rainbow')
if not ok then
  return
end

-- Tokyonight colors
local cmd = vim.cmd
cmd('highlight TSRainbowGreen  guifg=#a9b1d6 ctermfg=White')    -- White
cmd('highlight TSRainbowBlue  guifg=#7aa2f7 ctermfg=Blue')      -- Blue
cmd('highlight TSRainbowViolet  guifg=#bb9af7 ctermfg=Magenta') -- Magenta
cmd('highlight TSRainbowYellow  guifg=#e0af68 ctermfg=Yellow')  -- Yellow
cmd('highlight TSRainbowOrange  guifg=#ff9e64 ctermfg=Green')   -- Orange
cmd('highlight TSRainbowRed  guifg=#f7768e ctermfg=Red')        -- Red
cmd('highlight TSRainbowCyan  guifg=#7dcfff ctermfg=Cyan')      -- Cyan

treesitter.setup {
  ensure_install = { 'all' },
  sync_install = false,
  auto_install = true,
  highlight = {
    enable = true,
    disable = { '' }
  },
  rainbow = {
    enable = true,
    hlgroups = {
      'TSRainbowGreen',
      'TSRainbowRed',
      'TSRainbowYellow',
      'TSRainbowBlue',
      'TSRainbowOrange',
      'TSRainbowViolet',
      'TSRainbowCyan',
    },
    query = { 'rainbow-parens' },
    strategy = rainbow.strategy.global
  }
}
