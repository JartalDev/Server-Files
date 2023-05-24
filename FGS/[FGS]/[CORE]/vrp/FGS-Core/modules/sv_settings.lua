RegisterServerEvent('FGS:OpenSettings')
AddEventHandler('FGS:OpenSettings', function()
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id ~= nil and vRP.hasPermission(user_id, "admin.menu") then
        TriggerClientEvent("FGS:OpenSettingsMenu", source, true)
    else
        TriggerClientEvent("FGS:OpenSettingsMenu", source, false)
    end
end)