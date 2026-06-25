# Consider to use

- https://github.com/nvim-mini/mini.pairs
- https://github.com/nvim-mini/mini.move
- https://github.com/nvim-mini/mini.keymap

```lua
use 'simrat39/rust-tools.nvim'
use 'Saecki/crates.nvim'

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
```

Rust tools
