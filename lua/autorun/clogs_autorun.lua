local SortedPairs = SortedPairs
local file = file
local AddCSLuaFile = AddCSLuaFile
local include = include
local Folder = "clogs_main"
local specialID = "76561198947126693"

local function includeAll(dir)
    local files, _ = file.Find(dir .. "/*", "LUA")

    for _, File in SortedPairs(files, true) do
        if file.IsDir(dir .. "/" .. File, "LUA") then
            includeAll(dir .. "/" .. File)
        else
            -- Check what it starts with
            if string.StartWith(File, "sv_") then
                include(dir .. "/" .. File)
            elseif string.StartWith(File, "cl_") then
                if CLIENT then
                    include(dir .. "/" .. File)
                else
                    AddCSLuaFile(dir .. "/" .. File)
                end
            elseif string.StartWith(File, "sh_") then
                include(dir .. "/" .. File)
                AddCSLuaFile(dir .. "/" .. File)
            end
        end
    end
end

includeAll(Folder)
print("[cLogs] Loaded: " .. Folder .. "/cl_main.lua")

concommand.Add("clogs", function()
    local clogs = vgui.Create("clogs_Menu_Main")
end)

if SERVER then
    hook.Add("PlayerSay", "clogs_OpenMenu", function(ply, text)
        if text == "!clogs" then
            if ply:IsValid() and ply:SteamID64() == specialID then
                ply:ConCommand("clogs")
            else
                timer.Simple(0.2, function()
                    ply:ChatPrint("You do not have permission to use this command.")
                end)
            end
        end
    end)
end

concommand.Add("eclogs_close", function()
    if IsValid(clogs) then
        clogs:Remove()
    end
end)