local ok, _ = pcall(require, "features/create_keymap")
if not ok then
	return
end

-- No highlighting
Map("n", "gnh", ":noh<CR>")

-- Buffer navigation
Map("n", "<Space><Space>", ":b#<CR>")

-- Split navigation
Map("n", "<C-h>", ":wincmd h<CR>")
Map("n", "<C-j>", ":wincmd j<CR>")
Map("n", "<C-k>", ":wincmd k<CR>")
Map("n", "<C-l>", ":wincmd l<CR>")

-- File explorer
Map("n", "fe", ":NvimTreeToggle<CR>")

-- Gitsigns
Map("n", "gbl", ":Gitsigns blame_line<CR>")

-- Telescope
Map("n", "ff", ":Telescope find_files<CR>")
Map("n", "fg", ":Telescope live_grep<CR>")
Map("n", "fb", ":Telescope buffers sort_mru=true sort_lastused=true initial_mode=normal<CR>")
Map("n", "fh", ":Telescope help_tags<CR>")
Map("n", "fc", ":Telescope git_commits initial_mode=normal<CR>")
Map("n", "fd", ":Telescope diagnostics initial_mode=normal<CR>")

-- Crates
Map("n", "<leader>cv", ":Crates show_versions_popup<CR>")
Map("n", "<leader>cf", ":Crates show_features_popup<CR>")
Map("n", "<leader>cR", ":Crates open_repository<CR>")
