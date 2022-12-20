local ok, trim = pcall(require, 'trim')
if not ok then
  return
end

trim.setup {
  -- Uses LSP
  disable = { 'go', 'lua' }
}
