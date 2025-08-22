local M = {}

local ok, mason = pcall(require, "mason")
if not ok then
	return
end

mason.setup({
	-- log_level = vim.log.levels.DEBUG,
	-- install_root_dir = path.concat { vim.fn.stdpath "config", "mason" },
	ui = {
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗",
		},
	},
})

local ok, mason_lsp = pcall(require, "mason-lspconfig")
if not ok then
	return
end

-- Connecting servers (see plugins.lua for require)
M.servers = {
	"lua_ls",
	"gopls",
	"bashls",
	-- "nil_ls",

	"jsonls",
	"yamlls",
	"marksman",
	"docker_language_server",
	"taplo",

	"pyright",
	"rust_analyzer",
}

mason_lsp.setup({
	automatic_enable = M.servers,
	ensure_installed = M.servers,
})

return M
