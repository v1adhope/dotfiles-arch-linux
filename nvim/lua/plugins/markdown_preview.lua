local config = function()
	local ok, mp = pcall(require, "markdown-preview")
	if not ok then
		return
	end

	mp.setup({})
end

return {
	"0x00-ketsu/markdown-preview.nvim",
	config = config,
}
