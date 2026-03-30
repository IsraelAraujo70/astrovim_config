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
    -- clipboard do sistema
    opts.options = opts.options or {}
    opts.options.opt = opts.options.opt or {}
    opts.options.opt.clipboard = "unnamedplus"

    opts.mappings = opts.mappings or {}
    opts.mappings.n = opts.mappings.n or {}
    opts.mappings.i = opts.mappings.i or {}
    opts.mappings.v = opts.mappings.v or {}

    -- salvar
    opts.mappings.n["<C-S>"] = { save_buffer, desc = "Save file" }
    opts.mappings.i["<C-S>"] = { save_buffer, desc = "Save file" }

    -- selecionar tudo
    opts.mappings.n["<C-A>"] = { select_all, desc = "Select whole buffer" }
    opts.mappings.i["<C-A>"] = { select_all, desc = "Select whole buffer" }

    -- undo / redo
    opts.mappings.n["<C-Z>"] = { undo, desc = "Undo" }
    opts.mappings.i["<C-Z>"] = { undo, desc = "Undo" }
    opts.mappings.n["<C-Y>"] = { redo, desc = "Redo" }
    opts.mappings.i["<C-Y>"] = { redo, desc = "Redo" }
    opts.mappings.n["<C-S-Z>"] = { redo, desc = "Redo" }
    opts.mappings.i["<C-S-Z>"] = { redo, desc = "Redo" }

    -- copiar / colar
    opts.mappings.v["<C-C>"] = { "y", desc = "Copy" }
    opts.mappings.n["<C-V>"] = { '"+P', desc = "Paste" }
    opts.mappings.i["<C-V>"] = { "<C-r>+", desc = "Paste" }

    -- buscar em arquivos (grep)
    opts.mappings.n["<Leader>fr"] = { function() require("snacks").picker.grep() end, desc = "Search in files" }

    -- abrir arquivo por nome
    opts.mappings.n["<C-P>"] = { function() require("snacks").picker.files() end, desc = "Find files" }

    -- command palette
    opts.mappings.n["<C-S-P>"] = { function() require("snacks").picker.commands() end, desc = "Command palette" }

    -- buscar no arquivo atual
    opts.mappings.n["<C-F>"] = { function() require("snacks").picker.lines() end, desc = "Search in file" }
    opts.mappings.i["<C-F>"] = { function() require("snacks").picker.lines() end, desc = "Search in file" }

    -- toggle comentario
    opts.mappings.n["<C-/>"] = { "gcc", remap = true, desc = "Toggle comment" }
    opts.mappings.v["<C-/>"] = { "gc", remap = true, desc = "Toggle comment" }
    opts.mappings.i["<C-/>"] = { "<Esc>gcci", remap = true, desc = "Toggle comment" }
  end,
}
