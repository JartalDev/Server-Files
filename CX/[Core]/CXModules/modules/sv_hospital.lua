local Tunnel = module('vrp', 'lib/Tunnel')
local Proxy = module('vrp', 'lib/Proxy')
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "Hospital")

-- RegisterServerEvent("CXRP:HealPlayer")
-- AddEventHandler('CXRP:HealPlayer', function()
--     userid = vRP.getUserId({source})
--     TriggerClientEvent("CXRP:SetHealth", source)
--     vRPclient.notify(source,{"~g~You have been healed, free of charge."})
-- end)

RegisterNetEvent('CXRP:reviveRadial')
AddEventHandler('CXRP:reviveRadial', function()
    local player = source
    vRPclient.getNearestPlayer(player,{4},function(nplayer)
        TriggerClientEvent('CXRP:cprAnim', player, nplayer)
    end)
end)

RegisterNetEvent("CXRP:SendFixClient")
AddEventHandler("CXRP:SendFixClient", function(player)
    TriggerClientEvent("CXRP:FixClient", player)
end)