local Sort_notes = function()
  local obsidian_params = require("configs.obsidian")
  local vault_path = obsidian_params.workspaces[1].path
  local note_subdir = obsidian_params.note_subdir
  local inbox = vault_path .. "/" .. note_subdir

  local function scandir(path)
    local md_files = io.popen("find " .. path .. " -type f -name '*.md'")
    if md_files ~= nil then
      for files in md_files:lines() do
        print("Processing: " .. files)
        local tag = io.popen("awk '/tags:/{getline; print; exit}' " .. files .. " | sed -e 's/^ *- //' -e 's/^ *//;s/ *$//'")
        if tag ~= nil then
          local tag_content = tag:read('*a')
          io.popen("mv " .. files .. " " .. vault_path .. "/" .. tag_content .. "/")
          print("Moving file to " .. vault_path .. "/" .. tag_content)
        end
      end
    end
  end

  scandir(inbox)

end

return Sort_notes
