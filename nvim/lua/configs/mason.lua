local options = {
  ensure_installed = {
    "lua-language-server",
    "stylua",
    -- web dev stuff
    "css-lsp",
    "html-lsp",
    "typescript-language-server",
    "deno",
    "prettier",
    "json-lsp",
    -- c/cpp stuff
    "clangd",
    "clang-format",
    -- devops
    "terraform-ls",
    "tflint",
    "dockerfile-language-server",
    "docker-compose-language-service",
    "bash-language-server",
    "pyright",
    "texlab",
    "yaml-language-server",
  },

  PATH = "append",

  ui = {
    icons = {
      package_pending = " ",
      package_installed = "󰄳 ",
      package_uninstalled = " 󰚌",
    },

    keymaps = {
      toggle_server_expand = "<CR>",
      install_server = "i",
      update_server = "u",
      check_server_version = "c",
      update_all_servers = "U",
      check_outdated_servers = "C",
      uninstall_server = "X",
      cancel_installation = "<C-c>",
    },
  },

  max_concurrent_installers = 10,
}

return options

