# BetterF - A better way to F around

**Jump to any line and column in only 3-4 keystrokes!**

Also works in visual mode, and with `c` & `d` motions. (Courtesy of [LeonWiese](https://github.com/LeonWiese))

![F Around](./betterf.gif)

> This is basically a no-node, no-coc, pure Lua version of [neoclide/coc-smartf](https://github.com/neoclide/coc-smartf).
> I found myself relying on smartf a lot, but wanted to move away from CoC into Treesitter and native LSP.
> Couldn't find a better alternative to smartf around, so I made my own.
> Enjoy!

## Setup & Installation

Use your favourite plugin installer. E.g., for `Lazy`:

```
local function config_function()
	require("betterf").setup({
		labels = {
			"a",
			"b",
			"c",
			"d",
			"e",
			"f",
			"g",
			"h",
			"i",
			"j",
			"k",
			"l",
			"m",
			"n",
			"o",
			"p",
			"q",
			"r",
			"s",
			"t",
			"u",
			"v",
			"w",
			"x",
			"y",
			"z",
			";",
		},
		color = "#ff0000",
		mappings = {
			"<leader>f",
			"<leader>F",
		},
	})
end

return {
	"jjshoots/betterf.nvim",
	config = config_function,
	keys = {
		"<leader>f",
		"<leader>F",
	},
}
```
