RegisterServerEvent("SicarioArmouryMenu:GiveWap")
AddEventHandler('SicarioArmouryMenu:GiveWap', function(hash, wepname)
    local source = source
    for k, v in pairs(sicariocfg.gunshops) do 
        local x,y,z = table.unpack(v.sicarioarmoury)
        local sicarioarmourycoords = vector3(x,y,z)
        userid = vRP.getUserId(source)
        if sicariocfg.perm ~= nil then 
            if vRP.hasPermission(userid, sicariocfg.perm) then
                local legit = true
                vRPclient.FGSGiveGun(source, {legit, hash})
                vRPclient.notify(source, {"~g~Gave you a "..wepname})
            else
                vRPclient.notify(source, {"~r~You do not have permission to take guns"})
            end
        else 
            TriggerClientEvent("SicarioArmouryMenu:givewap", source,  hash)
            vRPclient.notify(source, {"~g~Gave you a "..wepname})
        end
    end
end)

RegisterServerEvent("FGS:SicarioArmouryCheck")
AddEventHandler("FGS:SicarioArmouryCheck",function()
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, "sicario.armoury") then
        TriggerClientEvent('FGS:SicarioArmouryChecked', source, true, true)
    elseif vRP.hasPermission(user_id, "sicario.door") then
        TriggerClientEvent('FGS:SicarioArmouryChecked', source, false, true)
    else
        TriggerClientEvent('FGS:SicarioArmouryChecked', source, false, false)
    end
end)

RegisterServerEvent("SicarioArmouryMenu:buyammo")
AddEventHandler('SicarioArmouryMenu:buyammo', function(hash, wepname)
    local source = source
    for k, v in pairs(sicariocfg.gunshops) do 
        local x,y,z = table.unpack(v.sicarioarmoury)
        local sicarioarmourycoords = vector3(x,y,z)
        userid = vRP.getUserId(source)
        if sicariocfg.perm ~= nil then 
            if vRP.hasPermission(userid, sicariocfg.perm) then
                TriggerClientEvent("SicarioArmouryMenu:GiveAmmo", source, hash)
                vRPclient.notify(source, {"~g~Gave you "..wepname.." ammo"})
            else
                vRPclient.notify(source, {"~r~You do not have permission to take ammo"})
            end
        else 
            TriggerClientEvent("SicarioArmouryMenu:GiveAmmo", source, hash)
            vRPclient.notify(source, {"~g~Gave you "..wepname.." ammo"})
        end
    end
end)

RegisterNetEvent("FGS:GetWhitelistSicario", function()
    local source = source
    local userid = vRP.getUserId(source)
    local name = GetPlayerName(source)
    local weptable = {}
    local numofwls = 0
    MySQL.query("vRP/get_whitelists", {user_id = userid}, function(whitelists, affected)
        if #whitelists > 0 then 
            local temp = {}
            for k,v in pairs(whitelists) do
                if v.location == "sicario" then 
                    table.insert(temp, v)
                end
            end
            TriggerClientEvent('FGS:ShowWhitelistsSicario', source, temp)
        end
    end)
end)