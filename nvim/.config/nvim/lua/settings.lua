local cmd = vim.cmd
local opt = vim.opt
local api = vim.api

-- Visual limiter
opt.colorcolumn = '70'
api.nvim_set_hl(0, 'ColorColumn', { ctermbg=0 })
-- True Color 24-bit
opt.termguicolors = true
-- Line numbering
opt.number = true
-- Use space characters instead of tabs.
opt.expandtab = true
-- Set tab width to n columns.
opt.tabstop = 2
opt.shiftwidth = 2
-- Do not wrap lines. Allow long lines to extend as far as the line goes.
opt.wrap = false
-- Ignore capital letters during search.
opt.ignorecase = true
-- While searching though a file incrementally highlight matching characters as you type.
opt.incsearch = true
-- Use highlighting when doing a search.
opt.hlsearch = true

