RegisterCommand("streamer", function(source, args)
    local userid = vRP.getUserId(source)
    if vRP.hasGroup(userid, "streamer") then 
        TriggerClientEvent('GG:ToggleStreamerMenu', source)
    end
end)