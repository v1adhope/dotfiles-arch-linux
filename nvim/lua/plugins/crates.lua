local config = function()
	local ok, crates = pcall(require, "crates")
	if not ok then
		return
	end

	crates.setup()
end

return {
	"saecki/crates.nvim",
	event = { "BufRead Cargo.toml" },
	tag = "stable",
	config = config,
}
