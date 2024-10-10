local config = function()
  local ok, ibl = pcall(require, 'ibl')
  if not ok then
    return
  end

  ibl.setup {
    scope = { enabled = false },
  }
end

return {
  {
    "lukas-reineke/indent-blankline.nvim",
    config = config,
  }
}
