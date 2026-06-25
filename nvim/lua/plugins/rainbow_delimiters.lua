local config = function()
	local ok, rainbow = pcall(require, "rainbow-delimiters.setup")
	if not ok then
		return
	end

	-- Tokyonight colors
	local cmd = vim.cmd
	cmd("highlight RainbowDelimiterRed  guifg=#f7768e ctermfg=Red")
	cmd("highlight RainbowDelimiterYellow  guifg=#e0af68 ctermfg=Yellow")
	cmd("highlight RainbowDelimiterBlue  guifg=#7aa2f7 ctermfg=Blue")
	cmd("highlight RainbowDelimiterOrange  guifg=#ff9e64 ctermfg=Green")
	cmd("highlight RainbowDelimiterGreen  guifg=#a9b1d6 ctermfg=White")
	cmd("highlight RainbowDelimiterViolet  guifg=#bb9af7 ctermfg=Magenta")
	cmd("highlight RainbowDelimiterCyan  guifg=#7dcfff ctermfg=Cyan")

	rainbow.setup({
		enable = true,
		highlight = {
			"RainbowDelimiterRed",
			"RainbowDelimiterYellow",
			"RainbowDelimiterBlue",
			"RainbowDelimiterOrange",
			"RainbowDelimiterGreen",
			"RainbowDelimiterViolet",
			"RainbowDelimiterCyan",
		},
		query = {
			[""] = "rainbow-delimiters",
			lua = "rainbow-blocks",
			javascript = "rainbow-delimiters-react",
			html = "rainbow-parens",
			tsx = "rainbow-parens",
			vue = "rainbow-parens",
		},
		strtategy = {
			[""] = "rainbow-delimiters.strategy.global",
			html = "rainbow-delimiters.strategy.local",
		},
	})
end

return {
	{
		"HiPhish/rainbow-delimiters.nvim",
		config = config,
	},
}
