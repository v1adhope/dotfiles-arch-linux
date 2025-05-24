vim.api.nvim_create_autocmd({ "BufEnter" }, {
	pattern = "*",
	callback = function()
		vim.opt.fo:remove("c")
		vim.opt.fo:remove("r")
		vim.opt.fo:remove("o")
	end,
})
