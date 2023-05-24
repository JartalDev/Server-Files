RegisterServerEvent("BLACKOPSArmouryMenu:GiveWap")
AddEventHandler('BLACKOPSArmouryMenu:GiveWap', function(hash, wepname)
    local source = source
    for k, v in pairs(blackopscfg.gunshops) do 
        local x,y,z = table.unpack(v.blackopsarmoury)
        local blackopsarmourycoords = vector3(x,y,z)
        userid = vRP.getUserId(source)
        if blackopscfg.perm ~= nil then 
            if vRP.hasPermission(userid, blackopscfg.perm) then
                local legit = true
                vRPclient.FGSGiveGun(source, {legit, hash})
                vRPclient.notify(source, {"~g~Gave you a "..wepname})
            else
                vRPclient.notify(source, {"~r~You do not have permission to take guns"})
            end
        else 
            TriggerClientEvent("BLACKOPSArmouryMenu:givewap", source,  hash)
            vRPclient.notify(source, {"~g~Gave you a "..wepname})
        end
    end
end)

RegisterServerEvent("FGS:BLACKOPSArmouryCheck")
AddEventHandler("FGS:BLACKOPSArmouryCheck",function()
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, "blackops.armoury") then
        TriggerClientEvent('FGS:BLACKOPSArmouryChecked', source, true, true)
    elseif vRP.hasPermission(user_id, "clockon.menu") then
        TriggerClientEvent('FGS:BLACKOPSArmouryChecked', source, false, true)
    else
        TriggerClientEvent('FGS:BLACKOPSArmouryChecked', source, false, false)
    end
end)

RegisterServerEvent("BLACKOPSArmouryMenu:buyammo")
AddEventHandler('BLACKOPSArmouryMenu:buyammo', function(hash, wepname)
    local source = source
    for k, v in pairs(blackopscfg.gunshops) do 
        local x,y,z = table.unpack(v.blackopsarmoury)
        local blackopsarmourycoords = vector3(x,y,z)
        userid = vRP.getUserId(source)
        if blackopscfg.perm ~= nil then 
            if vRP.hasPermission(userid, blackopscfg.perm) then
                TriggerClientEvent("BLACKOPSArmouryMenu:GiveAmmo", source, hash)
                vRPclient.notify(source, {"~g~Gave you "..wepname.." ammo"})
            else
                vRPclient.notify(source, {"~r~You do not have permission to take ammo"})
            end
        else 
            TriggerClientEvent("BLACKOPSArmouryMenu:GiveAmmo", source, hash)
            vRPclient.notify(source, {"~g~Gave you "..wepname.." ammo"})
        end
    end
end)

RegisterNetEvent("FGS:GetWhitelistPD", function()
    local source = source
    local userid = vRP.getUserId(source)
    local name = GetPlayerName(source)
    local weptable = {}
    local numofwls = 0
    MySQL.query("vRP/get_whitelists", {user_id = userid}, function(whitelists, affected)
        if #whitelists > 0 then 
            local temp = {}
            for k,v in pairs(whitelists) do
                if v.location == "BlackOps" then 
                    table.insert(temp, v)
                end
            end
            TriggerClientEvent('FGS:ShowWhitelistsPD', source, temp)
        end
    end)
end)