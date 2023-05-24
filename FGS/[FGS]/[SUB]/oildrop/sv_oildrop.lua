local Tunnel = module('vrp', 'lib/Tunnel')
local Proxy = module('vrp', 'lib/Proxy')
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "vRP_gunshop")


local Coords = { --Where you want the crate to spawn ALL MESSAGES YOU CAN DELETE AFTER (WOLFHILL)
    vector3(4818.68,1985.43,41.32+1600),
    vector3(4819.64,1995.39,34.08+1600),

}

local stayTime = 4600 --How long till the airdrop disappears
local spawnTime = 3600
local amountOffItems = 600 --How many items are in the crate 
local used = false

local dropMsg = "The Oil Rig Crate is landing..."
local removeMsg = "The Crate has vanished..."
local lootedMsg = "Someone looted the Oil Rig Crate!"

local avaliableItems = { --Where you put you weapons and how frequently you want them to spawn E.G M1911 with its ammo. and put that in there twice and akm once the m1911 will have more chance of spawning
    {"wammo|WEAPON_m1911", "9 mm Bullets", 250, 0.01},
    {"wbody|WEAPON_m1911", "Weapon_m1911 body", 1, 2.5},
    {"wammo|WEAPON_ak74", "7.62 mm Bullets", 250, 0.01},
}

local currentLoot = {}

RegisterServerEvent('openLootCrate', function(playerCoords, boxCoords)
    local source = source
    user_id = vRP.getUserId({source})
    if #(playerCoords - boxCoords) < 2.0 then
        if not used then
            
                used = true
                vRP.giveInventoryItem({user_id, "wbody|" .. 'WEAPON_MOSIN', 1, true})               
                vRP.giveInventoryItem({user_id, "wbody|" .. 'WEAPON_UMP45', 1, true})
                vRP.giveInventoryItem({user_id, "wbody|" .. 'WEAPON_ACR1', 1, true})
                vRP.giveInventoryItem({user_id, "wbody|" .. 'WEAPON_M4A1WHITENOISE', 1, true})
                vRPclient.notify(source,{'Received ~g~£100,000 ~w~Cash.'})
                vRP.giveMoney({user_id,100000})
                
                --TriggerClientEvent('chatMessage', -1, "^1[FGS RP]: ^0 ", {66, 72, 245}, "The Drop has been Looted.", "alert")
        TriggerClientEvent('chat:addMessage', -1, {
            template = '<div style="padding: 0.5vw; margin: 0.4vw; background-color: rgba(255, 0, 0, 0.6); border-radius: 4px;"><i class="fas fa-globe"></i> Supply Drops^7: ' .. 'The Drop has been Looted.' .. '</div>',
            args = { playerName, msg }
          })
          TriggerClientEvent("removeOil", -1)
        end
    end
end)

RegisterServerEvent('updateLoot', function(source, item, amount)
    local i = currentLoot[item]
    local j = i[2] - amount
    if (j > 0) then
        currentLoot[item] = {i[1], j, i[3]}
    else
        currentLoot[item] = nil
    end

    if #currentLoot == 0 then
        if not used then
            used = true
            TriggerClientEvent('chatMessage', -1, "^1[FGS RP]: ^0 ", {66, 72, 245}, lootedMsg, "alert")
        end
    end

    TriggerClientEvent('FGS:SendSecondaryInventoryData', source, currentLoot, vRP.computeItemsWeight({currentLoot}), 30)
end) 

Citizen.CreateThread(function()
    while (true) do
        Wait(3600000)
        if #GetPlayers() >= 10 then
            local num = math.random(1, #Coords)
            local coords = Coords[num]

            for i = 1, amountOffItems do
                local secondNum = math.random(1, #avaliableItems)
                local k = avaliableItems[secondNum]
                currentLoot[k[1]] = {k[2], k[3], k[4]}
            end 

            TriggerClientEvent('oilDrop', -1, coords)
            --TriggerClientEvent('chatMessage', -1, "^1[FGS RP]: ^0", {66, 72, 245}, dropMsg, "alert")
            TriggerClientEvent('chat:addMessage', -1, {
                template = '<div style="padding: 0.5vw; margin: 0.4vw; background-color: rgba(255, 0, 0, 0.6); border-radius: 4px;"><i class="fas fa-globe"></i> Supply Drops^7: ' .. dropMsg .. '</div>',
                args = { playerName, msg }
              })
            used = false
        end
        -- Citizen.SetTimeout(stayTime * 1000, function()
        --     TriggerClientEvent("removeOil", -1)
        --     TriggerClientEvent('chatMessage', -1, "^1[FGS RP]: ^0 ", {66, 72, 245}, removeMsg, "alert")
        -- end)

        -- Wait(stayTime * 1000 + 500)
        Wait(1000 * 1200)
        TriggerClientEvent("removeOil", -1)
        Wait(10000)
    end
end)