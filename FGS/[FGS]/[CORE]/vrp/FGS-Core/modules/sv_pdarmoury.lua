RegisterServerEvent("PDArmouryMenu:GiveWap")
AddEventHandler('PDArmouryMenu:GiveWap', function(hash, wepname)
    local source = source
    for k, v in pairs(pdcfg.gunshops) do 
        local x,y,z = table.unpack(v.pdarmoury)
        local pdarmourycoords = vector3(x,y,z)
        userid = vRP.getUserId(source)
        if pdcfg.perm ~= nil then 
            if vRP.hasPermission(userid, pdcfg.perm) then
                local legit = true
                vRPclient.FGSGiveGun(source, {legit, hash})
                vRPclient.notify(source, {"~g~Gave you a "..wepname})
                PDLog2(GetPlayerName(source).." has taken out a " .. wepname .. " from the SCO Armoury")
            else
                vRPclient.notify(source, {"~r~You do not have permission to take guns"})
            end
        else 
            PDLog2(GetPlayerName(source).." has taken out a " .. wepname .. " from the SCO Armoury")
            TriggerClientEvent("PDArmouryMenu:givewap", source,  hash)
            vRPclient.notify(source, {"~g~Gave you a "..wepname})
        end
    end
end)

RegisterServerEvent("FGS:PDArmouryCheck")
AddEventHandler("FGS:PDArmouryCheck",function()
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, "police.armoury") then
        TriggerClientEvent('FGS:PDArmouryChecked', source, true, true)
    elseif vRP.hasPermission(user_id, "clockon.menu") then
        TriggerClientEvent('FGS:PDArmouryChecked', source, false, true)
    else
        TriggerClientEvent('FGS:PDArmouryChecked', source, false, false)
    end
end)

RegisterServerEvent("PDArmouryMenu:buyammo")
AddEventHandler('PDArmouryMenu:buyammo', function(hash, wepname)
    local source = source
    for k, v in pairs(pdcfg.gunshops) do 
        local x,y,z = table.unpack(v.pdarmoury)
        local pdarmourycoords = vector3(x,y,z)
        userid = vRP.getUserId(source)
        if pdcfg.perm ~= nil then 
            if vRP.hasPermission(userid, pdcfg.perm) then
                TriggerClientEvent("PDArmouryMenu:GiveAmmo", source, hash)
                vRPclient.notify(source, {"~g~Gave you "..wepname.." ammo"})
            else
                vRPclient.notify(source, {"~r~You do not have permission to take ammo"})
            end
        else 
            TriggerClientEvent("PDArmouryMenu:GiveAmmo", source, hash)
            vRPclient.notify(source, {"~g~Gave you "..wepname.." ammo"})
        end
    end
end)