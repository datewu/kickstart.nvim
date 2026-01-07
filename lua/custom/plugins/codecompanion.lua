return {
  'olimorris/codecompanion.nvim',
  version = '^18.3.1',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
  },
  opts = {
    interactions = {
      chat = {
        adapter = 'gemini_cli',
      },
      inline = {
        adapter = 'gemini_cli',
      },
      cmd = {
        adapter = 'gemini_cli',
      },
      background = {
        adapter = 'gemini_cli',
      },
    },
    -- display = {
    --   chat = {
    --     icons = {
    --       chat_fold = ' ', -- use za toggle fold_reasoning
    --     },
    --     fold_reasoning = false,
    --     show_reasoning = false,
    --   },
    -- },

    adapters = {
      acp = {
        gemini_cli = function()
          return require('codecompanion.adapters').extend('gemini_cli', {
            defaults = {
              auth_method = 'gemini-api-key', -- "oauth-personal"|"gemini-api-key"|"vertex-ai"
            },
            commands = {
              default = {
                'gemini',
                '--experimental-acp',
                '--debug',
                '--model',
                'gemini-2.5-flash',
              },
            },
            env = {
              -- GEMINI_API_KEY = 'cmd:op read op://personal/Gemini_API/credential --no-newline',
              GEMINI_API_KEY = 'cmd:cat /home/r/secret/gemini.key',
            },
          })
        end,
      },
    },

    -- NOTE: The log_level is in `opts.opts`
    opts = {
      log_level = 'DEBUG',
      -- log_level = 'TRACE',
    },
  },
}
