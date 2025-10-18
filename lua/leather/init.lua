--- Leather - A minimal, Alabaster inspired, colorscheme
---
--- Color Philosophy:
---   - bg_accent: Used for "selected/focused" UI elements (cursor line, status bar,
---     floating windows, LSP references, Telescope selection, etc.)
---   - matrix_green: Used for "active selections" (visual mode, search results,
---     yank highlights, popup menu selection)
---   - Greyscale spectrum: Provides subtle contrast for syntax and UI elements
---   - Semantic colors: Minimal accent colors for strings, constants, comments,
---     functions, and errors
local M = {}

local palette_module = require("leather.palette")
local palette

--- @class Highlight
--- @field fg Color Foreground color
--- @field bg Color Background color

--- @alias TextDecoration
--- | "bold"
--- | "italic"
--- | "underline"
--- | "strikethrough"
--- | "reverse"
--- | "nocombine"

local class_none = "LeatherNone"
local class_debug = "LeatherDebug"

--- Sets highlight group with foreground and background colors
--- @param group string
--- @param highlight Highlight
local hi = function(group, highlight)
	vim.api.nvim_set_hl(0, group, {
		fg = highlight.fg.gui,
		bg = highlight.bg.gui,
		ctermfg = highlight.fg.cterm,
		ctermbg = highlight.bg.cterm,
	})
end

--- Sets highlight group with colors and additional styling (bold, italic, underline, etc.)
--- @param group string
--- @param highlight Highlight
--- @param decorations TextDecoration[]
local hs = function(group, highlight, decorations)
	--- @type table<string, any>
	local highlight_opts = {
		fg = highlight.fg.gui,
		bg = highlight.bg.gui,
		ctermfg = highlight.fg.cterm,
		ctermbg = highlight.bg.cterm,
	}

	for _, item in ipairs(decorations) do
		highlight_opts[item] = true
	end

	vim.api.nvim_set_hl(0, group, highlight_opts)
end

--- Links one highlight group to another
--- @param group string The highlight group to create
--- @param link string The existing highlight group to link to
local link = function(group, link)
	vim.api.nvim_set_hl(0, group, { link = link })
end

--- Sets up basic syntax highlighting for code elements
M.base_syntax = function()
	hi(class_none, { fg = palette.colors.none, bg = palette.colors.none })
	hi(class_debug, { fg = palette.colors.bg, bg = palette.semantic.errors })

	hi("Normal", { fg = palette.colors.fg, bg = palette.colors.bg })
	hi("Comment", { fg = palette.semantic.comments, bg = palette.colors.none })
	hi("String", { fg = palette.semantic.strings, bg = palette.colors.none })
	hi("Character", { fg = palette.semantic.strings, bg = palette.colors.none })
	hi("Number", { fg = palette.semantic.constants, bg = palette.colors.none })
	hi("Boolean", { fg = palette.semantic.constants, bg = palette.colors.none })
	hi("Float", { fg = palette.semantic.constants, bg = palette.colors.none })
	hi("Function", { fg = palette.semantic.functions, bg = palette.colors.none })
	hi("Special", { fg = palette.colors.fg, bg = palette.colors.none })
	hi("SpecialChar", { fg = palette.colors.fg, bg = palette.colors.none })
	hi("SpecialKey", { fg = palette.colors.grey_30, bg = palette.colors.none })
	hi("Error", { fg = palette.semantic.errors, bg = palette.colors.none })

	hi("Constant", { fg = palette.semantic.constants, bg = palette.colors.none })
	hi("Statement", { fg = palette.colors.grey_30, bg = palette.colors.none })
	hi("Conditional", { fg = palette.colors.grey_30, bg = palette.colors.none })
	hi("Exception", { fg = palette.colors.grey_30, bg = palette.colors.none })
	hi("Identifier", { fg = palette.colors.grey_20, bg = palette.colors.none })
	hi("Type", { fg = palette.colors.gray_10, bg = palette.colors.none })
	hi("Repeat", { fg = palette.colors.grey_30, bg = palette.colors.none })
	hi("Label", { fg = palette.colors.grey_30, bg = palette.colors.none })
	hi("Operator", { fg = palette.colors.grey_30, bg = palette.colors.none })
	hi("Keyword", { fg = palette.colors.grey_30, bg = palette.colors.none })
	hi("Delimiter", { fg = palette.colors.grey_30, bg = palette.colors.none })
	hi("Tag", { fg = palette.colors.grey_20, bg = palette.colors.none })
	hi("SpecialComment", { fg = palette.colors.grey_30, bg = palette.colors.none })
	hi("Debug", { fg = palette.colors.fg, bg = palette.colors.none })
	hi("PreProc", { fg = palette.colors.grey_20, bg = palette.colors.none })
	hi("Include", { fg = palette.colors.grey_20, bg = palette.colors.none })
	hi("Define", { fg = palette.colors.grey_20, bg = palette.colors.none })
	hi("Macro", { fg = palette.colors.grey_20, bg = palette.colors.none })
	hi("PreCondit", { fg = palette.colors.grey_20, bg = palette.colors.none })
	hi("StorageClass", { fg = palette.colors.grey_20, bg = palette.colors.none })
	hi("Structure", { fg = palette.colors.grey_20, bg = palette.colors.none })
	hi("Typedef", { fg = palette.colors.grey_20, bg = palette.colors.none })
	hi("Title", { fg = palette.colors.fg, bg = palette.colors.none })
	hi("Todo", { fg = palette.colors.bg, bg = palette.colors.sage_green })
	hi("Underlined", { fg = palette.colors.fg, bg = palette.colors.none })
	hi("Ignore", { fg = palette.colors.grey_30, bg = palette.colors.none })
