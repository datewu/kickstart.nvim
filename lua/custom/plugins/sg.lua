-- Use your favorite package manager to install, for example in lazy.nvim
--  Optionally, you can also install nvim-telescope/telescope.nvim to use some search functionality.
return {
  'sourcegraph/sg.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim', --[[ "nvim-telescope/telescope.nvim ]]
  },
  lazy = false, --
  -- opts = {
  --   chat = {
  --     default_model = 'anthropic/claude-3-5-sonnet-20241022',
  --   },
  -- },
  opts = {
    chat = {
      default_model = 'anthropic/claude-3-7-sonnet-20250219',
    },
  },

  -- If you have a recent version of lazy.nvim, you don't need to add this!
  --  build = 'nvim -l build/init.lua',
}
