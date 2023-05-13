local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vRP")

RegisterNetEvent("TFC:saveFaceData")
AddEventHandler("TFC:saveFaceData", function(faceSaveData)
    local source = source
    local user_id = vRP.getUserId({source})
    vRP.setUData({user_id, "vRP:Face:Data", json.encode(faceSaveData)})
    --vRPclient.notify(source, {"~g~Your hairstyle has been saved."})

end)

RegisterNetEvent("TFC:changeHairStyle") --COULD BE USED FOR STAFFMODE AND STUFF XOTIIC IF U ARE WONDERING, JUST TRIGGER IT AND ITLL SET THE HARISTYLE, NO PARAMS
AddEventHandler("TFC:changeHairStyle", function()
    local source = source
    local user_id = vRP.getUserId({source})

    vRP.getUData({user_id, "vRP:Face:Data", function(data)
        if data ~= nil then
            TriggerClientEvent("TFC:setHairstyle", source, json.decode(data))
        end
    end})
end)

AddEventHandler("vRP:playerSpawn", function(user_id, source, first_spawn)
    SetTimeout(1000, function() 
        local source = source
        local user_id = vRP.getUserId({source})
        vRP.getUData({user_id, "vRP:Face:Data", function(data)
            if data ~= nil then
                TriggerClientEvent("TFC:setHairstyle", source, json.decode(data))
            end
        end})
    end)
end)