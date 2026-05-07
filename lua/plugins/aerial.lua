---@type LazySpec
return {
  {
    "stevearc/aerial.nvim",
    version = false, -- AstroNvim pins ^2.2; we need 3.x for the iter_matches fix on nvim 0.12
    opts = {
      backends = {
        ["_"] = { "treesitter", "lsp", "markdown", "asciidoc", "man" },
        markdown = { "markdown", "lsp" },
      },
    },
    config = function(_, opts)
      vim.notify("[aerial] applying nil-node guard", vim.log.levels.INFO)
      local helpers = require "aerial.backends.treesitter.helpers"
      local orig = helpers.range_from_nodes
      helpers.range_from_nodes = function(start_node, end_node)
        if type(start_node) ~= "userdata" or type(end_node) ~= "userdata" then
          return { lnum = 1, end_lnum = 1, col = 0, end_col = 0 }
        end
        return orig(start_node, end_node)
      end
      require("aerial").setup(opts)
    end,
  },
}
