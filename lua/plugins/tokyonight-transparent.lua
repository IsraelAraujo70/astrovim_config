-- Tokyo Night with transparent background for Warp terminal
return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      style = "night",
      transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
    },
  },
  {
    "AstroNvim/astroui",
    opts = {
      colorscheme = "tokyonight-night",
    },
  },
}