end

--- Sets up UI element highlighting (cursor, search, menus, etc.)
M.ui = function()
	local underline = { "underline" }

	hi("Cursor", { fg = palette.colors.bg, bg = palette.colors.fg })
	hi("CursorLine", { fg = palette.colors.none, bg = palette.colors.bg_accent })
	hi("CursorLineNr", { fg = palette.colors.fg, bg = palette.colors.bg_accent })
	hi("ColorColumn", { fg = palette.colors.none, bg = palette.colors.bg_accent })
	hi("LineNr", { fg = palette.colors.grey_30, bg = palette.colors.none })
	hi("NonText", { fg = palette.colors.grey_60, bg = palette.colors.none })
	hi("EndOfBuffer", { fg = palette.colors.grey_60, bg = palette.colors.none })
	hi("VertSplit", { fg = palette.colors.grey_60, bg = palette.colors.none })
	hi("WinSeparator", { fg = palette.colors.grey_60, bg = palette.colors.none })
	hi("Folded", { fg = palette.colors.grey_20, bg = palette.colors.grey_60 })
	hi("FoldColumn", { fg = palette.colors.grey_30, bg = palette.colors.none })
	hi("SignColumn", { fg = palette.colors.none, bg = palette.colors.none })
	hi("Pmenu", { fg = palette.colors.fg, bg = palette.colors.bg_accent })
	hi("PmenuSel", { fg = palette.colors.bg, bg = palette.colors.matrix_green })
	hi("PmenuSbar", { fg = palette.colors.none, bg = palette.colors.bg_accent })
	hi("PmenuThumb", { fg = palette.colors.none, bg = palette.colors.grey_30 })
	hi("TabLine", { fg = palette.colors.grey_20, bg = palette.colors.bg_accent })
	hi("TabLineFill", { fg = palette.colors.grey_20, bg = palette.colors.bg_accent })
	hi("TabLineSel", { fg = palette.colors.fg, bg = palette.colors.bg })
	hi("StatusLine", { fg = palette.colors.fg, bg = palette.colors.bg_accent })
	hi("StatusLineNC", { fg = palette.colors.grey_30, bg = palette.colors.bg_accent })
	hi("WildMenu", { fg = palette.colors.bg, bg = palette.colors.grey_20 })
	hi("Visual", { fg = palette.colors.bg, bg = palette.colors.matrix_green })
	hi("Search", { fg = palette.colors.bg, bg = palette.colors.matrix_green })
	hi("IncSearch", { fg = palette.colors.bg, bg = palette.colors.matrix_green })
	hi("CurSearch", { fg = palette.colors.bg, bg = palette.colors.matrix_green })
	hi("Directory", { fg = palette.colors.grey_20, bg = palette.colors.none })

	hs("MatchParen", { fg = palette.colors.fg, bg = palette.colors.bg_accent }, underline)

	hi("ErrorMsg", { fg = palette.semantic.errors, bg = palette.colors.none })
	hi("WarningMsg", { fg = palette.colors.grey_20, bg = palette.colors.none })
	hi("ModeMsg", { fg = palette.colors.grey_30, bg = palette.colors.none })
	hi("MoreMsg", { fg = palette.colors.grey_30, bg = palette.colors.none })
	hi("Question", { fg = palette.colors.grey_20, bg = palette.colors.none })
	hi("MsgArea", { fg = palette.colors.fg, bg = palette.colors.none })

	hi("DiagnosticError", { fg = palette.colors.grey_20, bg = palette.colors.none })
	hi("DiagnosticWarn", { fg = palette.colors.grey_30, bg = palette.colors.none })
	hi("DiagnosticInfo", { fg = palette.colors.grey_30, bg = palette.colors.none })
	hi("DiagnosticHint", { fg = palette.colors.grey_30, bg = palette.colors.none })

	hs("DiagnosticUnderlineError", { fg = palette.semantic.errors, bg = palette.colors.none }, underline)
	hs("DiagnosticUnderlineWarn", { fg = palette.colors.grey_30, bg = palette.colors.none }, underline)
	hs("DiagnosticUnderlineInfo", { fg = palette.colors.grey_30, bg = palette.colors.none }, underline)
	hs("DiagnosticUnderlineHint", { fg = palette.colors.grey_30, bg = palette.colors.none }, underline)

	hi("NormalFloat", { fg = palette.colors.fg, bg = palette.colors.bg_accent })
	hi("FloatBorder", { fg = palette.colors.grey_60, bg = palette.colors.bg_accent })
	hi("Whitespace", { fg = palette.colors.grey_60, bg = palette.colors.none })

	hi("LspReferenceRead", { fg = palette.colors.none, bg = palette.colors.bg_accent })
	hi("LspReferenceWrite", { fg = palette.colors.none, bg = palette.colors.bg_accent })
	hi("LspReferenceText", { fg = palette.colors.none, bg = palette.colors.bg_accent })
