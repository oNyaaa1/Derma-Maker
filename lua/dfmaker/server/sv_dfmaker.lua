print("Derma Maker Loaded")
util.AddNetworkString("SandBoxedAllowed")
local SANDBOXED = SANDBOXED or {}
SANDBOXED["Allowed"] = {
    {
        Main = "DFrame",
        Title = "Test",
        SizeW = 400,
        SizeH = 400,
        Center = true,
    }
}

hook.Add("PlayerInitialSpawn", "SellYourSoul", function(pl)
    net.Start("SandBoxedAllowed")
    net.WriteTable(SANDBOXED["Allowed"])
    net.Send(pl)
end)
