vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = { "*.go" },
	callback = function()
		vim.lsp.buf.format(nil, 500)
	end,
})
