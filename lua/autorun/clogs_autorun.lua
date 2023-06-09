clogs = clogs or {}
local SortedPairs = SortedPairs
local file = file
local AddCSLuaFile = AddCSLuaFile
local include = include
local Folder = "clogs_main"

local function includeAll(dir)
    local files, _ = file.Find(dir .. "/*", "LUA")

    for _, File in SortedPairs(files, true) do
        if file.IsDir(dir .. "/" .. File, "LUA") then
            includeAll(dir .. "/" .. File)
        else
            -- Check what it starts with
            if string.StartWith(File, "sv_") then
                includeDir(dir .. "/" .. file)
            elseif string.StartWith(File, "cl_") then
                include(dir .. "/" .. File)

                if SERVER then
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
    panel = vgui.Create("clogs_Menu_Main")
    panel:SetSize(ScrW() * 0.5, ScrH() * 0.5)
    panel:Center()
end)

if SERVER then
    hook.Add("PlayerSay", "clogs_OpenMenu", function(ply, text)
        if text == "!clogs" then
            ply:ConCommand("clogs")
        end
    end)
end