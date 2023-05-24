-- Ecstasy Start

function haveEnoughtSpace(user_id, item,amount)
    return vRP.getInventoryMaxWeight(user_id) >= vRP.getInventoryWeight(user_id) + (vRP.getItemWeight(item) * amount)
end

RegisterServerEvent("FGS-Drugs:EcstasyCanCollect")
AddEventHandler("FGS-Drugs:EcstasyCanCollect", function()
    local source = source
    local user_id = vRP.getUserId(source)
    local max_weight = vRP.getInventoryMaxWeight(user_id)
    local weight = vRP.getInventoryWeight(user_id)
    local coords = GetEntityCoords(GetPlayerPed(source))
    local comparison = vector3(5337.4912109375,-5263.515625,32.730861663818)
    if user_id == nil then 
        return 
    end
    if #(coords - comparison) > 500 then 
        vRP.AnticheatBanVRP(user_id, "unlucky")
    return 
    end   
    if vRP.hasPermission(user_id, "ecstasy.license") then 
        if max_weight > weight then 
            TriggerClientEvent("drugs:animation", source, "world_human_gardener_plant")
        else
            vRPclient.notify(source,{"~r~No inventory space left"})
        end
    else
        vRPclient.notify(source,{"~r~You do not have a Ecstasy license"})
    end
end)

RegisterServerEvent("FGS-Drugs:EcstasyCollect")
AddEventHandler("FGS-Drugs:EcstasyCollect", function(amount)
    local source = source
    local user_id = vRP.getUserId(source)
    local max_weight = vRP.getInventoryMaxWeight(user_id)
    local weight = vRP.getInventoryWeight(user_id)
    local coords = GetEntityCoords(GetPlayerPed(source))
    local comparison = vector3(5337.4912109375,-5263.515625,32.730861663818)
    if user_id == nil then 
        return 
    end
    if amount > 5 then 
        vRP.AnticheatBanVRP(user_id, "unlucky")
        return 
    end
    if #(coords - comparison) > 500 then 
        vRP.AnticheatBanVRP(user_id, "unlucky")
    return 
    end
    if vRP.hasPermission(user_id, "ecstasy.license") then 
        if haveEnoughtSpace(user_id, "froglegs", amount) then 
            vRP.giveInventoryItem(user_id, "froglegs", 4, true)
        else
            vRPclient.notify(source,{"~r~No inventory space left"})
        end
    else
        vRPclient.notify(source,{"~r~You do not have a Ecstasy license"})
    end
end)


RegisterServerEvent("FGS-Drugs:FrogCanProcess")
AddEventHandler("FGS-Drugs:FrogCanProcess", function()
    local source = source
    local user_id = vRP.getUserId(source)
    local max_weight = vRP.getInventoryMaxWeight(user_id)
    local weight = vRP.getInventoryWeight(user_id)
    local coords = GetEntityCoords(GetPlayerPed(source))
    local comparison = vector3(-2083.5766601563,2617.1372070313,3.0839664936066)
    if user_id == nil then 
        return 
    end
    if #(coords - comparison) > 500 then 
        vRP.AnticheatBanVRP(user_id, "unlucky")
    return 
    end   
    if vRP.hasPermission(user_id, "ecstasy.license") then 
        if max_weight > weight then 
            TriggerClientEvent("drugs:animation", source, "WORLD_HUMAN_CLIPBOARD")
        else
            vRPclient.notify(source,{"~r~No inventory space left"})
        end
    else
        vRPclient.notify(source,{"~r~You do not have a Ecstasy license"})
    end
end)


