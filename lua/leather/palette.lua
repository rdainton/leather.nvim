--- @class Color
--- @field gui string Hex color value (e.g., "#fafafa")
--- @field cterm integer Terminal color code (e.g., 255)

--- Creates a new Color object
--- @param gui string Hex color value
--- @param cterm integer Terminal color code
--- @return Color
local function color(gui, cterm)
  return { gui = gui, cterm = cterm }
end

local colors = {
  -- Special
  none = { gui = 'NONE', cterm = 'NONE' },

  -- Greyscale
  snow = color('#f7f7f7', 255),
  pearl = color('#f0f0f0', 254),
  platinum = color('#d6d6d6', 188),
  platinum_mid = color('#d2d2d2', 252),
  silver_light = color('#bebebe', 250),
  silver = color('#bcbcbc', 249),
  graphite = color('#505050', 239),
  slate = color('#3a3a3a', 237),
  onyx_gray = color('#2b2b2b', 236),
  charcoal = color('#282c34', 235),
  onyx = color('#22252c', 234),
  black = color('#000000', 0),

  -- Shared accent colors
  matrix_green = color('#00ff41', 46),
  crimson = color('#b8162c', 124),

  -- Dark theme accent colors
  sage = color('#c3d9a4', 151),
  grass_green = color('#98C379', 114),
  mauve = color('#BF79C3', 139),
  coral = color('#E06C75', 204),
  sky_blue = color('#61AFEF', 75),

  -- Light theme accent colors
  forest_green = color('#448C27', 64),
  violet = color('#7A3E9D', 97),
  brick_red = color('#AA3731', 124),
  cobalt = color('#325CC0', 62),
}

--- @alias Theme
--- | "light"
--- | "dark"

DEFAULT_THEME = 'dark'

--- @class Palette
---
--- Special
--- @field none Color Special 'none' value
---
--- Backgrounds
--- @field background Color Background color
--- @field background_focus Color Focus background color
---
--- Text colors
--- @field text_primary Color Primary text color
--- @field text_secondary Color Secondary text color
--- @field text_muted Color Muted text color
---
--- Neutral colors
--- @field neutral_strong Color Strong neutral color
--- @field neutral_border Color Border neutral color
---
--- Syntax colors
--- @field strings Color String syntax color
--- @field constants Color Constant syntax color
--- @field comments Color Comment syntax color
--- @field functions Color Function syntax color
--- @field errors Color Error color
---
--- Selection colors
--- @field selection_background Color Selection background
--- @field selection_text Color Selection text
---
--- Special highlights
--- @field todos Color Todo highlight color
--- @field cursor Color Cursor color

--- @type table<Theme, Palette>
local themes = {
  dark = {
    none = colors.none,

    background = colors.charcoal,
    background_focus = colors.onyx,

    text_primary = colors.silver,
    text_secondary = colors.platinum_mid,
    text_muted = colors.silver_light,

    neutral_strong = colors.platinum,
    neutral_border = colors.onyx_gray,

    strings = colors.grass_green,
    constants = colors.mauve,
    comments = colors.coral,
    functions = colors.sky_blue,
    errors = colors.crimson,

    selection_background = colors.matrix_green,
    selection_text = colors.charcoal,
    todos = colors.sage,
    cursor = colors.silver,
  },

  light = {
    none = colors.none,

    background = colors.snow,
    background_focus = colors.pearl,

    text_primary = colors.black,
    text_secondary = colors.slate,
    text_muted = colors.graphite,

    neutral_strong = colors.onyx_gray,
    neutral_border = colors.platinum,

    strings = colors.forest_green,
    constants = colors.violet,
    comments = colors.brick_red,
    functions = colors.cobalt,
    errors = colors.crimson,

    selection_background = colors.matrix_green,
    selection_text = colors.black,
    todos = colors.forest_green,
    cursor = colors.black,
  },
}

--- Creates a palette with optional overrides
--- @param theme Theme
--- @param overrides table|nil
--- @return Palette
local function create_palette(theme, overrides)
  local palette = themes[theme]
  if not palette then
    vim.notify(string.format("Unknown theme '%s', falling back to '%s'", theme, DEFAULT_THEME), vim.log.levels.WARN)
    palette = themes[DEFAULT_THEME]
  end

  return vim.tbl_deep_extend('force', {}, palette, overrides or {})
end

return {
  create_palette = create_palette,
  color = color,
  DEFAULT_THEME = DEFAULT_THEME,
}
