return {
  {
    "mason-org/mason.nvim",
    "mason-org/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
  },
  {
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-nvim-lsp",
    "saadparwaiz1/cmp_luasnip",
  },
  -- TODO: unstable
  -- {
  --   "hrsh7th/cmp-buffer",
  --   dependencies = {
  --     {
  --       "rafamadriz/friendly-snippets",
  --       dependencies = {
  --         {
  --           "L3MON4D3/LuaSnip",
  --           version = "v2.*",
  --           build = "make install_jsregexp",
  --         },
  --       },
  --     },
  --   },
  -- },
  {
    "hrsh7th/cmp-buffer",
  },
  {
    "L3MON4D3/LuaSnip",
    dependencies = { "rafamadriz/friendly-snippets" },
    version = "v2.*",
    build = "make install_jsregexp",
  },
}
