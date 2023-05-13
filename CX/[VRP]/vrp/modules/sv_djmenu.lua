local c = {}
RegisterCommand("djmenu", function(source, args, rawCommand)
    local source = source
    local userid = vRP.getUserId(source)
    if vRP.hasGroup(userid,"DJ") then
        TriggerClientEvent('CXRP:toggleDjMenu', source)
    end
end)
RegisterCommand("djadmin", function(source, args, rawCommand)
    local source = source
    local userid = vRP.getUserId(source)
    if vRP.hasPermission(userid,"admin.menu") then
        TriggerClientEvent('CXRP:toggleDjAdminMenu', source,c)
    end
end)
RegisterCommand("play",function(source,args,rawCommand)
    local source = source
    local user_id = vRP.getUserId(source)
    local ped = GetPlayerPed(source)
    local coords = GetEntityCoords(ped)
    local name = GetPlayerName(source)
    if vRP.hasGroup(user_id,"DJ") then
        if #args > 0 then
            TriggerClientEvent('CXRP:finaliseSong', source,args[1])
        end
    end
end)
RegisterServerEvent("CXRP:adminStopSong")
AddEventHandler("CXRP:adminStopSong", function(PARAM)
    local source = source
    for k,v in pairs(c) do
        if v[1] == PARAM then
            TriggerClientEvent('CXRP:stopSong', -1,v[2])
            c[tostring(k)] = nil
            TriggerClientEvent('CXRP:toggleDjAdminMenu', source,c)
        end
    end
end)
RegisterServerEvent("CXRP:playDjSongServer")
AddEventHandler("CXRP:playDjSongServer", function(PARAM,coords)
    local source = source
    local user_id = vRP.getUserId(source)
    local name = GetPlayerName(source)
    c[tostring(source)] = {PARAM,coords,user_id,name,"true"}
    TriggerClientEvent('CXRP:playDjSong', -1,PARAM,coords,user_id,name)
end)
RegisterServerEvent("CXRP:skipServer")
AddEventHandler("CXRP:skipServer", function(coords,param)
    local source = source
    TriggerClientEvent('CXRP:skipDj', -1,coords,param)
end)
RegisterServerEvent("CXRP:stopSongServer")
AddEventHandler("CXRP:stopSongServer", function(coords)
    local source = source
    TriggerClientEvent('CXRP:stopSong', -1,coords)
end)
RegisterServerEvent("CXRP:updateVolumeServer")
AddEventHandler("CXRP:updateVolumeServer", function(coords,volume)
    local source = source
    TriggerClientEvent('CXRP:updateDjVolume', -1,coords,volume)
end)
