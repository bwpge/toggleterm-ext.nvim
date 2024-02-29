# toggleterm-ext.nvim

A Neovim plugin extending [`toggleterm.nvim`](https://github.com/akinsho/toggleterm.nvim) through new UI elements, functions, commands, and [`telescope`](https://github.com/nvim-telescope/telescope.nvim) extensions.

This plugin is not endorsed by nor supported by [`akinsho`](https://github.com/akinsho), the author of `toggleterm.nvim`.

## Installation

With [`lazy.nvim`](https://github.com/folke/lazy.nvim)

```lua
{
    "akinsho/toggleterm.nvim",
    dependencies = {
        "bwpge/toggleterm-ext.nvim",
        dependencies = { "MunifTanjim/nui.nvim" },
        opts = {},
    },
    -- rest of toggleterm spec
}
```
