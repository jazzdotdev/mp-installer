#!/usr/bin/env torchbear

local dir = torchbear.settings.install_directory
local mp_dir = dir .. "machu-pichu/"

if fs.is_dir(mp_dir) then
  os.execute("rm -r " .. mp_dir)
end

git.clone( torchbear.settings.git_url, mp_dir )

local cmd = "#!/bin/env bash\ncd " .. mp_dir ..  "; torchbear"

local cmd_path = dir .. "mp"

local f = io.open(cmd_path, "w")
f:write(cmd)
f:close()

os.execute("chmod +x " .. cmd_path)


