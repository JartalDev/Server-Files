RegisterCommand("aa", function(source, args)
    local userid = vRP.getUserId(source)
    if vRP.hasPermission(userid, "aa.job") then 
        TriggerClientEvent('GG:ToggleAAMenu', source)
    end
end)