local Tunnel = module('vrp', 'lib/Tunnel')
local Proxy = module('vrp', 'lib/Proxy')
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "vRP_BodyBag")

RegisterServerEvent('VRP_BODYBAG:Trigger')
AddEventHandler('VRP_BODYBAG:Trigger', function(target)
    local source = source
    local user_id = vRP.getUserId({source})
    local target = target
    print(target)
    vRPclient.isInComa(target,{}, function(incoma) incoma = incoma 
        print(incoma)
        if user_id ~= nil and vRP.hasPermission({user_id, "emergency.market"})  then
            if incoma then
                TriggerClientEvent('VRP_BODYBAG:PutInBag', target)
            else
                vRPclient.notify(source, {"~r~They're not dead!"})
            end
        else
            vRPclient.notify(source, {"~r~You're not a medic on duty!"})
        end
    end)
end)