RegisterServerEvent("FGS-Drugs:FrogProcess")
AddEventHandler("FGS-Drugs:FrogProcess", function(amount)
    local source = source
    local user_id = vRP.getUserId(source)
    local max_weight = vRP.getInventoryMaxWeight(user_id)
    local weight = vRP.getInventoryWeight(user_id)
    local coords = GetEntityCoords(GetPlayerPed(source))
    local comparison = vector3(-2083.5766601563,2617.1372070313,3.0839664936066)
    if user_id ~= nil then 
        if amount > 5 then 
            vRP.AnticheatBanVRP(user_id, "unlucky")
            return 
        end
        if #(coords - comparison) > 500 then 
            vRP.AnticheatBanVRP(user_id, "unlucky")
        return 
        end
        if vRP.hasPermission(user_id, "ecstasy.license") then 
            if vRP.tryGetInventoryItem(user_id, "froglegs", 4, false) then
              --  TriggerClientEvent("drugs:animation", source, "world_human_gardener_plant")
              --  Wait(10000)
                if max_weight > (weight - 4) then 
                    vRP.giveInventoryItem(user_id, "acid", 4, true)
                else
                    vRPclient.notify(source,{"~r~No inventory space left"})
                end
            else
                vRPclient.notify(source,{"~r~Not enough Frog Legs"})
            end
        else
            vRPclient.notify(source,{"~r~You do not have a Ecstasy license"})
        end
    end
end)


RegisterServerEvent("FGS-Drugs:EcstasyCanProcess")
AddEventHandler("FGS-Drugs:EcstasyCanProcess", function()
    local source = source
    local user_id = vRP.getUserId(source)
    local max_weight = vRP.getInventoryMaxWeight(user_id)
    local weight = vRP.getInventoryWeight(user_id)
    local coords = GetEntityCoords(GetPlayerPed(source))
    local comparison = vector3(462.25802612305,-3235.4230957031,6.0695581436157)
    if user_id == nil then 
        return 
    end
    if #(coords - comparison) > 500 then 
        vRP.AnticheatBanVRP(user_id, "unlucky")
    return 
    end   
    if vRP.hasPermission(user_id, "ecstasy.license") then 
        if max_weight > weight then 
            TriggerClientEvent("drugs:animation", source, "WORLD_HUMAN_CLIPBOARD")
        else
            vRPclient.notify(source,{"~r~No inventory space left"})
        end
    else
        vRPclient.notify(source,{"~r~You do not have a Ecstasy license"})
    end
end)

RegisterServerEvent("FGS-Drugs:EcstasyProcess")
AddEventHandler("FGS-Drugs:EcstasyProcess", function(amount)
    local source = source
    local user_id = vRP.getUserId(source)
    local max_weight = vRP.getInventoryMaxWeight(user_id)
    local weight = vRP.getInventoryWeight(user_id)
    local coords = GetEntityCoords(GetPlayerPed(source))
    local comparison = vector3(462.25802612305,-3235.4230957031,6.0695581436157)
    if user_id == nil then 
        return 
    end
    if amount > 5 then 
        vRP.AnticheatBanVRP(user_id, "unlucky")
        return 
    end
    if #(coords - comparison) > 500 then 
        vRP.AnticheatBanVRP(user_id, "unlucky")
    return 
    end
    if vRP.hasPermission(user_id, "ecstasy.license") then 
        if vRP.tryGetInventoryItem(user_id, "acid", 4, false) then
           -- TriggerClientEvent("drugs:animation", source, "world_human_gardener_plant")
           -- Wait(10000)
            if haveEnoughtSpace(user_id, "ecstasy", amount - 4) then
                vRP.giveInventoryItem(user_id, "ecstasy", 1, true)
            else
                vRPclient.notify(source,{"~r~No inventory space left"})
            end
        else
            vRPclient.notify(source,{"~r~Not enough acid"})
        end
    else
        vRPclient.notify(source,{"~r~You do not have a Ecstasy license"})
    end
end)

-- Ecstasy END

-- Weed Start

