require('other_modules/create_keymap')

-- No highlighting
map('n', '<C-n>', ':noh<CR>')
-- Open terminal
map('n', '<S-T>', ':terminal<CR>')
-- Split navigation
map('n', '<C-h>', ':wincmd h<CR>', { silent = true })
map('n', '<C-j>', ':wincmd j<CR>', { silent = true })
map('n', '<C-k>', ':wincmd k<CR>', { silent = true })
map('n', '<C-l>', ':wincmd l<CR>', { silent = true })

-- File explorer
map('n', '<C-e>', ':NvimTreeToggle<CR>', { silent = true })

-- Navigate between buffers
map('n', '<S-H>', ':bp<CR>', { silent = true })
map('n', '<S-L>', ':bn<CR>', { silent = true })
