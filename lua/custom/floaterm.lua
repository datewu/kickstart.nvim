-- ~/.config/nvim/lua/custom/floaterm.lua
local M = {}

-- State management: Stores terminal data and the last accessed ID
local state = {
  terminals = {}, -- Dictionary: { ["name"] = { buf = <nr>, win = <nr> } }
  last_id = nil, -- Keeps track of the most recently used terminal ID
}

--- Private helper: Calculates center position and creates the floating window
--- @param opts table: contains buf (buffer handle) and id (terminal name)
local function create_floating_window(opts)
  opts = opts or {}
  local id = opts.id or 'default'

  -- Calculate 80% of the screen size
  local width = math.floor(vim.o.columns * 0.8)
  local height = math.floor(vim.o.lines * 0.8)

  -- Calculate starting position to center the window
  local col = math.floor((vim.o.columns - width) / 2)
  local row = math.floor((vim.o.lines - height) / 2)

  -- Create or reuse buffer
  local buf = opts.buf
  if not vim.api.nvim_buf_is_valid(buf) then
    buf = vim.api.nvim_create_buf(false, true) -- Create a scratch buffer
  end

  -- Window configuration
  local win_config = {
    relative = 'editor',
    width = width,
    height = height,
    col = col,
    row = row,
    style = 'minimal',
    border = 'rounded',
    title = ' Terminal: ' .. tostring(id) .. ' ',
    title_pos = 'center',
  }

  -- Open the window and return the handles
  local win = vim.api.nvim_open_win(buf, true, win_config)
  return { buf = buf, win = win }
end

--- Toggles a terminal by its name. Opens if hidden, hides if open.
--- @param id string: The unique name for the terminal
M.toggle_terminal = function(id)
  if not id or id == '' then
    return
  end

  state.last_id = id
  local term = state.terminals[id] or { buf = -1, win = -1 }

  -- If the window is currently open and valid, hide it
  if vim.api.nvim_win_is_valid(term.win) then
    vim.api.nvim_win_hide(term.win)
    return
  end

  -- Otherwise, open/create the window
  term = create_floating_window { buf = term.buf, id = id }
  state.terminals[id] = term

  -- If the buffer isn't a terminal yet, initialize the shell
  if vim.bo[term.buf].buftype ~= 'terminal' then
    vim.cmd.term()
  end

  -- Enter insert mode immediately
  vim.cmd 'startinsert'
end

--- Closes the window and deletes the buffer (kills the process)
--- @param id string: The unique name for the terminal
M.kill_terminal = function(id)
  local term = state.terminals[id]
  if not term then
    return
  end

  -- Close window if open
  if vim.api.nvim_win_is_valid(term.win) then
    vim.api.nvim_win_close(term.win, true)
  end

  -- Delete buffer (this kills the underlying shell process)
  if vim.api.nvim_buf_is_valid(term.buf) then
    vim.api.nvim_buf_delete(term.buf, { force = true })
  end

  -- Clean up state
  state.terminals[id] = nil
  if state.last_id == id then
    state.last_id = nil
  end
  print('Killed terminal: ' .. id)
end

--- Toggles the most recently accessed terminal
M.toggle_last = function()
  if state.last_id then
    M.toggle_terminal(state.last_id)
  else
    print 'No active terminals.'
  end
end

--- Returns a list of all active terminal IDs for Telescope
--- @return table: List of strings
M.get_terminal_names = function()
  local names = {}
  for id, _ in pairs(state.terminals) do
    table.insert(names, id)
  end
  table.sort(names)
  return names
end

return M
