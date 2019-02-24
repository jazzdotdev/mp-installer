#!/usr/bin/env torchbear

function fetch(mp_dir)
	fs_extras_url = "https://github.com/foundpatterns/fs-extras-lua"
	dependency_dir = mp_dir .. "third-party/"

	git.clone(torchbear.settings.git_url, mp_dir )
	git.clone(fs_extras_url, dependency_dir)

	-- Clone log repo into .tmp-log
	log_url = "https://github.com/lunar-transit/log"
	log_dir = mp_dir .. ".tmp-log/"
	git.clone(log_url, log_dir)

	-- Move log.lua to third-party and remove .tmp-log
	fs.copy_file(log_dir .. "log.lua", dependency_dir)
	fs.remove_dir(log_dir, true)
end

local bin_dir = torchbear.settings.install_directory
local mp_dir = bin_dir .. "machu-picchu/"

print("bin_dir", bin_dir)

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

fetch(mp_dir)

if torchbear.os == "windows" then
	fs.copy_file("mp.bat", bin_dir)
else
	local cmd_path = bin_dir .. "mp"

	if fs.is_file(cmd_path) then
		-- TODO: Implement remove_file in torchbear
		--fs.remove_file(cmd_path)
		os.execute("rm " .. cmd_path)
	end

	fs.symlink(mp_dir .. "/init.lua", cmd_path)
	os.execute("chmod +x " .. cmd_path)
end