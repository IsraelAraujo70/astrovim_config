---@type LazySpec
return {
  {
    "kkrampis/codex.nvim",
    cmd = { "Codex", "CodexToggle" },
    keys = {
      {
        "<Leader>cc",
        function() require("codex").toggle() end,
        desc = "Toggle Codex",
        mode = { "n", "t" },
      },
    },
    config = function(_, opts)
      require("codex_layout").setup(opts)
    end,
    opts = function()
      return {
        autoinstall = false,
        border = "rounded",
        panel = true,
        width = 0.45,
        height = 0.9,
        use_buffer = false,
        keymaps = {
          toggle = nil,
          quit = "<C-q>",
        },
      }
    end,
  },
}
