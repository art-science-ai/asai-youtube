-- ~/.config/nvim/lua/plugins/codecompanion.lua (for lazy.nvim)
return {
  "olimorris/codecompanion.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
    -- make Gemini CLI the default everywhere (tweak per-strategy below if you want)
    strategies = {
      chat   = { adapter = "gemini_cli" },
      inline = { adapter = "gemini_cli" },
      cmd    = { adapter = "gemini_cli" },
    },

    adapters = {
      acp = {
        gemini_cli = function()
          return require("codecompanion.adapters").extend("gemini_cli", {
            -- Use the installed binary; ACP flag is still experimental in many builds
            commands = {
              default = { npx, "--yes", "@google/gemini-cli", "--experimental-acp" },
            },
            defaults = {
              -- Pick one auth method:
              -- "oauth-personal" | "gemini-api-key" | "vertex-ai"
              auth_method = "oauth-personal",
              timeout = 20000,
              -- Optional: if you want to inject MCPs directly from here (you can
              -- also manage them in ~/.gemini/settings.json via the CLI):
              -- mcpServers = { github = { command = "gh-mcp", args = {} } },
            },
            env = {
              -- If using API key auth:
              -- GEMINI_API_KEY = "GEMINI_API_KEY",
            },
          })
        end,
      },
    },

    -- Helpful to debug any handshake issues
    opts = { log_level = "DEBUG" },
  },
}
