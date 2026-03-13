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
    opts = {
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
    },
  },
}