RegisterServerEvent("FGS-Drugs:WeedCanCollect")
AddEventHandler("FGS-Drugs:WeedCanCollect", function()
    local source = source
    local user_id = vRP.getUserId(source)
    local max_weight = vRP.getInventoryMaxWeight(user_id)
    local weight = vRP.getInventoryWeight(user_id)
    local coords = GetEntityCoords(GetPlayerPed(source))
    local comparison = vector3(2943.5905761719,4690.5493164062,51.169910430908)
    if user_id == nil then 
        return 
    end
    if #(coords - comparison) > 500 then 
        vRP.AnticheatBanVRP(user_id, "unlucky")
    return 
    end   
    if vRP.hasPermission(user_id, "weed.license") then 
        if max_weight > weight then 
            TriggerClientEvent("drugs:animation", source, "world_human_gardener_plant")
        else
            vRPclient.notify(source,{"~r~No inventory space left"})
        end
    else
        vRPclient.notify(source,{"~r~You do not have a Weed license"})
    end
end)


RegisterServerEvent("FGS-Drugs:WeedCollect")
AddEventHandler("FGS-Drugs:WeedCollect", function(amount)
    local source = source
    local user_id = vRP.getUserId(source)
    local max_weight = vRP.getInventoryMaxWeight(user_id)
    local weight = vRP.getInventoryWeight(user_id)
    local coords = GetEntityCoords(GetPlayerPed(source))
    local comparison = vector3(2943.5905761719,4690.5493164062,51.169910430908)
    if amount > 5 then 
        vRP.AnticheatBanVRP(user_id, "unlucky")
        return 
    end
    if #(coords - comparison) > 500 then 
        vRP.AnticheatBanVRP(user_id, "unlucky")
    return 
    end
    if vRP.hasPermission(user_id, "weed.license") then 
        if haveEnoughtSpace(user_id, "weed_seeds", amount) then 
            vRP.giveInventoryItem(user_id, "weed_seeds", 4, true)
        else
            vRPclient.notify(source,{"~r~No inventory space left"})
        end
    else
        vRPclient.notify(source,{"~r~You do not have a Weed license"})
    end
end)


RegisterServerEvent("FGS-Drugs:WeedCanProcess")
AddEventHandler("FGS-Drugs:WeedCanProcess", function()
    local source = source
    local user_id = vRP.getUserId(source)
    local max_weight = vRP.getInventoryMaxWeight(user_id)
    local weight = vRP.getInventoryWeight(user_id)
    local coords = GetEntityCoords(GetPlayerPed(source))
    local comparison = vector3(1945.3312988281,4853.1108398438,45.452812194824)
    if user_id == nil then 
        return 
    end
    if #(coords - comparison) > 500 then 
        vRP.AnticheatBanVRP(user_id, "unlucky")
    return 
    end   
    if vRP.hasPermission(user_id, "weed.license") then 
        if max_weight > weight then 
            TriggerClientEvent("drugs:animation", source, "WORLD_HUMAN_CLIPBOARD")
        else
            vRPclient.notify(source,{"~r~No inventory space left"})
        end
    else
        vRPclient.notify(source,{"~r~You do not have a weed license"})
    end
end)


RegisterServerEvent("FGS-Drugs:WeedProcess")
AddEventHandler("FGS-Drugs:WeedProcess", function(amount)
    local source = source
    local user_id = vRP.getUserId(source)
    local max_weight = vRP.getInventoryMaxWeight(user_id)
    local weight = vRP.getInventoryWeight(user_id)
    local coords = GetEntityCoords(GetPlayerPed(source))
    local comparison = vector3(1945.3312988281,4853.1108398438,45.452812194824)
    if user_id == nil then 
        return 
    end
    if amount > 5 then 
        vRP.AnticheatBanVRP(user_id, "unlucky")
        return 
    end
    if #(coords - comparison) > 500 then 
        vRP.AnticheatBanVRP(user_id, "unlucky")
    return 
    end
    if vRP.hasPermission(user_id, "weed.license") then 
        if vRP.tryGetInventoryItem(user_id, "weed_seeds", 4, false) then
           -- TriggerClientEvent("drugs:animation", source, "world_human_gardener_plant")
           -- Wait(10000)
            if haveEnoughtSpace(user_id, "weed", amount - 4) then
                vRP.giveInventoryItem(user_id, "weed", 1, true)
            else
                vRPclient.notify(source,{"~r~No inventory space left"})
            end
        else
            vRPclient.notify(source,{"~r~ Not enough weed"})
        end
    else
        vRPclient.notify(source,{"~r~You do not have a Weed license"})
    end
end)

