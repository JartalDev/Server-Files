local cfg = module("cfg/survival")
local lang = vRP.lang

-- api

RegisterServerEvent("FGS:JobLootCheck")
AddEventHandler("FGS:JobLootCheck",function()
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, "police.armoury") then
        TriggerClientEvent('FGS:JobLootChecked', source, true)
    elseif vRP.hasPermission(user_id, "nhs.menu") then
        TriggerClientEvent('FGS:JobLootChecked', source, true)
    else
        TriggerClientEvent('FGS:JobLootChecked', source, false)
    end
end)

function vRP.getHunger(user_id)
    local data = vRP.getUserDataTable(user_id)
    if data then
        return data.hunger
    end

    return 0
end

function vRP.getThirst(user_id)
    local data = vRP.getUserDataTable(user_id)
    if data then
        return data.thirst
    end

    return 0
end

function vRP.setHunger(user_id, value)
    local data = vRP.getUserDataTable(user_id)
    if data then
        data.hunger = value
        if data.hunger < 0 then
            data.hunger = 0
        elseif data.hunger > 100 then
            data.hunger = 100
        end

        -- update bar
        local source = vRP.getUserSource(user_id)
        vRPclient.setProgressBarValue(source, {"vRP:hunger", data.hunger})
        if data.hunger >= 100 then
            vRPclient.setProgressBarText(source, {"vRP:hunger", lang.survival.starving()})
        else
            vRPclient.setProgressBarText(source, {"vRP:hunger", ""})
        end
    end
end

function vRP.setThirst(user_id, value)
    local data = vRP.getUserDataTable(user_id)
    if data then
        data.thirst = value
        if data.thirst < 0 then
            data.thirst = 0
        elseif data.thirst > 100 then
            data.thirst = 100
        end

        -- update bar
        local source = vRP.getUserSource(user_id)
        vRPclient.setProgressBarValue(source, {"vRP:thirst", data.thirst})
        if data.thirst >= 100 then
            vRPclient.setProgressBarText(source, {"vRP:thirst", lang.survival.thirsty()})
        else
            vRPclient.setProgressBarText(source, {"vRP:thirst", ""})
        end
    end
end

function vRP.varyHunger(user_id, variation)
    if vRPConfig.EnableFoodAndWater then 
        local data = vRP.getUserDataTable(user_id)
        if data then
            local was_starving = data.hunger >= 100
            data.hunger = data.hunger + variation
            local is_starving = data.hunger >= 100

            -- apply overflow as damage
            local overflow = data.hunger - 100
            if overflow > 0 then
                vRPclient.varyHealth(vRP.getUserSource(user_id), {-overflow * cfg.overflow_damage_factor})
            end

            if data.hunger < 0 then
                data.hunger = 0
            elseif data.hunger > 100 then
                data.hunger = 100
            end

            -- set progress bar data
            local source = vRP.getUserSource(user_id)
            vRPclient.setProgressBarValue(source, {"vRP:hunger", data.hunger})
            if was_starving and not is_starving then
                vRPclient.setProgressBarText(source, {"vRP:hunger", ""})
            elseif not was_starving and is_starving then
                vRPclient.setProgressBarText(source, {"vRP:hunger", lang.survival.starving()})
            end
        end
    end
end

function vRP.varyThirst(user_id, variation)
    if vRPConfig.EnableFoodAndWater then 
        local data = vRP.getUserDataTable(user_id)
        if data then
            local was_thirsty = data.thirst >= 100
            data.thirst = data.thirst + variation
            local is_thirsty = data.thirst >= 100

            -- apply overflow as damage
            local overflow = data.thirst - 100
            if overflow > 0 then
                vRPclient.varyHealth(vRP.getUserSource(user_id), {-overflow * cfg.overflow_damage_factor})
            end

            if data.thirst < 0 then
                data.thirst = 0
            elseif data.thirst > 100 then
                data.thirst = 100
            end

            -- set progress bar data
            local source = vRP.getUserSource(user_id)
            vRPclient.setProgressBarValue(source, {"vRP:thirst", data.thirst})
            if was_thirsty and not is_thirsty then
                vRPclient.setProgressBarText(source, {"vRP:thirst", ""})
            elseif not was_thirsty and is_thirsty then
                vRPclient.setProgressBarText(source, {"vRP:thirst", lang.survival.thirsty()})
            end
        end
    end
end

-- tunnel api (expose some functions to clients)

function tvRP.varyHunger(variation)
    if vRPConfig.EnableFoodAndWater then 
        local user_id = vRP.getUserId(source)
        if user_id ~= nil then
            vRP.varyHunger(user_id, variation)
        end
    end
end

function tvRP.varyThirst(variation)
    if vRPConfig.EnableFoodAndWater then 
        local user_id = vRP.getUserId(source)
        if user_id ~= nil then
            vRP.varyThirst(user_id, variation)
        end
    end
end

-- tasks

-- hunger/thirst increase
function task_update()
    for k, v in pairs(vRP.users) do
        vRP.varyHunger(v, cfg.hunger_per_minute)
        vRP.varyThirst(v, cfg.thirst_per_minute)
    end

    SetTimeout(60000, task_update)
end

if vRPConfig.EnableFoodAndWater then 
    task_update()
end

-- handlers

-- init values
AddEventHandler("vRP:playerJoin", function(user_id, source, name, last_login)
    local data = vRP.getUserDataTable(user_id)
    if data.hunger == nil then
        data.hunger = 0
        data.thirst = 0
    end
end)

-- add survival progress bars on spawn
AddEventHandler("vRP:playerSpawn", function(user_id, source, first_spawn)
    local data = vRP.getUserDataTable(user_id)
    vRPclient.setPolice(source, {cfg.police})
    vRPclient.setFriendlyFire(source, {cfg.pvp})
    vRP.setHunger(user_id, data.hunger)
    vRP.setThirst(user_id, data.thirst)
end)



Citizen.CreateThread(function()
    while true do 
        Wait(30000)
        local people = vRP.getUsersByPermission("clockon.nhs")
        TriggerClientEvent("FGS:IsNHSOnline", -1, #people)
    end
end)