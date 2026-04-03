local current_win = nil
local current_job = nil

local function get_visual_selection()
  local start_pos = vim.fn.getpos "'<"
  local end_pos = vim.fn.getpos "'>"
  local start_line = start_pos[2]
  local end_line = end_pos[2]
  local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)
  return table.concat(lines, "\n")
end

local function close_existing()
  if current_job then
    pcall(vim.fn.jobstop, current_job)
    current_job = nil
  end
  if current_win and current_win:valid() then
    current_win:close()
    current_win = nil
  end
end

local function explain_with_claude(prompt)
  if vim.fn.executable "claude" ~= 1 then
    vim.notify("Claude CLI nao encontrado. Instale com: npm i -g @anthropic-ai/claude-code", vim.log.levels.ERROR)
    return
  end

  close_existing()

  local win = Snacks.win {
    position = "right",
    width = 0.4,
    border = "rounded",
    title = " Claude: Explain ",
    title_pos = "center",
    enter = true,
    ft = "markdown",
    bo = { modifiable = true, buftype = "nofile" },
    wo = { wrap = true, linebreak = true },
    keys = {
      q = "close",
      ["<Esc>"] = "close",
    },
  }
  current_win = win

  local buf = win.buf
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, { "Pensando..." })

  local output = {}
  current_job = vim.fn.jobstart({ "claude", "-p", prompt }, {
    stdout_buffered = true,
    on_stdout = function(_, data)
      if data then
        for _, line in ipairs(data) do
          table.insert(output, line)
        end
      end
    end,
    on_exit = function(_, exit_code)
      current_job = nil
      vim.schedule(function()
        if not win:valid() then return end
        if exit_code ~= 0 then
          vim.api.nvim_buf_set_lines(buf, 0, -1, false, { "Erro ao executar claude (exit " .. exit_code .. ")" })
          return
        end
        -- remove trailing empty lines
        while #output > 0 and output[#output] == "" do
          table.remove(output)
        end
        if #output == 0 then
          output = { "Sem resposta do Claude." }
        end
        vim.bo[buf].modifiable = true
        vim.api.nvim_buf_set_lines(buf, 0, -1, false, output)
        vim.bo[buf].modifiable = false
      end)
    end,
  })
end

local function explain_normal()
  local cursor_line = vim.fn.line "."
  local total_lines = vim.api.nvim_buf_line_count(0)
  local ft = vim.bo.filetype
  local filename = vim.fn.expand "%:t"

  -- pega ~250 linhas acima e abaixo do cursor
  local start_line = math.max(1, cursor_line - 250)
  local end_line = math.min(total_lines, cursor_line + 250)
  local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)
  local code = table.concat(lines, "\n")

  local prompt = string.format(
    "Voce esta lendo o arquivo '%s' (%s). O cursor esta na linha %d (a linha %d no trecho abaixo). "
      .. "Identifique a funcao ou metodo que contem essa linha e explique como ela funciona de forma clara e concisa. "
      .. "Responda em portugues.\n\n```%s\n%s\n```",
    filename,
    ft,
    cursor_line,
    cursor_line - start_line + 1,
    ft,
    code
  )
  explain_with_claude(prompt)
end

local function explain_visual()
  local selection = get_visual_selection()
  if selection == "" then
    vim.notify("Nenhum codigo selecionado", vim.log.levels.WARN)
    return
  end

  local ft = vim.bo.filetype
  local prompt = string.format(
    "Explique como esse codigo %s funciona de forma clara e concisa. Responda em portugues.\n\n```%s\n%s\n```",
    ft,
    ft,
    selection
  )
  explain_with_claude(prompt)
end

---@type LazySpec
return {
  "AstroNvim/astrocore",
  opts = function(_, opts)
    opts.mappings = opts.mappings or {}
    opts.mappings.n = opts.mappings.n or {}
    opts.mappings.v = opts.mappings.v or {}

    opts.mappings.n["<Leader>ce"] = { explain_normal, desc = "Claude: Explain function" }
    opts.mappings.v["<Leader>ce"] = { explain_visual, desc = "Claude: Explain selection" }
  end,
}
