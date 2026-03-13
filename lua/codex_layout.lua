local M = {}

local defaults = {
  panel = false,
  width = 0.45,
}

local function is_valid_win(win)
  return type(win) == "number" and vim.api.nvim_win_is_valid(win)
end

local function move_panel_left(width_ratio)
  local state = require "codex.state"
  if not is_valid_win(state.win) then return end

  vim.api.nvim_set_current_win(state.win)
  vim.cmd "wincmd H"

  local width = math.max(20, math.floor(vim.o.columns * width_ratio))
  vim.api.nvim_win_set_width(state.win, width)
end

function M.setup(opts)
  local config = vim.tbl_deep_extend("force", defaults, opts or {})
  local codex = require "codex"

  codex.setup(config)

  if not config.panel then return end

  local raw_open = codex.open
  local raw_close = codex.close

  codex.open = function(...)
    raw_open(...)
    move_panel_left(config.width)
  end

  codex.toggle = function()
    local state = require "codex.state"
    if is_valid_win(state.win) then
      raw_close()
    else
      codex.open()
    end
  end
end

return M
