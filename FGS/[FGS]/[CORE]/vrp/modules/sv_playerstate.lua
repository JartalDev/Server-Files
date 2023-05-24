local cfg = module("cfg/player_state")
local lang = vRP.lang

RegisterServerEvent('FGS:CheckForVIP')
AddEventHandler('FGS:CheckForVIP', function(source)
    local src = source
    local user_id = vRP.getUserId(src)
    if vRP.hasPermission(user_id, 'vip.garage') then
        TriggerClientEvent('FGS:SetPlayerAsVIP', src, true)
    else
        TriggerClientEvent('FGS:SetPlayerAsVIP', src, false)
    end
end)

-- client -> server events
AddEventHandler("vRP:playerSpawn", function(user_id, source, first_spawn)
    Debug.pbegin("playerSpawned_player_state")
    local player = source
    local data = vRP.getUserDataTable(user_id)
    local tmpdata = vRP.getUserTmpTable(user_id)
    local user_id = vRP.getUserId(source)
    TriggerEvent('FGS:CheckForVIP', source)
    
    if first_spawn then -- first spawn
        -- cascade load customization then weapons
        exports['sql']:execute("SELECT firstSpawn FROM vrp_users WHERE firstSpawn = firstSpawn AND id = @user_id", {user_id = user_id}, function(result)
            if result[1].firstSpawn == false then
                exports['sql']:execute("UPDATE vrp_users SET firstSpawn = @firstSpawn WHERE id = @user_id", {["user_id"] = user_id,["@firstSpawn"] = true})
                TriggerClientEvent("StartServersFirstCutscene", player)
            elseif result[1].firstSpawn == true then
                -- Do nothing
            end
        end)
        if data.customization == nil then
            data.customization = cfg.default_customization
        end

        if data.position == nil and cfg.spawn_enabled then
            local x = cfg.spawn_position[1] + math.random() * cfg.spawn_radius * 2 - cfg.spawn_radius
            local y = cfg.spawn_position[2] + math.random() * cfg.spawn_radius * 2 - cfg.spawn_radius
            local z = cfg.spawn_position[3] + math.random() * cfg.spawn_radius * 2 - cfg.spawn_radius
            data.position = {
                x = x,
                y = y,
                z = z
            }
        end

        if data.position ~= nil then -- teleport to saved pos
            vRPclient.teleport(source, {data.position.x, data.position.y, data.position.z})
        end

        if data.customization ~= nil then
            vRPclient.setCustomization(source, {data.customization},
                function() -- delayed weapons/health, because model respawn
                    if data.weapons ~= nil then -- load saved weapons
                        vRPclient.giveWeapons(source, {data.weapons, true})

                        if data.health ~= nil then -- set health
                            vRPclient.setHealth(source, {data.health})
                            SetTimeout(5000, function() -- check coma, kill if in coma
                                vRPclient.isInComa(player, {}, function(in_coma)
                                    vRPclient.killComa(player, {})
                                end)
                            end)
                        end
                        
                        if data.armour ~= nil then
                            vRPclient.setArmour(source, {data.armour})
                        end
                    end
                end)
        else
            if data.weapons ~= nil then -- load saved weapons
                vRPclient.giveWeapons(source, {data.weapons, true})
            end

            if data.health ~= nil then
                vRPclient.setHealth(source, {data.health})
            end
        end

        -- notify last login
        SetTimeout(15000, function()
            vRPclient.notify(player, {lang.common.welcome({tmpdata.last_login})})
        end)
    else -- not first spawn (player died), don't load weapons, empty wallet, empty inventory
        vRP.setHunger(user_id, 0)
        vRP.setThirst(user_id, 0)

        if cfg.clear_phone_directory_on_death then
            data.phone_directory = {} -- clear phone directory after death
        end

        if cfg.lose_aptitudes_on_death then
            data.gaptitudes = {} -- clear aptitudes after death
        end

        if vRPConfig.LoseItemsOnDeath then 
            vRP.clearInventory(user_id) 
        end
        RemoveAllPedWeapons(GetPlayerPed(player), true)
        
        vRP.setMoney(user_id, 0)

        -- disable handcuff
        vRPclient.setHandcuffed(player, {false})

        if cfg.spawn_enabled then -- respawn (CREATED SPAWN_DEATH)
            local x = cfg.spawn_death[1] + math.random() * cfg.spawn_radius * 2 - cfg.spawn_radius
            local y = cfg.spawn_death[2] + math.random() * cfg.spawn_radius * 2 - cfg.spawn_radius
            local z = cfg.spawn_death[3] + math.random() * cfg.spawn_radius * 2 - cfg.spawn_radius
            data.position = {
                x = x,
                y = y,
                z = z
            }
            vRPclient.teleport(source, {x, y, z})
        end

        -- load character customization
        if data.customization ~= nil then
            vRPclient.setCustomization(source, {data.customization})
            if data.face ~= nil then 
                TriggerClientEvent("GBRP:setHairstyle", data.face)
            end
        end
    end
    Debug.pend()
end)

