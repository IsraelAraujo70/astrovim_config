local M = {}

local colors = {
  bg = "#1a1a1a",
  bg_dark = "#151515",
  bg_lighter = "#252525",
  bg_highlight = "#2a2a2a",
  fg = "#d4d4d4",
  fg_dark = "#a0a0a0",
  fg_gutter = "#4a4a4a",
  cyan = "#4fc1ff",
  blue = "#9cdcfe",
  blue_muted = "#7f9db9",
  yellow = "#dcdcaa",
  orange = "#ce9178",
  pink = "#c586c0",
  purple = "#b48ead",
  red = "#f44747",
  border = "#3a3a3a",
  selection = "#264f78",
  git_add = "#73c7ff",
  git_change = "#e2c08d",
  git_delete = "#c74e39",
}

local function set_hl(group, opts) vim.api.nvim_set_hl(0, group, opts) end

function M.apply()
  vim.cmd.hi "clear"
  if vim.fn.exists "syntax_on" == 1 then vim.cmd.syntax "reset" end
  vim.o.termguicolors = true
  vim.g.colors_name = "cursor-dark"

  set_hl("Normal", { fg = colors.fg, bg = colors.bg })
  set_hl("NormalNC", { fg = colors.fg, bg = colors.bg })
  set_hl("NormalFloat", { fg = colors.fg, bg = colors.bg_dark })
  set_hl("FloatBorder", { fg = colors.border, bg = colors.bg_dark })
  set_hl("CursorLine", { bg = colors.bg_highlight })
  set_hl("CursorLineNr", { fg = colors.yellow, bold = true })
  set_hl("LineNr", { fg = colors.fg_gutter })
  set_hl("SignColumn", { fg = colors.fg_gutter, bg = colors.bg })
  set_hl("StatusLine", { fg = colors.fg, bg = colors.bg_lighter })
  set_hl("StatusLineNC", { fg = colors.fg_dark, bg = colors.bg_dark })
  set_hl("WinSeparator", { fg = colors.border, bg = colors.bg })
  set_hl("Visual", { bg = colors.selection })
  set_hl("Pmenu", { fg = colors.fg, bg = colors.bg_lighter })
  set_hl("PmenuSel", { fg = colors.fg, bg = colors.selection })
  set_hl("Search", { fg = colors.bg, bg = colors.yellow })
  set_hl("IncSearch", { fg = colors.bg, bg = colors.orange })
  set_hl("Comment", { fg = colors.blue_muted, italic = true })
  set_hl("String", { fg = colors.orange })
  set_hl("Number", { fg = colors.purple })
  set_hl("Boolean", { fg = colors.purple })
  set_hl("Identifier", { fg = colors.blue })
  set_hl("Function", { fg = colors.yellow })
  set_hl("Keyword", { fg = colors.cyan })
  set_hl("Statement", { fg = colors.cyan })
  set_hl("Type", { fg = colors.cyan })
  set_hl("Directory", { fg = colors.cyan })
  set_hl("DiagnosticError", { fg = colors.red })
  set_hl("DiagnosticWarn", { fg = colors.yellow })
  set_hl("DiagnosticInfo", { fg = colors.blue })
  set_hl("DiagnosticHint", { fg = colors.cyan })
  set_hl("GitSignsAdd", { fg = colors.git_add })
  set_hl("GitSignsChange", { fg = colors.git_change })
  set_hl("GitSignsDelete", { fg = colors.git_delete })

  set_hl("@comment", { link = "Comment" })
  set_hl("@string", { link = "String" })
  set_hl("@number", { link = "Number" })
  set_hl("@boolean", { link = "Boolean" })
  set_hl("@variable", { fg = colors.blue })
  set_hl("@function", { link = "Function" })
  set_hl("@keyword", { link = "Keyword" })
  set_hl("@type", { link = "Type" })
  set_hl("@property", { fg = colors.blue })
end

return M
