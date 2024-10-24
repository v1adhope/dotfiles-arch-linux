-- TODO: reduce config
local config = function()
  local ok, gs = pcall(require, 'gitsigns')
  if not ok then
    return
  end

  gs.setup {
    signs                        = {
      add          = { text = '│', show_count = true },
      change       = { text = '│', show_count = true },
      delete       = { text = '_', show_count = true },
      topdelete    = { text = '‾', show_count = true },
      changedelete = { text = '~', show_count = true },
      untracked    = { text = '┆', show_count = true }
    },
    signcolumn                   = true,  -- Toggle with `:Gitsigns toggle_signs`
    numhl                        = false, -- Toggle with `:Gitsigns toggle_numhl`
    linehl                       = false, -- Toggle with `:Gitsigns toggle_linehl`
    word_diff                    = false, -- Toggle with `:Gitsigns toggle_word_diff`
    watch_gitdir                 = {
      follow_files = true
    },
    auto_attach                  = true,
    attach_to_untracked          = true,
    current_line_blame           = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
    current_line_blame_opts      = {
      virt_text = true,
      virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
      delay = 1000,
      ignore_whitespace = false,
      virt_text_priority = 100,
    },
    current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
    sign_priority                = 6,
    update_debounce              = 100,
    status_formatter             = nil,   -- Use default
    max_file_length              = 40000, -- Disable if file is longer than this (in lines)
    preview_config               = {
      -- Options passed to nvim_open_win
      border = 'single',
      style = 'minimal',
      relative = 'cursor',
      row = 0,
      col = 1
    }
  }
end

return {
  {
    "lewis6991/gitsigns.nvim",
    config = config,
  }
}
