Derma_Maker = Derma_Maker or {}
function incDir(dir)
	local cirDir = {}
	local _, folder = file.Find(dir .. "/*", "LUA")
	for k, v in pairs(folder) do
		incDir(v)
		cirDir[k] = v
	end
	return cirDir
end

function FindShared(files)
	if string.find(files, "sh_") then
		print("Adding Shared File: " .. files)
		if SERVER then
			AddCSLuaFile(files)
			include(files)
		else
			include(files)
		end
	end
end

function FindServerClient(files)
	if string.find(files, "sv_") then
		print("Adding Server File: " .. files)
		if SERVER then include(files) end
	end

	if string.find(files, "cl_") then
		print("Adding Client File: " .. files)
		if SERVER then
			AddCSLuaFile(files)
		else
			include(files)
		end
	end
end

function FindFiles()
	local max = incDir("dfmaker")
	local fillBind = {}
	local start = "dfmaker/"
	for j, _ in pairs(max) do
		local files = file.Find(start .. "/" .. max[j] .. "/*", "LUA")
		for k, v in pairs(files) do
			fillBind[#fillBind + 1] = start .. max[j] .. "/" .. v
		end
	end

	for k, v in pairs(fillBind) do
		FindShared(v)
	end

	for k, v in pairs(fillBind) do
		FindServerClient(v)
	end
end

FindFiles()
print("Derma Maker loaded")