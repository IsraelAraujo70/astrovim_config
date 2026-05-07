---@type LazySpec
return {
  {
    "folke/snacks.nvim",
    opts = function(_, opts)
      opts.scope = opts.scope or {}
      opts.scope.treesitter = vim.tbl_deep_extend("force", opts.scope.treesitter or {}, {
        injections = false,
      })
    end,
  },
}
