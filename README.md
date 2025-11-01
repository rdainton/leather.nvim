# Leather theme

A minimalist Neovim colorscheme inspired by both the [Alabaster theme for Sublime](https://github.com/tonsky/sublime-scheme-alabaster) and the [Rubber theme for VSCode](https://github.com/apust/vscode-rubber-theme) - with a splash of [The Matrix](https://en.wikipedia.org/wiki/The_Matrix). Features subtle syntax highlighting with colors only for comments, strings, constants, and functions - everything else remains greyscale.

Available in both **dark** (default) and **light** themes.

## Installation

Using [lazy.nvim](https://github.com/folke/lazy.nvim):

```lua
{
  "rdainton/leather.nvim",
  config = function()
    require("leather").setup()
  end,
}
```

## Customization

Customize colors for each theme using the `overrides` structure:

```lua
local leather = require 'leather'
local color = require('leather.palette').color

leather.setup {
  theme = 'light', -- Change the default to 'light' theme
  overrides = {
    dark = { strings = color('#98C379', 114) }, -- Use availalbe `color` helper
    light = { strings = { gui = '#448C27', cterm = 64 } },
  },
}
```

**Available Override Fields:**

You can override any of these palette fields for each theme:

- **Backgrounds:**
  - `background` - Main background color
  - `background_focus` - Focus/accent background (used for cursor line, statusline, menus, etc.)

- **Text Colors:**
  - `text_primary` - Primary text color
  - `text_secondary` - Secondary text color
  - `text_muted` - Muted/dimmed text color

- **Neutral Colors:**
  - `neutral_strong` - Strong neutral color
  - `neutral_border` - Border and subtle UI element color

- **Syntax Highlighting:**
  - `strings` - String literals
  - `constants` - Constants, numbers, booleans
  - `comments` - Code comments
  - `functions` - Function names
  - `errors` - Error messages

- **Selection Colors:**
  - `selection_background` - Visual mode and search background
  - `selection_text` - Visual mode and search text color

- **Special:**
  - `todos` - TODO highlight background color
  - `cursor` - Terminal cursor color (auto-applied via OSC escape sequences)

### Theme Toggle

Switch between light and dark themes with a keybinding:

```lua
vim.keymap.set('n', '<leader>tt', function()
  require('leather').toggle_theme()
end, { desc = "Toggle light/dark theme" })
```
