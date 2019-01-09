#!/usr/bin/env torchbear

local bin_dir = torchbear.settings.install_directory
local mp_dir = bin_dir .. "machu-picchu/"

if torchbear.os == "windows" then 
	-- TODO handle in torchbear
	mp_dir = os.getenv("CMDER_ROOT") .. mp_dir
	bin_dir = os.getenv("CMDER_ROOT") .. "/bin/"
elseif torchbear.os == "android" then
	bin_dir = "/data/data/com.termux/files/usr/bin/"
	mp_dir = bin_dir .. "machu-picchu/"
end

if fs.is_dir(mp_dir) then
	fs.remove_dir(mp_dir, true)
end

git.clone( torchbear.settings.git_url, mp_dir )
if torchbear.os == "windows" then
	fs.copy_file("mp.bat", bin_dir)
else
	local cmd_path = bin_dir .. "mp"
	fs.symlink(mp_dir .. "/init.lua", bin_dir .. "mp")
	os.execute("chmod +x " .. cmd_path)
end