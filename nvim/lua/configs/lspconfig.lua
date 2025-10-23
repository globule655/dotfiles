local on_attach = function(client, bufnr)
  client.server_capabilities.documentFormattingProvider = false
  client.server_capabilities.documentRangeFormattingProvider = false
end

local M = {}

M.capabilities = vim.lsp.protocol.make_client_capabilities()

M.capabilities.textDocument.completion.completionItem = {
  documentationFormat = { "markdown", "plaintext" },
  snippetSupport = true,
  preselectSupport = true,
  insertReplaceSupport = true,
  labelDetailsSupport = true,
  deprecatedSupport = true,
  commitCharactersSupport = true,
  tagSupport = { valueSet = { 1 } },
  resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
    },
  },
}

local capabilities = M.capabilities

-- List of LSP servers to configure
local servers = { "marksman", "html", "cssls", "ts_ls", "clangd", "terraformls", "bashls", "dockerls", "docker_compose_language_service", "jsonls", "pyright", "salt_ls", "texlab", "yamlls", "tflint", "dotls", "ansiblels", "nil_ls" }

-- Configure servers using vim.lsp.config (Neovim 0.11+)
for _, server_name in ipairs(servers) do
  vim.lsp.config(server_name, {
    on_attach = on_attach,
    capabilities = capabilities,
  })
end

-- Configure lua_ls with custom settings
vim.lsp.config("lua_ls", {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = {
          vim.env.VIMRUNTIME
        },
        maxPreload = 100000,
        preloadFileSize = 10000,
      },
    },
  },
})

-- Enable the configured LSP servers
vim.lsp.enable(servers)
vim.lsp.enable("lua_ls")

