if vim.fn.executable "codex" == 1 then
  local bun_bin = vim.fn.expand "~/.bun/bin"
  if not vim.env.PATH:match(vim.pesc(bun_bin)) then vim.env.PATH = bun_bin .. ":" .. vim.env.PATH end
end

require("theme_selector").apply_saved()

vim.api.nvim_create_user_command("ThemeSelect", function() require("theme_selector").select() end, {})

vim.keymap.set("n", "<Leader>uT", function() require("theme_selector").select() end, {
  desc = "Select Theme",
})
