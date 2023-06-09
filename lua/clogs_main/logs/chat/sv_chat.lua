util.AddNetworkString("clogs_chat")

hooks.add("PlayerSay", "clogs_chat", function(ply, txt, team)
    local time = os.date("%H:%M:%S") -- Get the current time
    local plyName = ply:Name()
    local plySteamID = ply:SteamID()
    local plyTeam = team.GetName(ply:Team())
    local teamChat = team

    net.Start("clogs_chat")
        net.WriteString(time)
        net.WriteString(plyName)
        net.WriteString(plySteamID)
        net.WriteString(plyTeam)
        net.WriteString(txt)
        net.WriteBool(teamChat)
    net.Broadcast()
end)