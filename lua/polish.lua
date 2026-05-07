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

-- Diagnostics como virtual_lines (igual Zed): erro completo embaixo da linha do
-- cursor em vez de cortado na ponta. `current_line = true` mostra só da linha
-- atual pra não poluir.
vim.diagnostic.config {
  virtual_lines = { current_line = true },
  virtual_text = false,
  update_in_insert = false,
  severity_sort = true,
}

-- Inlay hints do LSP: tipos e nomes de parâmetros inline.
vim.api.nvim_create_autocmd("LspAttach", {
  desc = "Enable LSP inlay hints",
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client and client.server_capabilities.inlayHintProvider then
      vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
    end
  end,
})

if vim.fn.executable "codex" == 1 then
  local bun_bin = vim.fn.expand "~/.bun/bin"
  if not vim.env.PATH:match(vim.pesc(bun_bin)) then vim.env.PATH = bun_bin .. ":" .. vim.env.PATH end
end

require("theme_selector").apply_saved()

vim.api.nvim_create_user_command("ThemeSelect", function() require("theme_selector").select() end, {})

vim.keymap.set("n", "<Leader>uT", function() require("theme_selector").select() end, {
  desc = "Select Theme",
})
