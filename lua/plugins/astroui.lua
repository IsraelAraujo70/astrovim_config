-- AstroUI provides the basis for configuring the AstroNvim User Interface
-- Configuration documentation can be found with `:h astroui`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

---@type LazySpec
return {
  {
    "navarasu/onedark.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      style = "deep",
      transparent = false,
    },
  },
  "AstroNvim/astroui",
  ---@type AstroUIOpts
  opts = {
    -- change colorscheme
    colorscheme = "onedark",
    -- AstroUI allows you to easily modify highlight groups easily for any and all colorschemes
    highlights = {
      init = { -- this table overrides highlights in all themes
        Normal = { bg = "#1f2329" },
        NormalNC = { bg = "#1f2329" },
        SignColumn = { bg = "#1f2329" },
        EndOfBuffer = { bg = "#1f2329" },
        CursorLine = { bg = "#282c34" },
        Visual = { bg = "#2c313c" },
        NormalFloat = { bg = "#23272e" },
        FloatBorder = { fg = "#4f5666", bg = "#23272e" },
        StatusLine = { bg = "#23272e" },
        WinSeparator = { fg = "#313640", bg = "#1f2329" },
      },
      onedark = {
        Comment = { fg = "#6b7280", italic = true },
        CursorLineNr = { fg = "#8fb4d8", bold = true },
        Directory = { fg = "#8fb4d8" },
      },
    },
    -- Icons can be configured throughout the interface
    icons = {
      -- configure the loading of the lsp in the status line
      LSPLoading1 = "⠋",
      LSPLoading2 = "⠙",
      LSPLoading3 = "⠹",
      LSPLoading4 = "⠸",
      LSPLoading5 = "⠼",
      LSPLoading6 = "⠴",
      LSPLoading7 = "⠦",
      LSPLoading8 = "⠧",
      LSPLoading9 = "⠇",
      LSPLoading10 = "⠏",
    },
  },
}
