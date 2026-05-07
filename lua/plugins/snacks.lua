---@type LazySpec
return {
  {
    "folke/snacks.nvim",
    opts = function(_, opts)
      opts.scope = opts.scope or {}
      opts.scope.treesitter = vim.tbl_deep_extend("force", opts.scope.treesitter or {}, {
        injections = false,
      })

      -- Inline images in markdown (Kitty graphics protocol — works in Warp).
      -- `force = true` bypasses terminal sniffing: snacks knows kitty/wezterm/
      -- ghostty by default, Warp isn't in that list but supports the protocol.
      -- Needs `magick` (ImageMagick) for SVG/PDF/Mermaid; PNG/JPG work without.
      opts.image = vim.tbl_deep_extend("force", opts.image or {}, {
        enabled = true,
        force = true,
        doc = { enabled = true, inline = true, float = true },
      })

      -- Smooth scrolling.
      opts.scroll = vim.tbl_deep_extend("force", opts.scroll or {}, {
        enabled = true,
      })
    end,
  },
}
