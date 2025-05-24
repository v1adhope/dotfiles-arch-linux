local config = function()
	local ok, trim = pcall(require, "trim")
	if not ok then
		return
	end

	trim.setup({})
end

return {
	{
		"cappyzawa/trim.nvim",
		lazy = false,
		config = config,
	},
}
