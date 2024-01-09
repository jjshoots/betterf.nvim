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
require('betterf').setup {
    -- all labels to use in order, the last character is used for accessing overflow indices
    labels = {"a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z",";"},

    -- the highlight color for the markers
    color="#ff0000",

    -- forward and backward search mappings
    mappings={
        "<leader>f", "<leader>F"
    }
}
```
