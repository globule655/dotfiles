local obsidian_opts = {
  workspaces = {
    {
      name = "perso",
      path = "~/Documents/git_perso/wiki_perso.git/master",
    },
  },

  markdown_link_func = function(opts)
    return require("obsidian.util").markdown_link(opts)
  end,

  -- Either 'wiki' or 'markdown'.
  preferred_link_style = "markdown",
}

return obsidian_opts
