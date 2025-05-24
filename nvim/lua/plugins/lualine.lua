local config = function()
	local ok, lualine = pcall(require, "lualine")
	if not ok then
		return
	end

	-- There is no validation
	local loaded_extensions = { "nvim-tree" }

	lualine.setup({
		options = {
			theme = Theme,
			ignore_focus = { "NvimTree" },
			globalstatus = true,
			extensions = loaded_extensions,
		},
		sections = {
			lualine_c = { { "filename", file_status = true, path = 1 } },
			lualine_x = { { "encoding", show_bomb = true }, "filetype" },
		},
	})
end

return {
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		lazy = false,
		config = config,
	},
}
