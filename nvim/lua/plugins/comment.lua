local config = function()
	local ok, comment = pcall(require, "mini.comment")
	if not ok then
		return
	end

	comment.setup({})
end

return {
	{
		"nvim-mini/mini.comment",
		version = "*",
		config = config,
	},
}
