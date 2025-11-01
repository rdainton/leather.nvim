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

local class_none = 'LeatherNone'

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

--- Sets the terminal cursor color using OSC escape sequences
--- (supported by Ghostty, iTerm2, Kitty, etc.)
--- @param color_hex string The hex color value (e.g., "#bcbcbc")
local function set_terminal_cursor_color(color_hex)
  io.write(string.format('\027]12;%s\007', color_hex))
  io.flush()
end

local palette_module = require 'leather.palette'
local palette

local function highlight_syntax()
  hi(class_none, { fg = palette.none, bg = palette.none })
  hi('LeatherDebug', { fg = palette.background, bg = palette.errors })

  hi('Normal', { fg = palette.text_primary, bg = palette.background })
  hi('Comment', { fg = palette.comments, bg = palette.none })
  hi('String', { fg = palette.strings, bg = palette.none })
  hi('Character', { fg = palette.strings, bg = palette.none })
  hi('Number', { fg = palette.constants, bg = palette.none })
  hi('Boolean', { fg = palette.constants, bg = palette.none })
  hi('Float', { fg = palette.constants, bg = palette.none })
  hi('Function', { fg = palette.functions, bg = palette.none })
  hi('Special', { fg = palette.text_primary, bg = palette.none })
  hi('SpecialChar', { fg = palette.text_primary, bg = palette.none })
  hi('SpecialKey', { fg = palette.text_muted, bg = palette.none })
  hi('Error', { fg = palette.errors, bg = palette.none })

  hi('Constant', { fg = palette.constants, bg = palette.none })
  hi('Statement', { fg = palette.text_muted, bg = palette.none })
  hi('Conditional', { fg = palette.text_muted, bg = palette.none })
  hi('Exception', { fg = palette.text_muted, bg = palette.none })
  hi('Identifier', { fg = palette.text_secondary, bg = palette.none })
  hi('Type', { fg = palette.neutral_strong, bg = palette.none })
  hi('Repeat', { fg = palette.text_muted, bg = palette.none })
  hi('Label', { fg = palette.text_muted, bg = palette.none })
  hi('Operator', { fg = palette.text_muted, bg = palette.none })
  hi('Keyword', { fg = palette.text_muted, bg = palette.none })
  hi('Delimiter', { fg = palette.text_muted, bg = palette.none })
  hi('Tag', { fg = palette.text_secondary, bg = palette.none })
  hi('SpecialComment', { fg = palette.text_muted, bg = palette.none })
  hi('Debug', { fg = palette.text_primary, bg = palette.none })
  hi('PreProc', { fg = palette.text_secondary, bg = palette.none })
  hi('Include', { fg = palette.text_secondary, bg = palette.none })
  hi('Define', { fg = palette.text_secondary, bg = palette.none })
  hi('Macro', { fg = palette.text_secondary, bg = palette.none })
  hi('PreCondit', { fg = palette.text_secondary, bg = palette.none })
  hi('StorageClass', { fg = palette.text_secondary, bg = palette.none })
  hi('Structure', { fg = palette.text_secondary, bg = palette.none })
  hi('Typedef', { fg = palette.text_secondary, bg = palette.none })
  hi('Title', { fg = palette.text_primary, bg = palette.none })
  hi('Todo', { fg = palette.background, bg = palette.todos })
  hi('Underlined', { fg = palette.text_primary, bg = palette.none })
  hi('Ignore', { fg = palette.text_muted, bg = palette.none })
end

