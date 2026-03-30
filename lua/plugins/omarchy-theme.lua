-- Omarchy theme sync adapter for AstroNvim
-- Reads the active Omarchy theme and translates it to AstroUI format
local theme_file = vim.fn.expand("~/.config/omarchy/current/theme/neovim.lua")
local specs = {}

if vim.fn.filereadable(theme_file) == 1 then
  local ok, theme_spec = pcall(dofile, theme_file)
  if ok and type(theme_spec) == "table" then
    local colorscheme = nil

    for _, spec in ipairs(theme_spec) do
      if spec[1] == "LazyVim/LazyVim" and spec.opts and spec.opts.colorscheme then
        colorscheme = spec.opts.colorscheme
      elseif spec[1] then
        spec.lazy = false
        spec.priority = 1000
        table.insert(specs, spec)
      end
    end

    if colorscheme then
      table.insert(specs, {
        "AstroNvim/astroui",
        opts = { colorscheme = colorscheme },
      })
    end
  end
end

-- Pre-load all Omarchy theme plugins for availability
local all_themes = {
  { "ribru17/bamboo.nvim", lazy = true, priority = 1000 },
  { "bjarneo/aether.nvim", lazy = true, priority = 1000 },
  { "bjarneo/ethereal.nvim", lazy = true, priority = 1000 },
  { "bjarneo/hackerman.nvim", lazy = true, priority = 1000 },
  { "bjarneo/vantablack.nvim", lazy = true, priority = 1000 },
  { "bjarneo/white.nvim", lazy = true, priority = 1000 },
  { "catppuccin/nvim", name = "catppuccin", lazy = true, priority = 1000 },
  { "sainnhe/everforest", lazy = true, priority = 1000 },
  { "kepano/flexoki-neovim", lazy = true, priority = 1000 },
  { "ellisonleao/gruvbox.nvim", lazy = true, priority = 1000 },
  { "rebelot/kanagawa.nvim", lazy = true, priority = 1000 },
  { "tahayvr/matteblack.nvim", lazy = true, priority = 1000 },
  { "loctvl842/monokai-pro.nvim", lazy = true, priority = 1000 },
  { "shaunsingh/nord.nvim", lazy = true, priority = 1000 },
  { "EdenEast/nightfox.nvim", lazy = true, priority = 1000 },
  { "rose-pine/neovim", name = "rose-pine", lazy = true, priority = 1000 },
  { "folke/tokyonight.nvim", lazy = true, priority = 1000 },
  { "xero/miasma.nvim", lazy = true, priority = 1000 },
}

for _, t in ipairs(all_themes) do
  table.insert(specs, t)
end

return specs
