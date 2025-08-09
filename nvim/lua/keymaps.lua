local ok, _ = pcall(require, "features/create_keymap")
if not ok then
	return
end

-- No highlighting
Map("n", "gnh", ":noh<CR>")

-- Move line
Map("n", "<M-i>", ":m-2<CR>")
Map("n", "<M-o>", ":m+<CR>")

-- Buffer navigation
Map("n", "<M-p>", ":b#<CR>")

-- Open terminal
Map("n", "<M-t>", ":terminal<CR>")

-- Split navigation
Map("n", "<M-h>", ":wincmd h<CR>")
Map("n", "<M-j>", ":wincmd j<CR>")
Map("n", "<M-k>", ":wincmd k<CR>")
Map("n", "<M-l>", ":wincmd l<CR>")

-- File explorer
Map("n", "fe", ":NvimTreeToggle<CR>")

-- Gitsigns
Map("n", "gbl", ":Gitsigns blame_line<CR>")

-- Telescope
Map("n", "ff", ":Telescope find_files<CR>")
Map("n", "fg", ":Telescope live_grep<CR>")
Map("n", "fb", ":Telescope buffers<CR>")
Map("n", "fh", ":Telescope help_tags<CR>")
Map("n", "fc", ":Telescope git_commits<CR>")
Map("n", "fd", ":Telescope diagnostics<CR>")
