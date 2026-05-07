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

      opts.current_line_blame = true
      opts.current_line_blame_opts = vim.tbl_deep_extend("force", opts.current_line_blame_opts or {}, {
        virt_text = true,
        virt_text_pos = "eol",
        delay = 300,
        ignore_whitespace = false,
      })
      opts.current_line_blame_formatter = "  <author>, <author_time:%R> · <summary>"

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
