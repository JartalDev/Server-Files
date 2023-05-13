local Tunnel = module('vrp', 'lib/Tunnel')
local Proxy = module('vrp', 'lib/Proxy')
vRP = Proxy.getInterface("vRP")

RegisterNetEvent('CXRP:PoliceCheck')
AddEventHandler('CXRP:PoliceCheck', function()
    local source = source
    local user_id = vRP.getUserId({source})
    if vRP.hasPermission({user_id, 'police.armoury'}) then
        TriggerClientEvent('CXRP:PolicePerms', source, true)
    else
        TriggerClientEvent('CXRP:PolicePerms', source, false)
    end
end)

RegisterNetEvent('CXRP:RebelCheck')
AddEventHandler('CXRP:RebelCheck', function()
    local source = source
    local user_id = vRP.getUserId({source})
    if vRP.hasPermission({user_id, 'rebel.guns'}) then
        TriggerClientEvent('CXRP:RebelPerms', source, true)
    else
        TriggerClientEvent('CXRP:RebelPerms', source, false)
    end
end)


RegisterNetEvent('CXRP:VIPCheck')
AddEventHandler('CXRP:VIPCheck', function()
    local source = source
    local user_id = vRP.getUserId({source})
    if vRP.hasPermission({user_id, 'vip.guns'}) then
        TriggerClientEvent('CXRP:VIPPerms', source, true)
    else
        TriggerClientEvent('CXRP:VIPPerms', source, false)
    end
end)

