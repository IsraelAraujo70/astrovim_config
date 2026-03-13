local M = {}

local state_file = vim.fn.stdpath "state" .. "/theme-selector.json"

local themes = {
  {
    id = "cursor-dark",
    label = "Cursor Dark",
    colorscheme = "cursor-dark",
  },
  {
    id = "onedark-deep",
    label = "One Dark Deep",
    colorscheme = "onedark",
    onedark = { style = "deep", transparent = false },
  },
  {
    id = "onedark-darker",
    label = "One Dark Darker",
    colorscheme = "onedark",
    onedark = { style = "darker", transparent = false },
  },
  {
    id = "onedark-cool",
    label = "One Dark Cool",
    colorscheme = "onedark",
    onedark = { style = "cool", transparent = false },
  },
  {
    id = "onedark-warm",
    label = "One Dark Warm",
    colorscheme = "onedark",
    onedark = { style = "warm", transparent = false },
  },
  {
    id = "astrodark",
    label = "AstroDark",
    colorscheme = "astrodark",
  },
}

local default_theme = themes[1]

local function read_state()
  local ok, lines = pcall(vim.fn.readfile, state_file)
  if not ok or not lines or #lines == 0 then return nil end

  local decoded_ok, decoded = pcall(vim.json.decode, table.concat(lines, "\n"))
  if not decoded_ok or type(decoded) ~= "table" then return nil end
  return decoded
end

local function write_state(theme)
  local payload = vim.json.encode { id = theme.id }
  vim.fn.writefile({ payload }, state_file)
end

local function find_theme(id)
  for _, theme in ipairs(themes) do
    if theme.id == id then return theme end
  end
  return nil
end

function M.apply(theme, persist)
  if theme.onedark then
    local ok, onedark = pcall(require, "onedark")
    if ok then onedark.setup(theme.onedark) end
  end

  local ok, err = pcall(vim.cmd.colorscheme, theme.colorscheme)
  if not ok then
    vim.notify("Failed to load theme " .. theme.label .. ": " .. tostring(err), vim.log.levels.ERROR)
    return
  end

  if persist then write_state(theme) end
end

function M.apply_saved()
  local state = read_state()
  local theme = state and find_theme(state.id) or default_theme
  M.apply(theme, false)
end

function M.select()
  vim.ui.select(themes, {
    prompt = "Select Theme",
    format_item = function(item) return item.label end,
  }, function(choice)
    if not choice then return end
    M.apply(choice, true)
    vim.notify("Theme set to " .. choice.label, vim.log.levels.INFO)
  end)
end

return M
