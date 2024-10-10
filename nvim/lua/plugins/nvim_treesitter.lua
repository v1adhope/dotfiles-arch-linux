-- TODO: relations
local build = function()
  local ok, treesitter = pcall(require, 'nvim-treesitter.install')
  if not ok then
    return
  end

  local ts_update = treesitter.update({ with_sync = true })
  ts_update()
end

local config = function()
  local ok, treesitter = pcall(require, 'nvim-treesitter.configs')
  if not ok then
    return
  end

  -- INFO: treesitter based folding
  -- vim.api.nvim_create_autocmd({ 'BufEnter', 'BufAdd', 'BufNew', 'BufNewFile', 'BufWinEnter' }, {
  --   group = vim.api.nvim_create_augroup('TS_FOLD_WORKAROUND', {}),
  --   callback = function()
  --     vim.opt.foldmethod = 'expr'
  --     vim.opt.foldexpr   = 'nvim_treesitter#foldexpr()'
  --   end
  -- })

  -- https://github.com/neovim/neovim/pull/17099
  local ok, rainbow = pcall(require, 'rainbow-delimiters')
  if not ok then
    return
  end

  -- WATCH: Tokyonight colors
  local cmd = vim.cmd
  cmd('highlight TSRainbowGreen  guifg=#a9b1d6 ctermfg=White')    -- White
  cmd('highlight TSRainbowBlue  guifg=#7aa2f7 ctermfg=Blue')      -- Blue
  cmd('highlight TSRainbowViolet  guifg=#bb9af7 ctermfg=Magenta') -- Magenta
  cmd('highlight TSRainbowYellow  guifg=#e0af68 ctermfg=Yellow')  -- Yellow
  cmd('highlight TSRainbowOrange  guifg=#ff9e64 ctermfg=Green')   -- Orange
  cmd('highlight TSRainbowRed  guifg=#f7768e ctermfg=Red')        -- Red
  cmd('highlight TSRainbowCyan  guifg=#7dcfff ctermfg=Cyan')      -- Cyan

  treesitter.setup {
    ensure_installed = {
      'lua',
      'vim',
      'bash',
      'gitignore',
      'json',
      'yaml',
      'html',
      'sql',
      'javascript',
      'css',
      'scss',
      'go',
      'php',
      'vue',
      'markdown',
      'make',
      'dockerfile',
      'python',
      'rust',
      'php_only'
    },
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
        'TSRainbowCyan'
      },
      query = {
        [''] = 'rainbow-delimiters',
        lua = 'rainbow-blocks',
        javascript = 'rainbow-delimiters-react',
        html = 'rainbow-parens',
        tsx = 'rainbow-parens',
        vue = 'rainbow-parens'
      },
      strtategy = {
        [''] = rainbow.strategy['global'],
        html = rainbow.strategy['local'],
      }
    }
  }
end

return {
  {
    "HiPhish/rainbow-delimiters.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    build = build,
    config = config,
  }
}
