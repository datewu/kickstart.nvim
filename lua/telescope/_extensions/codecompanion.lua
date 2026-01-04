local pickers = require 'telescope.pickers'
local finders = require 'telescope.finders'
local actions = require 'telescope.actions'
local action_state = require 'telescope.actions.state'
local conf = require('telescope.config').values

local codecompanion_actions = {
  'explain',
  'review',
  'test',
  'fix',
  'scaffold',
  'find',
  'testfix',
  'help',
}

local function run_codecompanion_action(action)
  vim.cmd('CodeCompanion ' .. action)
end

local function run_codecompanion_chat(action)
  vim.cmd 'CodeCompanionChat'
end

local codecompanion_picker = function(opts)
  opts = opts or {}
  pickers
    .new(opts, {
      prompt_title = 'CodeCompanion Actions',
      finder = finders.new_table {
        results = codecompanion_actions,
      },
      sorter = conf.generic_sorter(opts),
      attach_mappings = function(prompt_bufnr, map)
        actions.select_default:replace(function()
          actions.close(prompt_bufnr)
          local selection = action_state.get_selected_entry()
          run_codecompanion_action(selection[1])
        end)
        return true
      end,
    })
    :find()
end

return require('telescope').register_extension {
  exports = {
    codecompanion = codecompanion_picker,
    chat = run_codecompanion_chat,
  },
}
