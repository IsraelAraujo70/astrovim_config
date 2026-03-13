local function feed(keys)
  vim.api.nvim_feedkeys(vim.keycode(keys), "n", false)
end

local function save_buffer()
  vim.cmd "silent! update!"
  vim.cmd.redraw()
end

local function select_all()
  feed("<Esc>ggVG")
end

local function undo()
  local mode = vim.api.nvim_get_mode().mode
  if mode:sub(1, 1) == "i" then
    feed("<C-o>u")
  else
    feed("u")
  end
end

local function redo()
  local mode = vim.api.nvim_get_mode().mode
  if mode:sub(1, 1) == "i" then
    feed("<C-o><C-r>")
  else
    feed("<C-r>")
  end
end

---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = function(_, opts)
    opts.mappings = opts.mappings or {}
    opts.mappings.n = opts.mappings.n or {}
    opts.mappings.i = opts.mappings.i or {}

    opts.mappings.n["<C-S>"] = { save_buffer, desc = "Save file" }
    opts.mappings.i["<C-S>"] = { save_buffer, desc = "Save file" }

    opts.mappings.n["<C-A>"] = { select_all, desc = "Select whole buffer" }
    opts.mappings.i["<C-A>"] = { select_all, desc = "Select whole buffer" }

    opts.mappings.n["<C-Z>"] = { undo, desc = "Undo" }
    opts.mappings.i["<C-Z>"] = { undo, desc = "Undo" }

    opts.mappings.n["<C-Y>"] = { redo, desc = "Redo" }
    opts.mappings.i["<C-Y>"] = { redo, desc = "Redo" }
    opts.mappings.n["<C-S-Z>"] = { redo, desc = "Redo" }
    opts.mappings.i["<C-S-Z>"] = { redo, desc = "Redo" }
  end,
}
