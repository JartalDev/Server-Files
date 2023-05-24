RegisterServerEvent("SCOArmouryMenu:GiveWap")
AddEventHandler('SCOArmouryMenu:GiveWap', function(hash, wepname)
    local source = source
    for k, v in pairs(scocfg.gunshops) do 
        local x,y,z = table.unpack(v.scoarmoury)
        local scoarmourycoords = vector3(x,y,z)
        userid = vRP.getUserId(source)
        if scocfg.perm ~= nil then 
            if vRP.hasPermission(userid, scocfg.perm) then
                local legit = true
                vRPclient.FGSGiveGun(source, {legit, hash})
                PDLog2(GetPlayerName(source).." has taken out a " .. wepname .. " from the SCO Armoury")
                vRPclient.notify(source, {"~g~Gave you a "..wepname})
            else
                vRPclient.notify(source, {"~r~You do not have permission to take guns"})
            end
        else 
            PDLog2(GetPlayerName(source).." has taken out a " .. wepname .. " from the SCO Armoury")
            TriggerClientEvent("SCOArmouryMenu:givewap", source,  hash)
            vRPclient.notify(source, {"~g~Gave you a "..wepname})
        end
    end
end)

RegisterServerEvent("FGS:SCOArmouryCheck")
AddEventHandler("FGS:SCOArmouryCheck",function()
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, "police.armoury") then
        TriggerClientEvent('FGS:SCOArmouryChecked', source, true, true)
    elseif vRP.hasPermission(user_id, "clockon.menu") then
        TriggerClientEvent('FGS:SCOArmouryChecked', source, false, true)
    else
        TriggerClientEvent('FGS:SCOArmouryChecked', source, false, false)
    end
end)

RegisterServerEvent("SCOArmouryMenu:buyammo")
AddEventHandler('SCOArmouryMenu:buyammo', function(hash, wepname)
    local source = source
    for k, v in pairs(scocfg.gunshops) do 
        local x,y,z = table.unpack(v.scoarmoury)
        local scoarmourycoords = vector3(x,y,z)
        userid = vRP.getUserId(source)
        if scocfg.perm ~= nil then 
            if vRP.hasPermission(userid, scocfg.perm) then
                TriggerClientEvent("SCOArmouryMenu:GiveAmmo", source, hash)
                vRPclient.notify(source, {"~g~Gave you "..wepname.." ammo"})
            else
                vRPclient.notify(source, {"~r~You do not have permission to take ammo"})
            end
        else 
            TriggerClientEvent("SCOArmouryMenu:GiveAmmo", source, hash)
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
                if v.location == "PD" then 
                    table.insert(temp, v)
                end
            end
            TriggerClientEvent('FGS:ShowWhitelistsPD', source, temp)
        end
    end)
end)

function PDLog2(message)
    local webhook = "https://discord.com/api/webhooks/982458197895950376/9y2qNYnjwUIkq2K9vTaYNC54Z90msrVMNJoEC1bqVB8f1rI_oqD_kI22Eb6WXVZpwo5F"
    PerformHttpRequest(webhook, function(err, text, headers) 
    end, "POST", json.encode({username = "FGS Roleplay", embeds = {
        {
            ["color"] = "15158332",
            ["title"] = "" .. " Logs",
            ["description"] = message,
            ["footer"] = {
                ["text"] = "Time - "..os.date("%x %X %p"),
            }
    }
    }}), { ["Content-Type"] = "application/json" })
end

--