local function highlight_ui()
  local underline = { 'underline' }

  hi('Cursor', { fg = palette.background, bg = palette.text_primary })
  hi('CursorLine', { fg = palette.none, bg = palette.background_focus })
  hi('CursorLineNr', { fg = palette.text_primary, bg = palette.background_focus })
  hi('ColorColumn', { fg = palette.none, bg = palette.background_focus })
  hi('LineNr', { fg = palette.text_muted, bg = palette.none })
  hi('NonText', { fg = palette.neutral_border, bg = palette.none })
  hi('EndOfBuffer', { fg = palette.neutral_border, bg = palette.none })
  hi('VertSplit', { fg = palette.neutral_border, bg = palette.none })
  hi('WinSeparator', { fg = palette.neutral_border, bg = palette.none })
  hi('Folded', { fg = palette.text_secondary, bg = palette.neutral_border })
  hi('FoldColumn', { fg = palette.text_muted, bg = palette.none })
  hi('SignColumn', { fg = palette.none, bg = palette.none })
  hi('Pmenu', { fg = palette.text_primary, bg = palette.background_focus })
  hi('PmenuSel', { fg = palette.selection_text, bg = palette.selection_background })
  hi('PmenuSbar', { fg = palette.none, bg = palette.background_focus })
  hi('PmenuThumb', { fg = palette.none, bg = palette.text_muted })
  hi('TabLine', { fg = palette.text_secondary, bg = palette.background_focus })
  hi('TabLineFill', { fg = palette.text_secondary, bg = palette.background_focus })
  hi('TabLineSel', { fg = palette.text_primary, bg = palette.background })
  hi('StatusLine', { fg = palette.text_primary, bg = palette.background_focus })
  hi('StatusLineNC', { fg = palette.text_muted, bg = palette.background_focus })
  hi('WildMenu', { fg = palette.background, bg = palette.text_secondary })
  hi('Visual', { fg = palette.selection_text, bg = palette.selection_background })
  hi('Search', { fg = palette.selection_text, bg = palette.selection_background })
  hi('IncSearch', { fg = palette.selection_text, bg = palette.selection_background })
  hi('CurSearch', { fg = palette.selection_text, bg = palette.selection_background })
  hi('Directory', { fg = palette.text_secondary, bg = palette.none })

  hs('MatchParen', { fg = palette.text_primary, bg = palette.background_focus }, underline)

  hi('ErrorMsg', { fg = palette.errors, bg = palette.none })
  hi('WarningMsg', { fg = palette.text_secondary, bg = palette.none })
  hi('ModeMsg', { fg = palette.text_muted, bg = palette.none })
  hi('MoreMsg', { fg = palette.text_muted, bg = palette.none })
  hi('Question', { fg = palette.text_secondary, bg = palette.none })
  hi('MsgArea', { fg = palette.text_primary, bg = palette.none })

  hi('DiagnosticError', { fg = palette.text_secondary, bg = palette.none })
  hi('DiagnosticWarn', { fg = palette.text_muted, bg = palette.none })
  hi('DiagnosticInfo', { fg = palette.text_muted, bg = palette.none })
  hi('DiagnosticHint', { fg = palette.text_muted, bg = palette.none })

  hs('DiagnosticUnderlineError', { fg = palette.errors, bg = palette.none }, underline)
  hs('DiagnosticUnderlineWarn', { fg = palette.text_muted, bg = palette.none }, underline)
  hs('DiagnosticUnderlineInfo', { fg = palette.text_muted, bg = palette.none }, underline)
  hs('DiagnosticUnderlineHint', { fg = palette.text_muted, bg = palette.none }, underline)

  hi('NormalFloat', { fg = palette.text_primary, bg = palette.background_focus })
  hi('FloatBorder', { fg = palette.neutral_border, bg = palette.background_focus })
  hi('Whitespace', { fg = palette.neutral_border, bg = palette.none })

  hi('LspReferenceRead', { fg = palette.none, bg = palette.background_focus })
  hi('LspReferenceWrite', { fg = palette.none, bg = palette.background_focus })
  hi('LspReferenceText', { fg = palette.none, bg = palette.background_focus })
end

