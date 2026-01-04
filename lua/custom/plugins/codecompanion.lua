return {
  'olimorris/codecompanion.nvim',
  version = '^18.3.1',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
  },
  opts = {
    -- interactions = {
    --   chat = {
    --     adapter = {
    --       name = 'ollama',
    --       model = 'gemma3:12b',
    --     },
    --   },
    --   inline = {
    --     adapter = 'ollama',
    --     model = 'gemma3:12b',
    --   },
    --   cmd = {
    --     adapter = 'ollama',
    --     model = 'gemma3:12b',
    --   },
    --   background = {
    --     adapter = {
    --       name = 'ollama',
    --       model = 'gemma3:12b',
    --     },
    --   },
    -- },

    -- NOTE: The log_level is in `opts.opts`
    opts = {
      log_level = 'DEBUG',
    },
  },
}
