local config = function()
	local ok, rm = pcall(require, "render-markdown")
	if not ok then
		return
	end

	rm.setup({})
end

return {
	"MeanderingProgrammer/render-markdown.nvim",
	dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
	config = config,
}
