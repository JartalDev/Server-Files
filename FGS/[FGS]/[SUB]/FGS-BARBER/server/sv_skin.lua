local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vRP")

RegisterNetEvent("FGS:saveFaceData")
AddEventHandler("FGS:saveFaceData", function(faceSaveData)
    local user_id = vRP.getUserId({source})

    vRP.setUData({user_id, "vRP:Face:Data", json.encode(faceSaveData)})
end)

RegisterNetEvent("FGS:changeHairStyle") --COULD BE USED FOR STAFFMODE AND STUFF XOTIIC IF U ARE WONDERING, JUST TRIGGER IT AND ITLL SET THE HARISTYLE, NO PARAMS
AddEventHandler("FGS:changeHairStyle", function()
    local user_id = vRP.getUserId({source})

    vRP.getUData({user_id, "vRP:Face:Data", function(data)
        if data ~= nil then
            TriggerClientEvent("FGS:setHairstyle", source, json.decode(data))
        end
    end})
end)

AddEventHandler("vRP:playerSpawn", function(user_id, source, first_spawn)
    SetTimeout(1500, function()
        vRP.getUData({user_id, "vRP:Face:Data", function(data)
            if data ~= nil then
                TriggerClientEvent("FGS:setHairstyle", source, json.decode(data))
            end
        end})
    end)
end)