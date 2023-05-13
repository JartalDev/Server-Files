local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")

RegisterNetEvent('CXRP:IDsAboveHead')
AddEventHandler('CXRP:IDsAboveHead', function(status)
    local status = status
    local user_id = vRP.getUserId({source})
    if vRP.hasPermission({user_id, 'admin.noclip'}) then
        TriggerClientEvent('CXRP:ChangeIDs', source, status)
    end
end)