-- Weed END

-- Diamond Start

RegisterServerEvent("FGS-Drugs:DiamondCanCollect")
AddEventHandler("FGS-Drugs:DiamondCanCollect", function()
    local source = source
    local user_id = vRP.getUserId(source)
    local max_weight = vRP.getInventoryMaxWeight(user_id)
    local weight = vRP.getInventoryWeight(user_id)
    local coords = GetEntityCoords(GetPlayerPed(source))
    local comparison = vector3(409.96615600586,2891.7504882813,41.319911956787)
    if user_id == nil then 
        return 
    end
    if #(coords - comparison) > 500 then 
        vRP.AnticheatBanVRP(user_id, "unlucky")
    return 
    end   
    if vRP.hasPermission(user_id, "diamond.license") then 
        if max_weight > weight then 
            TriggerClientEvent("Animation:pickaxe", source, "world_human_gardener_plant")
        else
            vRPclient.notify(source,{"~r~No inventory space left"})
        end
    else
        vRPclient.notify(source,{"~r~You do not have a Diamond license"})
    end
end)

RegisterServerEvent("FGS-Drugs:DiamondCollect")
AddEventHandler("FGS-Drugs:DiamondCollect", function(amount)
    local source = source
    local user_id = vRP.getUserId(source)
    local max_weight = vRP.getInventoryMaxWeight(user_id)
    local weight = vRP.getInventoryWeight(user_id)
    local coords = GetEntityCoords(GetPlayerPed(source))
    local comparison = vector3(409.96615600586,2891.7504882813,41.319911956787)
    if user_id == nil then 
        return 
    end
    if amount > 5 then 
        vRP.AnticheatBanVRP(user_id, "unlucky")
        return 
    end
    if #(coords - comparison) > 500 then 
        vRP.AnticheatBanVRP(user_id, "unlucky")
    return 
    end
    if vRP.hasPermission(user_id, "diamond.license") then 
        if haveEnoughtSpace(user_id, "crystal", amount) then 
            vRP.giveInventoryItem(user_id, "crystal", 4, true)
        else
            vRPclient.notify(source,{"~r~No inventory space left"})
        end
    else
        vRPclient.notify(source,{"~r~You do not have a Diamond license"})
    end
end)

RegisterServerEvent("FGS-Drugs:DiamondCanProcess")
AddEventHandler("FGS-Drugs:DiamondCanProcess", function()
    local source = source
    local user_id = vRP.getUserId(source)
    local max_weight = vRP.getInventoryMaxWeight(user_id)
    local weight = vRP.getInventoryWeight(user_id)
    local coords = GetEntityCoords(GetPlayerPed(source))
    local comparison = vector3(2665.3227539063,2845.0732421875,39.56840133667)
    if user_id == nil then 
        return 
    end
    if #(coords - comparison) > 500 then 
        vRP.AnticheatBanVRP(user_id, "unlucky")
    return 
    end   
    if vRP.hasPermission(user_id, "diamond.license") then 
        if max_weight > weight then 
            TriggerClientEvent("drugs:animation", source, "WORLD_HUMAN_WELDING")
        else
            vRPclient.notify(source,{"~r~No inventory space left"})
        end
    else
        vRPclient.notify(source,{"~r~You do not have a Diamond license"})
    end
end)



