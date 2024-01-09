# BetterF - A better way to F around

**Jump to any line and column in only 3-4 keystrokes!**

![F Around](./betterf.gif)

> This is basically a no-node, no-coc, pure Lua version of [neoclide/coc-smartf](https://github.com/neoclide/coc-smartf).
> I found myself relying on smartf a lot, but wanted to move away from CoC into Treesitter and native LSP.
> Couldn't find a better alternative to smartf around, so I made my own.
> Enjoy!

## Installation

Use your favourite plugin installer. E.g., for VimPlug:

```
jjshoots/betterf.nvim
```

## Setup

```lua
-- require the thing
require('betterf')

-- Map a key to trigger the function (you can customize this key, I use <leader>f and <leader>F here)
vim.api.nvim_set_keymap('n', '<Leader>f', [[:lua betterF(true)<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>F', [[:lua betterF(false)<CR>]], { noremap = true, silent = true })
```
