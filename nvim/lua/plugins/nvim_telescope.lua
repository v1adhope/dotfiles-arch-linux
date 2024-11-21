local config = function()
  local ok, telescope = pcall(require, 'telescope')
  if not ok then
    return
  end

  local ok, actions = pcall(require, 'telescope.actions')
  if not ok then
    return
  end

  telescope.setup {
    pickers = {
      buffers = {
        mappings = {
          n = { ["<M-d>"] = actions.delete_buffer, }
        }
      }
    }
  }
end

return {
  "nvim-telescope/telescope.nvim",
  lazy = false,
  dependencies = { "nvim-lua/plenary.nvim" },
  branch = "0.1.x",
  config = config,
}
