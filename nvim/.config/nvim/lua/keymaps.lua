-- Import modules
require('other_modules/create_keymap')

-- Copy to system clipboard
map('v', '<S-Y>', ':w !wl-copy<CR><CR>', {silent = true})
-- No highlighting
map('n', '<C-n>', ':noh<CR>')
-- Open terminal
map('n', '<S-t>', ':terminal<CR>')
-- Split navigation
map('n', '<C-h>', ':wincmd h<CR>', {silent = true})
map('n', '<C-j>', ':wincmd j<CR>', {silent = true})
map('n', '<C-k>', ':wincmd k<CR>', {silent = true})
map('n', '<C-l>', ':wincmd l<CR>', {silent = true})

-- File explorer
map('n', '<C-e>',':NvimTreeToggle<CR>', {silent = true})

