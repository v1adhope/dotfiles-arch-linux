local config = function()
	local ok, comment = pcall(require, "Comment")
	if not ok then
		return
	end

	comment.setup({})
end

return {
	{
		"numToStr/Comment.nvim",
		config = config,
	},
}
