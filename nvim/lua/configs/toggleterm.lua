local user_shell = os.getenv("SHELL")

local toggleterm = {
  autochdir = true,
  shell = user_shell
}

return toggleterm
