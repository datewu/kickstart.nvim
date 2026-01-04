return {
  'github/copilot.vim',
  version = '^1.58.0',

  -- When Lazy sees opts, it assumes the plugin is a Lua-based plugin and
  -- tries to run: require("copilot").setup(opts)

  -- Since github/copilot.vim is a Vimscript plugin, there is
  -- no lua/copilot.lua with a setup function, which results in the attempt to
  -- call field 'setup' (a nil value) error.
  -- NOTE: The log_level is in `opts.opts`
  -- opts = {
  --   log_level = 'DEBUG',
  -- },
  init = function()
    -- Use vim.g to set Vimscript variables
    vim.g.copilot_log_level = 'DEBUG'
  end,
}
