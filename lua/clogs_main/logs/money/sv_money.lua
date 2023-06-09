util.AddNetworkString("clogs_money")

hook.Add("playerGaveMoney", "clogs_money", function(ply, oply, amt)
    local time = os.date("%H:%M:%S") -- Get the current time
    local plyName = ply:Name()
    local oplyName = oply:Name()
    local plySteam64 = ply:SteamID64()
    local oplySteam64 = oply:SteamID64()
    local plyTeam = team.GetName(ply:Team())
    local oplyTeam = team.GetName(oply:Team())
    local ammount = amt

    net.Start("clogs_money")
        net.WriteString(time)
        net.WriteString(plyName)
        net.WriteString(oplyName)
        net.WriteString(plySteam64)
        net.WriteString(oplySteam64)
        net.WriteString(plyTeam)
        net.WriteString(oplyTeam)
        net.WriteInt(ammount, 32)
    net.Broadcast()
end)