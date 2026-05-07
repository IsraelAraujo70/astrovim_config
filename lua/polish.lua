-- nvim 0.12.x bug: vim.treesitter.get_range crashes on degraded node (nil or
-- a non-userdata value lacking :range()) when query iteration yields a missing
-- capture. Affects the built-in highlighter, snacks.scope, vim-illuminate,
-- aerial, etc. Guard at the source.
do
  local ts = require "vim.treesitter"
  local orig_get_range = ts.get_range
  ts.get_range = function(node, source, metadata)
    if metadata and metadata.range then
      return orig_get_range(node, source, metadata)
    end
    if type(node) ~= "userdata" then
      return { 0, 0, 0, 0, 0, 0 }
    end
    return orig_get_range(node, source, metadata)
  end
end

if vim.fn.executable "codex" == 1 then
  local bun_bin = vim.fn.expand "~/.bun/bin"
  if not vim.env.PATH:match(vim.pesc(bun_bin)) then vim.env.PATH = bun_bin .. ":" .. vim.env.PATH end
end

require("theme_selector").apply_saved()

vim.api.nvim_create_user_command("ThemeSelect", function() require("theme_selector").select() end, {})

vim.keymap.set("n", "<Leader>uT", function() require("theme_selector").select() end, {
  desc = "Select Theme",
})