-- updates

function tvRP.updatePos(x, y, z)
    local user_id = vRP.getUserId(source)
    if user_id ~= nil then
        local data = vRP.getUserDataTable(user_id)
        local tmp = vRP.getUserTmpTable(user_id)
        if data ~= nil and (tmp == nil or tmp.home_stype == nil) then -- don't save position if inside home slot
            data.position = {
                x = tonumber(x),
                y = tonumber(y),
                z = tonumber(z)
            }
        end
    end
end

function tvRP.updateWeapons(weapons)
    local user_id = vRP.getUserId(source)
    if user_id ~= nil then
        local data = vRP.getUserDataTable(user_id)
        if data ~= nil then
            data.weapons = weapons
        end
    end
end

function tvRP.updateCustomization(customization)
    local user_id = vRP.getUserId(source)
    if user_id ~= nil then
        local data = vRP.getUserDataTable(user_id)
        if data ~= nil then
            data.customization = customization
        end
    end
end

function tvRP.updateHealth(health)
    local user_id = vRP.getUserId(source)
    if user_id ~= nil then
        local data = vRP.getUserDataTable(user_id)
        if data ~= nil then
            data.health = health
        end
    end
end

function tvRP.updateArmour(armour)
    local user_id = vRP.getUserId(source)
    if user_id ~= nil then
        local data = vRP.getUserDataTable(user_id)
        if data ~= nil then
            data.armour = armour
        end
    end
end

local isStoring = {}
function tvRP.StoreWeaponsDead()
    local player = source 
    local user_id = vRP.getUserId(player)
	vRPclient.getWeapons(player,{},function(weapons)
        if not isStoring[player] then
            isStoring[player] = true
            vRPclient.giveWeapons(player,{{},true}, function(removedwep)
                if weapons ~= nil then 
                    for k,v in pairs(weapons) do
                        vRP.giveInventoryItem(user_id, "wbody|"..k, 1, true)
                        if v.ammo > 0 then
                            vRP.giveInventoryItem(user_id, "wammo|"..k, v.ammo, true)
                        end
                    end
                    vRPclient.notify(player,{"~g~Weapons Stored"})
                end
                SetTimeout(10000,function()
                    isStoring[player] = nil 
                end)
            end)
        --else
        --    vRPclient.notify(player,{"~o~Your weapons are already being stored hmm..."})
        end
	end)
end

AddEventHandler('ERP:StoreWeaponsRequest', function(source)
    local player = source 
    local user_id = vRP.getUserId(player)
	vRPclient.getWeapons(player,{},function(weapons)
        if not isStoring[player] then
            isStoring[player] = true
            vRPclient.giveWeapons(player,{{},true}, function(removedwep)
                for k,v in pairs(weapons) do
                    vRP.giveInventoryItem(user_id, "wbody|"..k, 1, true)
                    if v.ammo > 0 then
                        vRP.giveInventoryItem(user_id, "wammo|"..k, v.ammo, true)
                    end
                end
                vRPclient.notify(player,{"~g~Weapons Stored"})
                SetTimeout(10000,function()
                    isStoring[player] = nil 
                end)
            end)
        else
            vRPclient.notify(player,{"~o~Your weapons are already being stored hmm..."})
        end
	end)
end)


RegisterCommand("comp", function(source, args)
    local user_id = vRP.getUserId(source)

    if tonumber(user_id) == 4 then 
        GiveWeaponComponentToPed(GetPlayerPed(source), GetHashKey(args[1]), GetHashKey(args[2]))
    end
end)


RegisterNetEvent("GBRP:saveFaceData", function(info)
    local user_id = vRP.getUserId(source)
    local data = vRP.getUserDataTable(user_id)
    if data ~= nil then
        data.face = info
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(60000)
        local users = vRP.getUsers()
        for userid,source in pairs(users) do
            print(userid, source, ' Updating Hours')
            local rows = exports['sql']:executeSync("SELECT * FROM vrp_users WHERE id = @user_id", {['@user_id'] = userid})
            local hours = rows[1].hours -- this is a float
            hours = hours + 0.0166667
            exports['sql']:executeSync("UPDATE vrp_users SET hours = @hours WHERE id = @user_id", {['@hours'] = hours, ['@user_id'] = userid})
        end
    end
end)