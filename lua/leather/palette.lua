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
	-- Base colors
	bg = color("#282c34", 235),
	bg_accent = color("#22252c", 234),
	fg = color("#bcbcbc", 250),

	-- Grayscale spectrum
	gray_10 = color("#d6d6d6", 188),
	grey_20 = color("#d2d2d2", 252),
	grey_30 = color("#bebebe", 250),
	grey_60 = color("#2b2b2b", 236),

	-- Accent colors
	matrix_green = color("#00ff41", 46),
	sage_green = color("#c3d9a4", 151),
	crimson = color("#b8162c", 124),
	green = color("#98C379", 114),
	purple = color("#BF79C3", 139),
	red = color("#E06C75", 204),
	blue = color("#61AFEF", 75),

	none = { gui = "NONE", cterm = "NONE" },
}

-- Default semantic colors (alabaster approach)
local default_semantic = {
	strings = colors.green,
	constants = colors.purple,
	comments = colors.red,
	functions = colors.blue,
	errors = colors.crimson,
}

--- Creates a palette with optional semantic color overrides
--- @param semantic_overrides table|nil Optional table of semantic color overrides
--- @return table The complete palette with colors and semantic
local function create_palette(semantic_overrides)
	local semantic = vim.tbl_deep_extend("force", default_semantic, semantic_overrides or {})

	return {
		colors = colors,
		semantic = semantic,
	}
end

-- Export both the factory function and color helper
return {
	create_palette = create_palette,
	color = color,
}
