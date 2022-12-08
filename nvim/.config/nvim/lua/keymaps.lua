-- Import modules
require('other_modules/create_keymap')

-- Copy to system clipboard
map('v', '<S-Y>', ':w !wl-copy<CR><CR>', {silent = true})
-- No highlighting
map('n', '<C-h>', ':noh<CR>', {silent = true})

