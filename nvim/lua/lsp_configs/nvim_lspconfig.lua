local ok, _ = pcall(require, 'lsp_configs/mason')
if not ok then
  return
end

local ok, config = pcall(require, 'lspconfig')
if not ok then
  return
end

local ok, handlers = pcall(require, 'lsp_configs/handlers')
if not ok then
  return
end

for _, lsp in ipairs(Servers) do
  if lsp == 'gopls' then
    config[lsp].setup {
      on_attach = function(client, bufnr)
        handlers.custom_lsp_attach(client, bufnr)
      end,
      capabillities = handlers.capabilities,
      settings = {
        gopls = {
          analyses = {
            composites = false
          }
        }
      }
    }
  elseif lsp == 'lua_ls' then
    config[lsp].setup {
      on_attach = function(client, bufnr)
        handlers.custom_lsp_attach(client, bufnr)
      end,
      capabillities = handlers.capabilities,

      -- INFO: settings https://github.com/sumneko/lua-language-server/blob/master/locale/en-us/setting.lua
      settings = {
        Lua = {
          runtime = {
            version = "LuaJIT"
          },
          diagnostics = {
            disable = {
              "redefined-local"
            },
            globals = {
              "vim",
              "nnoremap",
              "vnoremap",
              "inoremap",
              "tnoremap",
              "use",
              "case_sensitive"
            }
          },
          workspace = {
            library = {
              vim.api.nvim_get_runtime_file("", true),
              vim.fn.expand("$VIMRUNTIME/lua"),
              vim.fn.expand("$VIMRUNTIME/lua/vim/lsp") .. "/nvim/lua",
            }
          },
          telemetry = {
            enable = false
          }
        }
      }
    }

    -- TODO: refresh with https://github.com/mrcjkb/rustaceanvim
  elseif lsp == 'rust_analyzer' then
    config[lsp].setup {
      on_attach = function(client, bufnr)
        handlers.custom_lsp_attach(client, bufnr)
      end,
      capabillities = handlers.capabilities,
    }
    -- INFO: require php-cs-fixer
    -- elseif lsp == 'phpactor' then
    --   config[lsp].setup {
    --     on_attach = function(client, bufnr)
    --       handlers.custom_lsp_attach(client, bufnr)
    --     end,
    --     capabillities = handlers.capabilities,
    --
    --     root_dir = function(_)
    --       return vim.loop.cwd()
    --     end,
    --     init_options = {
    --       ['language_server.diagnostics_on_update'] = false,
    --       ['language_server.diagnostics_on_open'] = false,
    --       ['language_server.diagnostics_on_save'] = false,
    --       ['language_server_phpstan.enabled'] = false,
    --       ['language_server_psalm.enabled'] = false,
    --       ['language_server_php_cs_fixer.enabled'] = true,
    --       ['language_server_php_cs_fixer.bin'] = '/usr/local/bin/php-cs-fixer'
    --     }
    --   }
    elseif lsp == 'intelephense' then
    config[lsp].setup {
      on_attach = function(client, bufnr)
        handlers.custom_lsp_attach(client, bufnr)
      end,
      capabillities = handlers.capabilities,
      filetypes = { "css", "eruby", "html", "javascript", "javascriptreact", "less", "sass", "scss", "svelte", "pug", "typescriptreact", "vue", "php", "blade" }
    }

  elseif lsp == 'emmet_ls' then
    config[lsp].setup {
      on_attach = function(client, bufnr)
        handlers.custom_lsp_attach(client, bufnr)
      end,
      capabillities = handlers.capabilities,
      filetypes = { "css", "eruby", "html", "javascript", "javascriptreact", "less", "sass", "scss", "svelte", "pug", "typescriptreact", "vue", "php", "blade" }
    }
  elseif lsp == 'html' then
    config[lsp].setup {
      on_attach = function(client, bufnr)
        handlers.custom_lsp_attach(client, bufnr)
      end,
      capabillities = handlers.capabilities,
      filetypes = { "blade" },
    }
  else
    config[lsp].setup {
      on_attach = function(client, bufnr)
        handlers.custom_lsp_attach(client, bufnr)
      end,
      capabillities = handlers.capabilities,
    }
  end
end
