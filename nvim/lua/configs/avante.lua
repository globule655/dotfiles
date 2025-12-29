local avante_opts = {
  -- add any opts here
  ---@alias Provider "claude" | "openai" | "azure" | "gemini" | "cohere" | "copilot" | string
  -- WARNING: Since auto-suggestions are a high-frequency operation and therefore expensive,
  -- currently designating it as `copilot` provider is dangerous because: https://github.com/yetone/avante.nvim/issues/1048
  -- Of course, you can reduce the request frequency by increasing `suggestion.debounce`.
  auto_suggestions_provider = "claude",
  cursor_applying_provider = nil, -- The provider used in the applying phase of Cursor Planning Mode, defaults to nil, when nil uses Config.provider as the provider for the applying phase
  input = {
    provider = "snacks", -- "native" | "dressing" | "snacks"
    provider_opts = {
      -- Snacks input configuration
      title = "Avante Input",
      icon = " ",
      placeholder = "Enter your API key...",
    },
  },
  instructions_file = "avante.md",
  provider = "claude",
  mode = "legacy",
  -- dual_boost = {
  --   enabled = true,
  --   first_provider = "gemini",
  --   second_provider = "claude",
  --   -- Optional: customize the prompt for the second provider
  --   second_provider_prompt = "Review and enhance the previous response",
  --   timeout = 60000, -- Total timeout for both providers in milliseconds
  -- },
  system_prompt = function()
    local hub = require("mcphub").get_hub_instance()
    return hub and hub:get_active_servers_prompt() or ""
  end,
  -- Using function prevents requiring mcphub before it's loaded
  custom_tools = function()
    return {
      require("mcphub.extensions.avante").mcp_tool(),
    }
  end,
  providers = {
    claude = {
      endpoint = "https://api.anthropic.com",
      model = "claude-sonnet-4-5-20250929",
      timeout = 30000, -- Timeout in milliseconds
      extra_request_body = {
        temperature = 0.75,
        max_tokens = 20480,
      },
    },
    gemini = {
      model = "gemini-2.5-pro", -- Or "gemini-1.5-pro"
      temperature = 0,
      max_tokens = 4096,
    },
  },
}

return avante_opts
