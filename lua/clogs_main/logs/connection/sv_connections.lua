util.AddNetworkString("clogs_connections")

hook.Add("PlayerInitialSpawn", "clogs_connections", function(ply)
    local time = os.date("%H:%M:%S") -- Get the current time
    local plyName = ply:Name()
    local plySteamID64 = ply:SteamID64()
    local plyTeam = team.GetName(ply:Team())
    local con = true

    net.Start("clogs_connections")
        net.WriteString(time)
        net.WriteString(plyName)
        net.WriteString(plySteamID64)
        net.WriteString(plyTeam)
        net.WriteBool(con)
    net.Broadcast()
end)

hook.Add("PlayerDisconnected", "clogs_connections", function(ply)
    local time = os.date("%H:%M:%S") -- Get the current time
    local plyName = ply:Name()
    local plySteamID64 = ply:SteamID64()
    local plyTeam = team.GetName(ply:Team())
    local con = false

    net.Start("clogs_connections")
        net.WriteString(time)
        net.WriteString(plyName)
        net.WriteString(plySteamID64)
        net.WriteString(plyTeam)
        net.WriteBool(con)
    net.Broadcast()
end)