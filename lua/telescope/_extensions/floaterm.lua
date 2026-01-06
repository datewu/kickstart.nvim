-- ~/.config/nvim/lua/telescope/_extensions/floaterm.lua
local pickers = require 'telescope.pickers'
local finders = require 'telescope.finders'
local actions = require 'telescope.actions'
local action_state = require 'telescope.actions.state'
local conf = require('telescope.config').values

-- Import our core logic module (the file we built earlier)
local floaterm_logic = require 'custom.floaterm'

local terminal_picker = function(opts)
  opts = opts or {}
  pickers
    .new(opts, {
      prompt_title = 'Floating Terminals (Enter: Open | Ctrl-d: Kill)',
      finder = finders.new_table {
        results = floaterm_logic.get_terminal_names(),
      },
      sorter = conf.generic_sorter(opts),
      attach_mappings = function(prompt_bufnr, map)
        -- Action: Open the terminal
        actions.select_default:replace(function()
          actions.close(prompt_bufnr)
          local selection = action_state.get_selected_entry()
          if selection then
            floaterm_logic.toggle_terminal(selection[1])
          end
        end)

        -- Action: Kill the terminal (Mapped to <C-d>)
        map('i', '<C-d>', function()
          local selection = action_state.get_selected_entry()
          if selection then
            floaterm_logic.kill_terminal(selection[1])
            -- Refresh the picker list after killing
            local current_picker = action_state.get_current_picker(prompt_bufnr)
            current_picker:refresh(finders.new_table {
              results = floaterm_logic.get_terminal_names(),
            })
          end
        end)

        return true
      end,
    })
    :find()
end

return require('telescope').register_extension {
  exports = {
    floaterm = terminal_picker,
    toggle_last = floaterm_logic.toggle_last,
  },
}
