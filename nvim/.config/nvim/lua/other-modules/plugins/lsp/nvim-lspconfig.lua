local ok, _ = pcall(require, 'other-modules/plugins/lsp/mason')
if not ok then
  return
end

local ok, cmp_lsp = pcall(require, 'cmp_nvim_lsp')
if not ok then
  return
end

local capabilities = cmp_lsp.default_capabilities()

local ok, config = pcall(require, 'lspconfig')
if not ok then
  return
end

local ok, handlers = pcall(require, 'other-modules/plugins/lsp/handlers')
if not ok then
  return
end

local ok, languages = pcall(require, 'other-modules/plugins/lsp/languages')
if not ok then
  return
end

for _, lsp in ipairs(Servers) do
  config[lsp].setup {
    on_attach = function(client, bufnr)
      handlers.custom_lsp_attach(client, bufnr)
    end,
    capabillities = capabilities,
    settings = {
      Lua = languages.lua
    }
  }
end