RegisterServerEvent("FGS:PANIC")
AddEventHandler("FGS:PANIC", function(coords)
    user_id = vRP.getUserId(source) 
    local blipcolor = 0 
    if vRP.hasPermission(user_id, "police.menu") then 
        if vRP.hasPermission(user_id, "police.menu") then 
            blipcolor = 75
        end 
        local players = GetPlayers()
        for i, v in pairs(players) do 
            user_id = vRP.getUserId(v)
            if vRP.hasPermission(user_id, "police.menu") then 
                TriggerClientEvent("FGS:PANICBUTTON", v, coords, blipcolor)
            end
        end
    end
end)