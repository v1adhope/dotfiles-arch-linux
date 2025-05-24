vim.api.nvim_create_autocmd("FileType", {
	pattern = { "qf" },
	command = [[nnoremap <buffer> <silent> <CR> <CR>:ccl<CR>]],
})