local function link_groups()
  -- UI: Diff
  link('DiffAdd', 'DiagnosticWarn')
  link('DiffChange', 'DiagnosticInfo')
  link('DiffDelete', 'DiagnosticError')
  link('DiffText', 'Visual')

  -- UI: search
  link('CurSearch', 'IncSearch')

  -- UI: messages
  link('Question', 'String')

  -- UI: Diagnostic
  link('DiagnosticSignError', 'DiagnosticError')
  link('DiagnosticSignWarn', 'DiagnosticWarn')
  link('DiagnosticSignInfo', 'DiagnosticInfo')
  link('DiagnosticSignHint', 'DiagnosticHint')
  link('DiagnosticFloatingError', 'DiagnosticError')
  link('DiagnosticFloatingWarn', 'DiagnosticWarn')
  link('DiagnosticFloatingInfo', 'DiagnosticInfo')
  link('DiagnosticFloatingHint', 'DiagnosticHint')
  link('DiagnosticVirtualTextError', 'DiagnosticError')
  link('DiagnosticVirtualTextWarn', 'DiagnosticWarn')
  link('DiagnosticVirtualTextInfo', 'DiagnosticInfo')
  link('DiagnosticVirtualTextHint', 'DiagnosticHint')

  -- Language: lua
  -- Syntax: built-in
  link('luaFunction', class_none)

  -- Language: HTML
  -- Syntax: built-in
  link('htmlTag', 'Special')
  link('htmlEndTag', 'Special')
  link('htmlTagName', 'Function')
  link('htmlSpecialTagName', 'Function')
  link('htmlArg', class_none)

  -- Language: CSS
  -- Syntax: built-in
  link('cssTagName', 'Function')
  link('cssColor', 'Number')
  link('cssBraces', class_none)
  link('cssSelectorOp', class_none)
  link('cssSelectorOp2', class_none)
  link('cssIdentifier', class_none)
  link('cssClassName', class_none)
  link('cssClassNameDot', class_none)
  link('cssVendor', class_none)
  link('cssImportant', class_none)
  link('cssAttributeSelector', class_none)

  -- Language: PHP
  -- Syntax: built-in
  link('phpNullValue', 'Boolean')
  link('phpSpecialFunction', 'Function')
  link('phpParent', class_none)
  link('phpClasses', class_none)

  -- Language: Javascript
  -- Syntax: built-in
  link('javaScriptNumber', 'Number')
  link('javaScriptNull', 'Number')
  link('javaScriptBraces', class_none)
  link('javaScriptFunction', class_none)

  -- Language: Javascript
  -- Syntax: 'pangloss/vim-javascript'
  link('jsFunctionKey', 'Function')
  link('jsUndefined', 'Number')
  link('jsNull', 'Number')
  link('jsSuper', class_none)
  link('jsThis', class_none)
  link('jsArguments', class_none)

  -- Language: Typescript
  -- Syntax: built-in
  link('typescriptImport', class_none)
  link('typescriptExport', class_none)
  link('typescriptBraces', class_none)
  link('typescriptDecorator', class_none)
  link('typescriptParens', class_none)
  link('typescriptCastKeyword', class_none)

  -- Language: JSX
  -- Syntax: 'maxmellon/vim-jsx-pretty'
  link('jsxTagName', 'Function')
  link('jsxComponentName', 'Function')
  link('jsxPunct', 'Special')
  link('jsxCloseString', 'Special')
  link('jsxEqual', 'Special')
  link('jsxAttrib', class_none)

  -- Treesitter (old highlight groups)
  link('TSConstructor', class_none)
  link('TSVariableBuiltin', class_none)
  link('TSConstBuiltin', 'Number')
  link('TSFuncBuiltin', 'Function')
  link('luaTSPunctBracket', class_none)
  link('TSKeywordFunction', class_none)

  -- Treesitter
  link('@function.call', 'Function')
  link('@function.builtin', 'Function')
  link('@punctuation.bracket', class_none)
  link('@constant.builtin', 'Number')
  link('@constructor', class_none)
  link('@type.css', 'Function')
  link('@constructor.php', 'Function')
  link('@method.vue', class_none)
  link('@tag.delimiter', 'Special')
  link('@tag.attribute', class_none)
  link('@tag', 'Function')
  link('@text.uri.html', 'String')

  -- LSP semantic tokens in comments
  link('@lsp.mod.documentation', 'Comment')

  -- Telescope
  link('TelescopeSelection', 'CursorLine')

  -- Snacks
  link('SnacksPickerDir', 'Special')
end

local COLORSCHEME_NAME = 'leather'

--- Initializes the colorscheme by clearing existing highlights and setting options
--- @param theme Theme
local function init(theme)
  vim.cmd 'hi clear'

  if vim.fn.exists 'syntax_on' then
    vim.cmd 'syntax reset'
  end

  vim.g.leather_theme = theme
  vim.g.colors_name = COLORSCHEME_NAME
  vim.opt.background = theme == 'light' and 'light' or 'dark'
end

local M = {}
local _opts

-- Set up autocommands to restore cursor color after terminal programs
local function configure_autocommands()
  local augroup = vim.api.nvim_create_augroup('LeatherCursorColor', { clear = true })

  vim.api.nvim_create_autocmd('BufEnter', {
    group = augroup,
    callback = function()
      -- Only restore if we're not in a terminal buffer
      if vim.bo.buftype ~= 'terminal' then
        M.restore_cursor_color()
      end
    end,
    desc = 'Restore terminal cursor color when returning from terminal',
  })
end

--- @class Options
--- @field theme Theme? Theme variant ("dark" or "light")
--- @field overrides table<Theme, table>? Optional theme-specific palette overrides (accepts partial Palette fields)

--- @param opts Options?
function M.setup(opts)
  _opts = opts or {}

  local theme = _opts.theme or palette_module.DEFAULT_THEME
  init(theme)

  palette = palette_module.create_palette(theme, _opts.overrides and _opts.overrides[theme] or {})

  highlight_syntax()
  highlight_ui()
  link_groups()
  configure_autocommands()
  set_terminal_cursor_color(palette.cursor.gui)
end

--- Restores the terminal cursor color (used by autocommands)
M.restore_cursor_color = function()
  -- Small delay to ensure terminal is ready to receive escape sequences
  vim.defer_fn(function()
    set_terminal_cursor_color(palette.cursor.gui)
  end, 10)
end

--- Toggles between dark and light themes
function M.toggle_theme()
  if not _opts then
    vim.notify('Cannot toggle theme: setup() has not been called', vim.log.levels.WARN)
    return
  end

  local new_theme = vim.g.leather_theme == 'dark' and 'light' or 'dark'
  _opts.theme = new_theme
  M.setup(_opts)
end

return M
