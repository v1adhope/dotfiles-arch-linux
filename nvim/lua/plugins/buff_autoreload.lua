local config = function()
	local ok, autoreload = pcall(require, "autoreload")
	if not ok then
		return
	end

	autoreload.setup({})
end

return {
	{
		"ccntrq/autoreload.nvim",
		config = config,
	},
}
