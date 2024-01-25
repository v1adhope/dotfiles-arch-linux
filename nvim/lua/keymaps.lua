local ok, _ = pcall(require, 'other-modules/create-keymap')
if not ok then
  return
end

-- No highlighting
Map('n', '<M-n>', ':noh<CR>')
-- Move line
Map('n', '<M-i>', ':m-2<CR>')
Map('n', '<M-o>', ':m+<CR>')
-- Open terminal
Map('n', '<M-t>', ':terminal<CR>', { silent = true })
-- Split navigation
Map('n', '<M-h>', ':wincmd h<CR>', { silent = true })
Map('n', '<M-j>', ':wincmd j<CR>', { silent = true })
Map('n', '<M-k>', ':wincmd k<CR>', { silent = true })
Map('n', '<M-l>', ':wincmd l<CR>', { silent = true })

-- File explorer
Map('n', '<M-f>', ':NvimTreeToggle<CR>', { silent = true })

-- Gitsigns
Map('n', '<M-p>', ':Gitsigns preview_hunk<CR>', { silent = true })
Map('n', '<M-s>', ':Gitsigns select_hunk<CR>', { silent = true })

-- Markdown
Map('n', '<M-m>', ':MPToggle<CR>', { silent = true })

-- Navigate between buffers
-- map('n', '<S-H>', ':bp<CR>', { silent = true })
-- map('n', '<S-L>', ':bn<CR>', { silent = true })
