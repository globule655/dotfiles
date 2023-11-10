local toggleterm = {
  autochdir = true,
  shell = function ()
    local is_windows = vim.loop.os_uname().sysname == "Windows_NT"
    if is_windows then
      return "powershell"
    else
      return os.getenv("SHELL")
    end
  end
}

return toggleterm
