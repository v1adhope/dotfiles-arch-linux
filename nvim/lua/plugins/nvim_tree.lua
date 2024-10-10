local config = function()
  local ok, tree = pcall(require, "nvim-tree")
  if not ok then
    return
  end

  local ok, tree_api = pcall(require, "nvim-tree.api")
  if not ok then
    return
  end

  -- disable netrw at the very start of your init.lua (strongly advised)
  vim.g.loaded_netrw = 1
  vim.g.loaded_netrwPlugin = 1

  tree.setup {
    disable_netrw = true,
    diagnostics = {
      enable = true,
      -- TODO: later maybe will be changed
      icons = {
        hint = "",
        info = "",
        warning = "",
        error = ""
      }
    },
    git = { ignore = false },
    renderer = {
      indent_markers = { enable = true },
      icons = { git_placement = 'after' }
    },
    -- view = { number = true }
  }

  -- open_on_setup migration
  local function open_nvim_tree(data)
    -- buffer is a [No Name]
    local no_name = data.file == "" and vim.bo[data.buf].buftype == ""

    -- buffer is a directory
    local directory = vim.fn.isdirectory(data.file) == 1

    if not no_name and not directory then
      return
    end

    -- change to the directory
    if directory then
      vim.cmd.cd(data.file)
    end

    -- open the tree
    tree_api.tree.open()
  end

  open_nvim_tree({ vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree }) })
end

return {
  "nvim-tree/nvim-tree.lua",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons"
  },
  config = config,
}
