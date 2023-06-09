-- Arrests and Unarrests
util.AddNetworkString("clogs_arrest")

hook.Add("playerArrested", "ArrestLogging", function(ply, _, pd)
    local Arrested_Time = os.date("%H:%M:%S") -- Get the current time
    local Arrester_pdName = pd:Name() -- Get the name of the arrester
    local Arrester_pdSteam64 = pd:SteamID64() -- Get the steam64 of the arrester
    local Arrester_pdTeam = team.GetName(pd:Team()) -- Get the team of the arrester
    local Arrested_plyName = ply:Name() -- Get the name of the arrested person
    local Arrested_plySteam64 = ply:SteamID64() -- Get the steam64 of the arrested person
    local Arrested_plyTeam = team.GetName(ply:Team()) -- Get the team of the arrested person
    local Arrest = true

    net.Start("clogs_arrest")
        net.WriteString(Arrested_Time)
        net.WriteString(Arrester_pdName)
        net.WriteString(Arrester_pdSteam64)
        net.WriteString(Arrester_pdTeam)
        net.WriteString(Arrested_plyName)
        net.WriteString(Arrested_plySteam64)
        net.WriteString(Arrested_plyTeam)
        net.WriteBool(Arrest)
    net.Broadcast()
end)

hook.Add("playerUnArrested", "UnarrestLogging", function(ply, pd)
    local UnArrested_Time = os.date("%H:%M:%S") -- Get the current time
    local UnArrester_pdName = pd:Name() -- Get the name of the unarrester
    local UnArrester_pdSteam64 = pd:SteamID64() -- Get the steam64 of the unarrester
    local UnArrester_pdTeam = team.GetName(pd:Team()) -- Get the team of the unarrester
    local UnArrested_plyName = ply:Name() -- Get the name of the unarrested person
    local UnArrested_plySteam64 = ply:SteamID64() -- Get the steam64 of the unarrested person
    local UnArrested_plyTeam = team.GetName(ply:Team()) -- Get the team of the unarrested person
    local Arrest = false

    net.Start("clogs_arrest")
        net.WriteString(UnArrested_Time)
        net.WriteString(UnArrester_pdName)
        net.WriteString(UnArrester_pdSteam64)
        net.WriteString(UnArrester_pdTeam)
        net.WriteString(UnArrested_plyName)
        net.WriteString(UnArrested_plySteam64)
        net.WriteString(UnArrested_plyTeam)
        net.WriteBool(Arrest)
    net.Broadcast()
end)