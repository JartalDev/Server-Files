RegisterCommand("a", function(source,args, rawCommand)
    local user_id = vRP.getUserId(source)   

    local msg = rawCommand:sub(2)
    local playerName =  " ^7Staff Chat | " .. GetPlayerName(source)..": "
    local players = GetPlayers()
    if not vRP.hasPermission(user_id, "staff.mode") then 
        return vRPclient.notify(source,{'You do not have staff.'})
    end 
    for i,v in pairs(players) do 
        local name = GetPlayerName(v)
        local user_id2 = vRP.getUserId(v)   
        if vRP.hasPermission(user_id2, "admin.menu") then

            TriggerClientEvent('chat:addMessage', v, {
                template = '<div style="padding: 0.5vw; margin: 0.4vw; background-color: rgba(0, 201, 0 , 0.4); border-radius: 4px;"><i class="fas fa-globe"></i>{0} {1}</div>',
                args = { playerName, msg }
            })
        end
    end
end)
