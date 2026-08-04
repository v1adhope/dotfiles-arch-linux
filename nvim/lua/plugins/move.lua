local config = function()
	local ok, move = pcall(require, "mini.move")
	if not ok then
		return
	end

	move.setup()
end

return {
	"nvim-mini/mini.move",
	version = "*",
	config = config,
}