RegisterServerEvent("FGS-Drugs:DiamondProcess")
AddEventHandler("FGS-Drugs:DiamondProcess", function(amount)
    local source = source
    local user_id = vRP.getUserId(source)
    local max_weight = vRP.getInventoryMaxWeight(user_id)
    local weight = vRP.getInventoryWeight(user_id)
    local coords = GetEntityCoords(GetPlayerPed(source))
    local comparison = vector3(2665.3227539063,2845.0732421875,39.56840133667)
    if user_id == nil then 
        return 
    end
    if amount > 5 then 
        vRP.AnticheatBanVRP(user_id, "unlucky")
        return 
    end
    if #(coords - comparison) > 500 then 
        vRP.AnticheatBanVRP(user_id, "unlucky")
    return 
    end --comment testssss
    if vRP.hasPermission(user_id, "diamond.license") then 
        if vRP.tryGetInventoryItem(user_id, "crystal", 4, false) then
          --  TriggerClientEvent("drugs:animation", source, "world_human_gardener_plant")
           -- Wait(10000)
            if haveEnoughtSpace(user_id, "diamond", amount - 4) then
                vRP.giveInventoryItem(user_id, "diamond", 1, true)
            else
                vRPclient.notify(source,{"~r~No inventory space left"})
            end
        else
            vRPclient.notify(source,{"~r~ Not enough Crystal"})
        end
    else
        vRPclient.notify(source,{"~r~You do not have a Diamond license"})
    end
end)

-- Diamond END
-- Coke Start

RegisterServerEvent("FGS-Drugs:CokeCanCollect")
AddEventHandler("FGS-Drugs:CokeCanCollect", function()
    local source = source
    local user_id = vRP.getUserId(source)
    local max_weight = vRP.getInventoryMaxWeight(user_id)
    local weight = vRP.getInventoryWeight(user_id)
    local coords = GetEntityCoords(GetPlayerPed(source))
    local comparison = vector3(1467.2235107422,1112.7380371094,114.33924865723)
    if user_id == nil then 
        return 
    end
    if #(coords - comparison) > 500 then 
        vRP.AnticheatBanVRP(user_id, "unlucky")
    return 
    end   
    if vRP.hasPermission(user_id, "coke.license") then 
        if max_weight > weight then 
            TriggerClientEvent("drugs:animation", source, "world_human_gardener_plant")
        else
            vRPclient.notify(source,{"~r~No inventory space left"})
        end
    else
        vRPclient.notify(source,{"~r~You do not have a Coke license"})
    end
end)

RegisterServerEvent("FGS-Drugs:CokeCollect")
AddEventHandler("FGS-Drugs:CokeCollect", function(amount)
    local source = source
    local user_id = vRP.getUserId(source)
    local max_weight = vRP.getInventoryMaxWeight(user_id)
    local weight = vRP.getInventoryWeight(user_id)
    local coords = GetEntityCoords(GetPlayerPed(source))
    local comparison = vector3(1467.2235107422,1112.7380371094,114.33924865723)
    if user_id == nil then 
        return 
    end
    if amount > 5 then 
        vRP.AnticheatBanVRP(user_id, "unlucky")
        return 
    end
    if #(coords - comparison) > 500 then 
        vRP.AnticheatBanVRP(user_id, "unlucky")
    return 
    end
    if vRP.hasPermission(user_id, "coke.license") then 
        if haveEnoughtSpace(user_id, "coke_seeds", amount) then 
            vRP.giveInventoryItem(user_id, "coke_seeds", 4, true)
        else
            vRPclient.notify(source,{"~r~No inventory space left"})
        end
    else
        vRPclient.notify(source,{"~r~You do not have a Coke license"})
    end
end)


