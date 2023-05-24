local Perms = {
    "staff.mode",
    "police.menu",
    "nhs.menu",
}

RegisterServerEvent('FGS:DeleteVehicle')
AddEventHandler('FGS:DeleteVehicle', function()
    local source = source
    local user_id = vRP.getUserId(source)
    local something = false
    if user_id ~= nil then
        for k,v in pairs(Perms) do 
            if vRP.hasPermission(user_id, v) then 
                TriggerClientEvent("wk:deleteVehicle",source)
                something = true
            end
        end
        if not something then 
            vRPclient.notify(source,{"You do not have permission to delete vehicles"})
        end
    else
        vRPclient.notify(source,{"You do not have permission to delete vehicles"})
    end
end)