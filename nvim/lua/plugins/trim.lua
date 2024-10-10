local config = function()
  local ok, trim = pcall(require, 'trim')
  if not ok then
    return
  end

  trim.setup {
    -- WATCH: used with LSP
    -- disable = { 'go', 'lua' }
  }
end

return {
  {
    "cappyzawa/trim.nvim",
    lazy = false,
    config = config,
  }
}
