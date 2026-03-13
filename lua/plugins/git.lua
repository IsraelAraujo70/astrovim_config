---@type LazySpec
return {
  {
    "sindrets/diffview.nvim",
    cmd = {
      "DiffviewOpen",
      "DiffviewClose",
      "DiffviewFileHistory",
      "DiffviewFocusFiles",
      "DiffviewToggleFiles",
      "DiffviewRefresh",
    },
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  {
    "AstroNvim/astrocore",
    optional = true,
    opts = function(_, opts)
      opts.mappings = opts.mappings or {}
      opts.mappings.n = opts.mappings.n or {}
      opts.mappings.n["<Leader>gd"] = { "<Cmd>DiffviewOpen<CR>", desc = "Open Diffview" }
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    optional = true,
    opts = function(_, opts)
      local old_on_attach = opts.on_attach

      opts.on_attach = function(bufnr)
        if old_on_attach then old_on_attach(bufnr) end

        pcall(vim.keymap.del, "n", "<Leader>gd", { buffer = bufnr })
        vim.keymap.set("n", "<Leader>gd", "<Cmd>DiffviewOpen<CR>", {
          buffer = bufnr,
          desc = "Open Diffview",
          silent = true,
        })
      end
    end,
  },
}