RegisterServerEvent("FGS-Drugs:CokeCanProcess")
AddEventHandler("FGS-Drugs:CokeCanProcess", function()
    local source = source
    local user_id = vRP.getUserId(source)
    local max_weight = vRP.getInventoryMaxWeight(user_id)
    local weight = vRP.getInventoryWeight(user_id)
    local coords = GetEntityCoords(GetPlayerPed(source))
    local comparison = vector3(-291.93908691406,2524.5732421875,74.659271240234)
    if user_id == nil then 
        return 
    end
    if #(coords - comparison) > 500 then 
        vRP.AnticheatBanVRP(user_id, "unlucky")
    return 
    end   
    if vRP.hasPermission(user_id, "coke.license") then 
        if max_weight > weight then 
            TriggerClientEvent("drugs:animation", source, "WORLD_HUMAN_CLIPBOARD")
        else
            vRPclient.notify(source,{"~r~No inventory space left"})
        end
    else
        vRPclient.notify(source,{"~r~You do not have a Coke license"})
    end
end)


RegisterServerEvent("FGS-Drugs:CocaineProcess")
AddEventHandler("FGS-Drugs:CocaineProcess", function(amount)
    local source = source
    local user_id = vRP.getUserId(source)
    local max_weight = vRP.getInventoryMaxWeight(user_id)
    local weight = vRP.getInventoryWeight(user_id)
    local coords = GetEntityCoords(GetPlayerPed(source))
    local comparison = vector3(-291.93908691406,2524.5732421875,74.659271240234)
    if user_id == nil then 
        return 
    end
    if amount > 5 then 
        vRP.AnticheatBanVRP(user_id, "unlucky")
        return 
    end
    if #(coords - comparison) > 500 then 
        vRP.AnticheatBanVRP(user_id, "unlucky")
    return 
    end --comment testssss
    if vRP.hasPermission(user_id, "coke.license") then 
        if vRP.tryGetInventoryItem(user_id, "coke_seeds", 4, false) then
         --   TriggerClientEvent("drugs:animation", source, "world_human_gardener_plant")
          --  Wait(8000)
            if haveEnoughtSpace(user_id, "coke", amount - 4) then
                vRP.giveInventoryItem(user_id, "coke", 1, true)
            else
                vRPclient.notify(source,{"~r~No inventory space left"})
            end
        else
            vRPclient.notify(source,{"~r~ Not enough coke_seeds"})
        end
    else
        vRPclient.notify(source,{"~r~You do not have a Coke license"})
    end
end)

-- Coke END

-- Meth Start

RegisterServerEvent("FGS-Drugs:MethCanCollect")
AddEventHandler("FGS-Drugs:MethCanCollect", function()
    local source = source
    local user_id = vRP.getUserId(source)
    local max_weight = vRP.getInventoryMaxWeight(user_id)
    local weight = vRP.getInventoryWeight(user_id)
    local coords = GetEntityCoords(GetPlayerPed(source))
    local comparison = vector3(422.35244750977,6465.5004882812,28.819103240967)
    if user_id == nil then 
        return 
    end
    if #(coords - comparison) > 500 then 
        vRP.AnticheatBanVRP(user_id, "unlucky")
    return 
    end   
    if vRP.hasPermission(user_id, "meth.license") then 
        if max_weight > weight then 
            TriggerClientEvent("drugs:animation", source, "world_human_gardener_plant")
        else
            vRPclient.notify(source,{"~r~No inventory space left"})
        end
    else
        vRPclient.notify(source,{"~r~You do not have a Meth license"})
    end
end)

