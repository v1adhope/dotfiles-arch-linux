local config = function()
	local ok, tree = pcall(require, "nvim-tree")
	if not ok then
		return
	end

	local ok, tree_api = pcall(require, "nvim-tree.api")
	if not ok then
		return
	end

	local ok, _ = pcall(require, "features/create_keymap")
	if not ok then
		return
	end

	local on_attach = function(bufnr)
		-- Default mapping
		tree_api.config.mappings.default_on_attach(bufnr)

		local opts = function(desc)
			return { desc = "nvim-tree: " .. desc, buffer = bufnr, nowait = true }
		end

		-- Custom mapping
		Map("n", "ff", ":Telescope find_files<CR>", opts("Telescope find_files"))
		Map("n", "fg", ":Telescope live_grep<CR>", opts("Telescope live_grep"))
		Map("n", "fb", ":Telescope buffers<CR>", opts("Telescope buffers"))
		Map("n", "fh", ":Telescope help_tags<CR>", opts("Telescope help_tags"))
	end

	-- disable netrw at the very start of your init.lua (strongly advised)
	vim.g.loaded_netrw = 1
	vim.g.loaded_netrwPlugin = 1

	tree.setup({
		on_attach = on_attach,
		disable_netrw = true,
		diagnostics = {
			enable = true,
			icons = {
				hint = "",
				info = "",
				warning = "",
				error = "",
			},
		},
		git = { ignore = false },
		renderer = {
			indent_markers = { enable = true },
			icons = { git_placement = "after" },
		},
		-- view = { number = true }
	})

	-- open_on_setup migration
	local function open_nvim_tree(data)
		-- buffer is a [No Name]
		local no_name = data.file == "" and vim.bo[data.buf].buftype == ""

		-- buffer is a directory
		local directory = vim.fn.isdirectory(data.file) == 1

		if not no_name and not directory then
			return
		end

		-- change to the directory
		if directory then
			vim.cmd.cd(data.file)
		end

		-- open the tree
		tree_api.tree.open()
	end

	open_nvim_tree({ vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree }) })
end

return {
	"nvim-tree/nvim-tree.lua",
	lazy = false,
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = config,
}
