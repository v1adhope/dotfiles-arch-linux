-- https://github.com/ChristianChiarulli/nvim/blob/master/lua/user/lsp/settings/rust.lua
local ok, rt = pcall(require, "rust-tools")
if not ok then
  return
end


return {
  -- filetypes = { "rust" },
  -- root_dir = util.root_pattern("Cargo.toml"),
  -- settings = {
  --   ['rust-analyzer'] = {
  --     cargo = { allFeatures = true },
  --   },
  -- },
  rt.setup()
}