RegisterServerEvent("FGS-Drugs:MethCollect")
AddEventHandler("FGS-Drugs:MethCollect", function(amount)
    local source = source
    local user_id = vRP.getUserId(source)
    local max_weight = vRP.getInventoryMaxWeight(user_id)
    local weight = vRP.getInventoryWeight(user_id)
    local coords = GetEntityCoords(GetPlayerPed(source))
    local comparison = vector3(422.35244750977,6465.5004882812,28.819103240967)
    if user_id == nil then 
        return 
    end
    if amount > 5 then 
        vRP.AnticheatBanVRP(user_id, "unlucky")
        return 
    end
    if #(coords - comparison) > 500 then 
        vRP.AnticheatBanVRP(user_id, "unlucky")
    return 
    end
    if vRP.hasPermission(user_id, "meth.license") then 
        if haveEnoughtSpace(user_id, "meth_seeds", amount) then 
            vRP.giveInventoryItem(user_id, "meth_seeds", 4, true)
        else
            vRPclient.notify(source,{"~r~No inventory space left"})
        end
    else
        vRPclient.notify(source,{"~r~You do not have a Meth license"})
    end
end)

RegisterServerEvent("FGS-Drugs:MethCanProcess")
AddEventHandler("FGS-Drugs:MethCanProcess", function()
    local source = source
    local user_id = vRP.getUserId(source)
    local max_weight = vRP.getInventoryMaxWeight(user_id)
    local weight = vRP.getInventoryWeight(user_id)
    local coords = GetEntityCoords(GetPlayerPed(source))
    local comparison = vector3(2338.5649414062,2570.6274414062,47.725009918213)
    if user_id == nil then 
        return 
    end
    if #(coords - comparison) > 500 then 
        vRP.AnticheatBanVRP(user_id, "unlucky")
    return 
    end   
    if vRP.hasPermission(user_id, "meth.license") then 
        if max_weight > weight then 
            TriggerClientEvent("drugs:animation", source, "WORLD_HUMAN_CLIPBOARD")
        else
            vRPclient.notify(source,{"~r~No inventory space left"})
        end
    else
        vRPclient.notify(source,{"~r~You do not have a Meth license"})
    end
end)

RegisterServerEvent("FGS-Drugs:MethProcess")
AddEventHandler("FGS-Drugs:MethProcess", function(amount)
    local source = source
    local user_id = vRP.getUserId(source)
    local max_weight = vRP.getInventoryMaxWeight(user_id)
    local weight = vRP.getInventoryWeight(user_id)
    local coords = GetEntityCoords(GetPlayerPed(source))
    local comparison = vector3(2338.5649414062,2570.6274414062,47.725009918213)
    if user_id == nil then 
        return 
    end
    if amount > 5 then 
        vRP.AnticheatBanVRP(user_id, "unlucky")
        return 
    end
    if #(coords - comparison) > 500 then 
        vRP.AnticheatBanVRP(user_id, "unlucky")
    return 
    end
    if vRP.hasPermission(user_id, "meth.license") then 
        if vRP.tryGetInventoryItem(user_id, "meth_seeds", 4, false) then
            --TriggerClientEvent("drugs:animation", source, "world_human_gardener_plant")
            --Wait(0)
            if haveEnoughtSpace(user_id, "meth", amount - 4) then
                vRP.giveInventoryItem(user_id, "meth", 1, true)
            else
                vRPclient.notify(source,{"~r~No inventory space left"})
            end
        else
            vRPclient.notify(source,{"~r~ Not enough meth_seeds"})
        end
    else
        vRPclient.notify(source,{"~r~You do not have a Meth license"})
    end
end)

-- Meth END

-- Heroin Start

RegisterServerEvent("FGS-Drugs:HeroinCanCollect")
AddEventHandler("FGS-Drugs:HeroinCanCollect", function()
    local source = source
    local user_id = vRP.getUserId(source)
    local max_weight = vRP.getInventoryMaxWeight(user_id)
    local weight = vRP.getInventoryWeight(user_id)
    local coords = GetEntityCoords(GetPlayerPed(source))
    local comparison = vector3(-1907.5427246094,2117.8500976562,127.10972595215)
    if #(coords - comparison) > 500 then 
        vRP.AnticheatBanVRP(user_id, "unlucky")
    return 
    end   
    if vRP.hasPermission(user_id, "heroin.license") then 
        if max_weight > weight then 
            TriggerClientEvent("drugs:animation", source, "world_human_gardener_plant")
        else
            vRPclient.notify(source,{"~r~No inventory space left"})
        end
    else
        vRPclient.notify(source,{"~r~You do not have a Heroin license"})
    end
end)

