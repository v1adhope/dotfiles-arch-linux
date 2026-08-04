Map = function(mode, lhs, rhs, opts)
	local default_opts = { noremap = true, silent = true }
	if opts then
		default_opts = vim.tbl_extend("force", default_opts, opts)
	end
	vim.keymap.set(mode, lhs, rhs, default_opts)
end
