RegisterServerEvent('FGS:IDsAboveHead')
AddEventHandler('FGS:IDsAboveHead', function()
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id ~= nil and vRP.hasPermission(user_id, "admin.idsabovehead") then
        TriggerClientEvent("FGS:ChangeIDs",source)
    else
        vRPclient.notify(source,{"You do not have permission to change far ids"})
    end
end)