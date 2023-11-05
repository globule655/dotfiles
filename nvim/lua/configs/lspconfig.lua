local on_attach = require("plug_configs.lspconfig").on_attach
local capabilities = require("plug_configs.lspconfig").capabilities

local lspconfig = require "lspconfig"

-- if you just want default config for the servers then put them in a table
local servers = { "html", "cssls", "tsserver", "clangd", "terraformls", "bashls", "dockerls", "docker_compose_language_service", "jsonls", "pyright", "salt_ls", "texlab", "yamlls", "tflint" }

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

-- 
-- lspconfig.pyright.setup { blabla}
