-- https://github.com/sumneko/lua-language-server/blob/master/locale/en-us/setting.lua
return {
  runtime = {
    version = "LuaJIT"
  },
  diagnostics = {
    disable = {
      'redefined-local'
    },
    globals = {
      'vim',
      "nnoremap",
      "vnoremap",
      "inoremap",
      "tnoremap",
      "use",
      'case_sensitive'
    }
  },
  workspace = {
    library = {
      vim.api.nvim_get_runtime_file("", true),
      [vim.fn.expand("$VIMRUNTIME/lua")] = true,
      [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true
    }
  },
  telemetry = {
    enable = false
  }
}
