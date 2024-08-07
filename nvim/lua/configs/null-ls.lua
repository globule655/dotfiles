local null_ls = require "null-ls"

local b = null_ls.builtins

local sources = {

  -- webdev stuff
  b.formatting.prettier.with { filetypes = { "html", "markdown", "css" } }, -- so prettier works only on these filetypes

  -- Lua
  b.formatting.stylua,

  -- cpp
  b.formatting.clang_format,

  -- salt
  b.diagnostics.saltlint,

  -- ansible
  b.diagnostics.ansiblelint,

  -- terraform
  b.formatting.terraform_fmt,
}

null_ls.setup {
  debug = true,
  sources = sources,
}
