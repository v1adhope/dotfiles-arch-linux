local ok, ntp = pcall(require, "nvim-treesitter.parsers")
if not ok then
	return
end

ntp.get_parser_configs().blade = {
	install_info = {
		url = "https://github.com/EmranMR/tree-sitter-blade",
		files = { "src/parser.c" },
		branch = "main",
	},
	filetype = "blade",
}