end

--- Links various highlight groups to base groups for consistency
M.apply_links = function()
	-- UI: Diff
	link("DiffAdd", "DiagnosticWarn")
	link("DiffChange", "DiagnosticInfo")
	link("DiffDelete", "DiagnosticError")
	link("DiffText", "Visual")

	-- UI: search
	link("CurSearch", "IncSearch")

	-- UI: messages
	link("Question", "String")

	-- UI: Diagnostic
	link("DiagnosticSignError", "DiagnosticError")
	link("DiagnosticSignWarn", "DiagnosticWarn")
	link("DiagnosticSignInfo", "DiagnosticInfo")
	link("DiagnosticSignHint", "DiagnosticHint")
	link("DiagnosticFloatingError", "DiagnosticError")
	link("DiagnosticFloatingWarn", "DiagnosticWarn")
	link("DiagnosticFloatingInfo", "DiagnosticInfo")
	link("DiagnosticFloatingHint", "DiagnosticHint")
	link("DiagnosticVirtualTextError", "DiagnosticError")
	link("DiagnosticVirtualTextWarn", "DiagnosticWarn")
	link("DiagnosticVirtualTextInfo", "DiagnosticInfo")
	link("DiagnosticVirtualTextHint", "DiagnosticHint")

	-- Language: lua
	-- Syntax: built-in
	link("luaFunction", class_none)

	-- Language: HTML
	-- Syntax: built-in
	link("htmlTag", "Special")
	link("htmlEndTag", "Special")
	link("htmlTagName", "Function")
	link("htmlSpecialTagName", "Function")
	link("htmlArg", class_none)

	-- Language: CSS
	-- Syntax: built-in
	link("cssTagName", "Function")
	link("cssColor", "Number")
	link("cssVendor", class_none)
	link("cssBraces", class_none)
	link("cssSelectorOp", class_none)
	link("cssSelectorOp2", class_none)
	link("cssIdentifier", class_none)
	link("cssClassName", class_none)
	link("cssClassNameDot", class_none)
	link("cssVendor", class_none)
	link("cssImportant", class_none)
	link("cssAttributeSelector", class_none)

	-- Language: PHP
	-- Syntax: built-in
	link("phpNullValue", "Boolean")
	link("phpSpecialFunction", "Function")
	link("phpParent", class_none)
	link("phpClasses", class_none)

	-- Language: Javascript
	-- Syntax: built-in
	link("javaScriptNumber", "Number")
	link("javaScriptNull", "Number")
	link("javaScriptBraces", class_none)
	link("javaScriptFunction", class_none)

	-- Language: Javascript
	-- Syntax: 'pangloss/vim-javascript'
	link("jsFunctionKey", "Function")
	link("jsUndefined", "Number")
	link("jsNull", "Number")
	link("jsSuper", class_none)
	link("jsThis", class_none)
	link("jsArguments", class_none)

	-- Language: Typescript
	-- Syntax: built-in
	link("typescriptImport", class_none)
	link("typescriptExport", class_none)
	link("typescriptBraces", class_none)
	link("typescriptDecorator", class_none)
	link("typescriptParens", class_none)
	link("typescriptCastKeyword", class_none)

	-- Language: JSX
	-- Syntax: 'maxmellon/vim-jsx-pretty'
	link("jsxTagName", "Function")
	link("jsxComponentName", "Function")
	link("jsxPunct", "Special")
	link("jsxCloseString", "Special")
	link("jsxEqual", "Special")
	link("jsxAttrib", class_none)

	-- Treesitter (old highlight groups)
	link("TSConstructor", class_none)
	link("TSVariableBuiltin", class_none)
	link("TSConstBuiltin", "Number")
	link("TSFuncBuiltin", "Function")
	link("luaTSPunctBracket", class_none)
	link("TSKeywordFunction", class_none)

	-- Treesitter
	link("@function.call", "Function")
	link("@function.builtin", "Function")
	link("@punctuation.bracket", class_none)
	link("@constant.builtin", "Number")
	link("@constructor", class_none)
	link("@type.css", "Function")
	link("@constructor.php", "Function")
	link("@method.vue", class_none)
	link("@tag.delimiter", "Special")
	link("@tag.attribute", class_none)
	link("@tag", "Function")
	link("@text.uri.html", "String")

	-- LSP semantic tokens in comments
	link("@lsp.mod.documentation", "Comment")

	-- Telescope
	link("TelescopeSelection", "CursorLine")
end

--- Initializes the colorscheme by clearing existing highlights and setting options
--- @param name string The name of the colorscheme
M.init = function(name)
	vim.cmd("hi clear")
	if vim.fn.exists("syntax_on") then
		vim.cmd("syntax reset")
	end

	vim.opt.background = "dark"
	vim.g.colors_name = name
end

--- @class SemanticColors
--- @field comments Color? Optional comment color override
--- @field strings Color? Optional string color override
--- @field constants Color? Optional constant color override
--- @field functions Color? Optional function color override
--- @field errors Color? Optional error color override

--- @class Options
--- @field semantic SemanticColors? Optional semantic color overrides

--- Main setup function that applies the complete colorscheme
--- @param opts Options? Optional configuration table
function M.setup(opts)
	opts = opts or {}

	-- Create palette with any semantic overrides
	palette = palette_module.create_palette(opts.semantic)

	M.init("leather")
	M.base_syntax()
	M.ui()
	M.apply_links()
end

return M
