-- Rust TODO: crates
use 'simrat39/rust-tools.nvim'
use 'Saecki/crates.nvim'

-- TODO: Not work
local ok, crates = pcall(require, 'crates')
if not ok then
  return
end

crates.setup {
  src = {
    cmp = {
      enabled = true,
    },
  },
}
