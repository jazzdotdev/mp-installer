#!/usr/bin/env torchbear

local dir = torchbear.settings.install_directory
local mp_dir = dir .. "machu-pichu/"

if fs.is_dir(mp_dir) then
  os.execute("rm -r " .. mp_dir)
end

git.clone( torchbear.settings.git_url, mp_dir )
fs.symlink(mp_dir .. "/init.lua", dir .. "mp")
local cmd_path = dir .. "mp"
os.execute("chmod +x " .. cmd_path)