RegisterServerEvent("FGS-Drugs:HeroinCollect")
AddEventHandler("FGS-Drugs:HeroinCollect", function(amount)
    local source = source
    local user_id = vRP.getUserId(source)
    local max_weight = vRP.getInventoryMaxWeight(user_id)
    local weight = vRP.getInventoryWeight(user_id)
    local coords = GetEntityCoords(GetPlayerPed(source))
    local comparison = vector3(-1907.5427246094,2117.8500976562,127.10972595215)
    if amount > 5 then 
        vRP.AnticheatBanVRP(user_id, "unlucky")
        return 
    end
    if #(coords - comparison) > 500 then 
        vRP.AnticheatBanVRP(user_id, "unlucky")
    return 
    end
    if vRP.hasPermission(user_id, "heroin.license") then 
        if haveEnoughtSpace(user_id, "heroin_seeds", amount) then 
            vRP.giveInventoryItem(user_id, "heroin_seeds", 4, true)
        else
            vRPclient.notify(source,{"~r~No inventory space left"})
        end
    else
        vRPclient.notify(source,{"~r~You do not have a Heroin license"})
    end
end)


RegisterServerEvent("FGS-Drugs:HeroinCanProcess")
AddEventHandler("FGS-Drugs:HeroinCanProcess", function()
    local source = source
    local user_id = vRP.getUserId(source)
    local max_weight = vRP.getInventoryMaxWeight(user_id)
    local weight = vRP.getInventoryWeight(user_id)
    local coords = GetEntityCoords(GetPlayerPed(source))
    local comparison = vector3(2432.4343261719,4970.1743164062,42.347618103027)
    if user_id == nil then 
        return 
    end
    if #(coords - comparison) > 500 then 
        vRP.AnticheatBanVRP(user_id, "unlucky")
    return 
    end   
    if vRP.hasPermission(user_id, "heroin.license") then 
        if max_weight > weight then 
            TriggerClientEvent("drugs:animation", source, "WORLD_HUMAN_CLIPBOARD")
        else
            vRPclient.notify(source,{"~r~No inventory space left"})
        end
    else
        vRPclient.notify(source,{"~r~You do not have a Heroin license"})
    end
end)

RegisterServerEvent("FGS-Drugs:HeroinProcess")
AddEventHandler("FGS-Drugs:HeroinProcess", function(amount)
    local source = source
    local user_id = vRP.getUserId(source)
    local max_weight = vRP.getInventoryMaxWeight(user_id)
    local weight = vRP.getInventoryWeight(user_id)
    local coords = GetEntityCoords(GetPlayerPed(source))
    local comparison = vector3(2432.4343261719,4970.1743164062,42.347618103027)
    if amount > 5 then 
        vRP.AnticheatBanVRP(user_id, "unlucky")
        return 
    end
    if #(coords - comparison) > 500 then 
        vRP.AnticheatBanVRP(user_id, "unlucky")
    return 
    end
    if vRP.hasPermission(user_id, "heroin.license") then 
        if vRP.tryGetInventoryItem(user_id, "heroin_seeds", 4, false) then
           -- TriggerClientEvent("drugs:animation", source, "world_human_gardener_plant")
           -- Wait(10000)
            if haveEnoughtSpace(user_id, "heroin", amount - 4) then
                vRP.giveInventoryItem(user_id, "heroin", 1, true)
            else
                vRPclient.notify(source,{"~r~No inventory space left"})
            end
        else
            vRPclient.notify(source,{"~r~ Not enough heroin_seeds"})
        end
    else
        vRPclient.notify(source,{"~r~You do not have a Heroin license"})
    end
end)

-- Heroin END