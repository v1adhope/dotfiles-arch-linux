local ok, mason = pcall(require, "lsp/mason")
if not ok then
	return
end

local ok, handlers = pcall(require, "lsp/handlers")
if not ok then
	return
end

local ok, _ = pcall(require, "lsp/nvim_cmp")
if not ok then
	return
end

for _, lsp in ipairs(mason.servers) do
	if lsp == "lua_ls" then
		vim.lsp.config[lsp] = {
			on_attach = handlers.custom_lsp_attach,
			capabillities = handlers.capabilities,

			filetypes = { "lua" },

			-- See https://github.com/sumneko/lua-language-server/blob/master/locale/en-us/setting.lua
			settings = {
				Lua = {
					runtime = {
						version = "LuaJIT",
					},
					diagnostics = {
						disable = {
							"redefined-local",
						},
						globals = {
							"vim",
							"nnoremap",
							"vnoremap",
							"inoremap",
							"tnoremap",
							"use",
							"case_sensitive",
						},
					},
					workspace = {
						library = {
							vim.api.nvim_get_runtime_file("", true),
							vim.fn.expand("$VIMRUNTIME/lua"),
							vim.fn.expand("$VIMRUNTIME/lua/vim/lsp") .. "/nvim/lua",
						},
					},
					telemetry = {
						enable = false,
					},
				},
			},
		}
	end

	if lsp == "gopls" then
		vim.lsp.config[lsp] = {
			on_attach = handlers.custom_lsp_attach,
			capabillities = handlers.capabilities,

			filetypes = { "go" },

			-- See https://github.com/golang/tools/blob/master/gopls/doc/settings.md
			settings = {
				gopls = {
					analyses = {
						composites = false,
					},
				},
			},
		}
	end

	if lsp == "jsonls" then
		vim.lsp.config[lsp] = {
			filetypes = { "json", "jsonc" },
		}
	end

	if lsp == "yamlls" then
		vim.lsp.config[lsp] = {
			filetypes = { "yaml", "yaml.docker-compose", "yaml.gitlab" },
		}
	end

	if lsp == "marksman" then
		vim.lsp.config[lsp] = {
			filetypes = { "markdown", "markdown.mdx" },
		}
	end
end
