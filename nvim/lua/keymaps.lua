local ok, _ = pcall(require, "features/create_keymap")
if not ok then
	return
end

-- No highlighting
Map("n", "<M-n>", ":noh<CR>")

-- Move line
Map("n", "<M-i>", ":m-2<CR>")
Map("n", "<M-o>", ":m+<CR>")

-- Open terminal
Map("n", "<M-t>", ":terminal<CR>")

-- Split navigation
Map("n", "<M-h>", ":wincmd h<CR>")
Map("n", "<M-j>", ":wincmd j<CR>")
Map("n", "<M-k>", ":wincmd k<CR>")
Map("n", "<M-l>", ":wincmd l<CR>")

-- File explorer
Map("n", "<M-f>", ":NvimTreeToggle<CR>")

-- Gitsigns
Map("n", "<M-p>", ":Gitsigns preview_hunk<CR>")
Map("n", "<M-s>", ":Gitsigns select_hunk<CR>")
Map("n", "<M-b>", ":Gitsigns blame_line<CR>")

-- Markdown
Map("n", "<M-m>", ":MPToggle<CR>")

-- Telescope
Map("n", "ff", ":Telescope find_files<CR>")
Map("n", "fg", ":Telescope live_grep<CR>")
Map("n", "fb", ":Telescope buffers<CR>")
Map("n", "fh", ":Telescope help_tags<CR>")
