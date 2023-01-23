require('other_modules/create_keymap')

-- No highlighting
map('n', '<M-n>', ':noh<CR>')
-- Open terminal
map('n', '<M-t>', ':terminal<CR>', { silent = true })
-- Split navigation
map('n', '<M-h>', ':wincmd h<CR>', { silent = true })
map('n', '<M-j>', ':wincmd j<CR>', { silent = true })
map('n', '<M-k>', ':wincmd k<CR>', { silent = true })
map('n', '<M-l>', ':wincmd l<CR>', { silent = true })

-- File explorer
map('n', '<M-f>', ':NvimTreeToggle<CR>', { silent = true })

-- Navigate between buffers
-- map('n', '<S-H>', ':bp<CR>', { silent = true })
-- map('n', '<S-L>', ':bn<CR>', { silent = true })
