local comaAnim = {}
local in_coma = false
local coma_left = 150
local secondsTilBleedout = 150
local playerCanRespawn = false 
local deathPosition
local IsNHSOnline = 0 
local HasCalledNHS = false

local comaAnim = {}
local DeathAnim = 100

Citizen.CreateThread(function()
    while true do 
        if IsDisabledControlJustPressed(0,38) then
            if playerCanRespawn and in_coma then
                respawnThePlayer()
            end
            if in_coma and IsNHSOnline > 0 and not playerCanRespawn and not HasCalledNHS then 
                HasCalledNHS = true 
                TriggerServerEvent("FGS:recieveNHSCall2")
            end
            Wait(1000) 
        end
        Wait(0)
    end
end)

RegisterNetEvent("FGS:IsNHSOnline", function(value)
    IsNHSOnline = value
end)

RegisterNetEvent('FGS:JobLootChecked')
AddEventHandler('FGS:JobLootChecked', function(lootbags)
    if lootbags then
        print("")
    elseif not lootbags then
        FGS_server_callback('vRP:InComa')
    end
end)


function respawnThePlayer()
    tvRP.killComa()
    TriggerServerEvent('VRP:clearinvres')
    Wait(300)
    in_coma = false
    local ped = PlayerPedId()
    playerCanRespawn = false
    HasCalledNHS = false 
    secondsTilBleedout = 100
    TriggerEvent("FGS:FixPlayer")
    tvRP.reviveComa()
end
local Killer = ""


Citizen.CreateThread(function() -- coma thread
    Wait(800)
    exports.spawnmanager:setAutoSpawn(false)
    while true do
        Wait(0)
        
        local ped = PlayerPedId()
        local health = GetEntityHealth(ped)
        if IsEntityDead(PlayerPedId()) and not in_coma then --Wait for death check
            vRPserver.StoreWeaponsDead()
            local PedKiller = GetPedSourceOfDeath(PlayerPedId())
            if IsEntityAPed(PedKiller) and IsPedAPlayer(PedKiller) then
                Killer = NetworkGetPlayerIndexFromPed(PedKiller)
            elseif IsEntityAVehicle(PedKiller) and IsEntityAPed(GetPedInVehicleSeat(PedKiller, -1)) and IsPedAPlayer(GetPedInVehicleSeat(PedKiller, -1)) then
                Killer = NetworkGetPlayerIndexFromPed(GetPedInVehicleSeat(PedKiller, -1))
            end
            Killer = GetPlayerName(Killer)
            pbCounter = 100
            local plyCoords = GetEntityCoords(PlayerPedId(),true)
            FGS_server_callback('FGS:JobLootCheck')
            
            TriggerEvent('FGS:3SECONDS')
            tvRP.ejectVehicle()
            in_coma = true
            deathPosition = plyCoords
            local x,y,z = table.unpack(deathPosition)
            vRPserver.updatePos({x,y,z})
            vRPserver.updateHealth({0})

            TriggerServerEvent('vRP:InComa')
            TriggerEvent('vRP:IsInMoneyComa', true)
            vRPserver.MoneyDrop()
            Wait(500) --Need wait, otherwise will autorevive in next check
        end

        if DeathAnim <= 0  then --Been 10 seconds, proceed to play anim check 
            DeathAnim = 100 
            local entityDead = GetEntityHealth(PlayerPedId())
            while entityDead <= 100 do
                Wait(0)
                local x,y,z = tvRP.getPosition()
                NetworkResurrectLocalPlayer(x, y, z, GetEntityHeading(PlayerPedId()), true, true, false)
                entityDead = GetEntityHealth(PlayerPedId())
            end
            SetEntityHealth(PlayerPedId(), 102)
            SetEntityInvincible(PlayerPedId(),true)
            comaAnim = getRandomComaAnimation()
            if not HasAnimDictLoaded(comaAnim.dict) then
                RequestAnimDict(comaAnim.dict)
                while not HasAnimDictLoaded(comaAnim.dict) do
                    Wait(0)
                end
            end
            TaskPlayAnim(PlayerPedId(), comaAnim.dict, comaAnim.anim, 3.0, 1.0, -1, 1, 0, 0, 0, 0 )
        end

        if health > cfg.coma_threshold and in_coma then --Revive check
            if IsEntityDead(PlayerPedId()) then
                local x,y,z = tvRP.getPosition()
                NetworkResurrectLocalPlayer(x, y, z, GetEntityHeading(PlayerPedId()), true, true, false)
                Wait(0)
            end
        
            playerCanRespawn = false 
            tvRP.disableComa()
            DeathAnim = 100 

            SetEntityInvincible(PlayerPedId(),false)
            ClearPedSecondaryTask(PlayerPedId())
            Citizen.CreateThread(function()
                Wait(500)
                ClearPedSecondaryTask(PlayerPedId())
                ClearPedTasks(PlayerPedId())
            end)    
        end 

        local health = GetEntityHealth(PlayerPedId())
        if health <= cfg.coma_threshold and not in_coma then 
            SetEntityHealth(PlayerPedId(),0)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        if in_coma then
            local playerPed = PlayerPedId()
            if not IsEntityDead(playerPed) then
                if comaAnim.dict == nil then
                    comaAnim = getRandomComaAnimation()
                end
                if not IsEntityPlayingAnim(playerPed,comaAnim.dict,comaAnim.anim,3)  then
                    if comaAnim.dict ~= nil then
                        if not HasAnimDictLoaded(comaAnim.dict) then
                            RequestAnimDict(comaAnim.dict)
                            while not HasAnimDictLoaded(comaAnim.dict) do
                                Wait(0)
                            end
                        end
                        TaskPlayAnim(playerPed, comaAnim.dict, comaAnim.anim, 3.0, 1.0, -1, 1, 0, 0, 0, 0 )
                    end
                end
            end
            if GetEntityHealth(playerPed) > cfg.coma_threshold then 
                tvRP.disableComa()
                if IsEntityDead(playerPed) then
                    local x,y,z = tvRP.getPosition()
                    NetworkResurrectLocalPlayer(x, y, z, GetEntityHeading(PlayerPedId()),true, true, false)
                    Wait(0)
                end
                tvRP.disableComa()
                DeathAnim = 100 
                SetEntityInvincible(playerPed,false)
                ClearPedSecondaryTask(playerPed) 
            end
        end
        Wait(0)
    end
end)

function Initialize(scaleform)
    local scaleform = RequestScaleformMovie(scaleform)
    while not HasScaleformMovieLoaded(scaleform) do
        Citizen.Wait(0)
    end

    return scaleform
end

Citizen.CreateThread(function()
    local string = ""
    local scaleform = Initialize("mp_big_message_freemode")
    while true do 
        if in_coma then
            PushScaleformMovieFunction(scaleform, "SHOW_SHARD_WASTED_MP_MESSAGE")
            BeginTextCommandScaleformString("STRING")
            AddTextComponentSubstringTextLabel("RESPAWN_W")
            EndTextCommandScaleformString()
            PushScaleformMovieFunction(scaleformMovie, "SHOW_SHARD_WASTED_MP_MESSAGE")
            BeginTextCommandScaleformString("STRING")
            PushScaleformMovieFunctionParameterString(string)
            EndTextCommandScaleformString()
            DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255, 0) 

            if secondsTilBleedout > 0 then
                if IsNHSOnline > 0 then 
                    if Killer == nil then
                        Killer = "Unknown"
                    end
                    if HasCalledNHS then 
                        string = "You Have Died, Respawn available in ("..secondsTilBleedout.." seconds)\nNHS have been called\nKilled By " .. Killer
                    else
                        string = "You Have Died, Respawn available in ("..secondsTilBleedout.." seconds)\nPress [E] to Call NHS\nKilled By " .. Killer
                    end
                else
                    string = "You Have Died, Respawn available in ("..secondsTilBleedout.." seconds)\nKilled By " .. Killer
                end
                --DrawAdvancedTextOutline(0.605, 0.523, 0.005, 0.0028, 0.4, "You Have Died, Respawn available in ("..secondsTilBleedout.." seconds)", 255, 0, 0, 255, 7, 0)
            else
                playerCanRespawn = true
                string = "Press [E] To Respawn!"
                --DrawAdvancedTextOutline(0.605, 0.513, 0.005, 0.0028, 0.4, "Press [E] To Respawn!", 0, 0, 255, 255, 7, 0)
            end
            DisableControlAction(0,323,true)
            DisableControlAction(0,182,true)
            DisableControlAction(0,37,true)
            DisableControlAction(0, 1, true) -- Disable looking horizontally
            DisableControlAction(0, 2, true) -- Disable looking vertically
        end
        Wait(0)
    end 
end)

Citizen.CreateThread(function()
    while true do 
        if in_coma then
            secondsTilBleedout = secondsTilBleedout - 1
        end
        Wait(1000)
    end
end) 

Citizen.CreateThread(function()
    while DeathAnim <= 3 and DeathAnim >= 0 do
        Wait(1000)
        DeathAnim = DeathAnim - 1
    end
end) 

RegisterNetEvent("FGS:3SECONDS")
AddEventHandler("FGS:3SECONDS", function()
    DeathAnim = 3
    while DeathAnim <= 3 and DeathAnim >= 0 do
        Wait(1000)
        DeathAnim = DeathAnim - 1
    end
end)



function tvRP.disableComa()
    in_coma = false
    TriggerEvent('vRP:IsInMoneyComa', false)
end

function tvRP.isInComa()
    return in_coma
end

RegisterNetEvent("FGS:FixPlayer")
AddEventHandler("FGS:FixPlayer", function()
    local resurrectspamm = true
    Citizen.CreateThread(function()
        while true do 
            Wait(0)
            if resurrectspamm == true then 
                local ped = PlayerPedId()
                local x,y,z = GetEntityCoords(ped)
                respawnedrecent = false 
                NetworkResurrectLocalPlayer(x, y, z, true, true, false)
                Citizen.Wait(0)
                ClearPedTasksImmediately(PlayerPedId())
                resurrectspamm = false
                secondsTilBleedout = 60
                in_coma = false
                EnableControlAction(0, 73, true)
                tvRP.stopScreenEffect(cfg.coma_effect)
            end 
        end
    end)
end)

function tvRP.reviveComa()
    local ped = PlayerPedId()
    SetEntityInvincible(ped,false)
    tvRP.setRagdoll(false)
    tvRP.stopScreenEffect(cfg.coma_effect)
    SetEntityHealth(PlayerPedId(), 200)
    SetEntityCoords(PlayerPedId(), -45.393093109131, -1173.7066650391,26.110569000244)
end

-- kill the player if in coma
function tvRP.killComa()
    if in_coma then
        coma_left = 0
    end
end

Citizen.CreateThread(function() -- disable health regen, conflicts with coma system
    while true do
        SetPlayerHealthRechargeMultiplier(PlayerId(), 0.0)
        Wait(0)
    end
end)





function tvRP.varyHealth(variation)
    local ped = PlayerPedId()

    local n = math.floor(GetEntityHealth(ped)+variation)
    SetEntityHealth(ped,n)
end

function tvRP.reviveHealth()
    local ped = PlayerPedId()
    if GetEntityHealth(ped) == 102 then
        SetEntityHealth(ped,200)
    end
end

function tvRP.getHealth()
    return GetEntityHealth(PlayerPedId())
end

function tvRP.getArmour()
    return GetPedArmour(PlayerPedId())
end
function tvRP.setArmour(armour)
    Wait(3750)
    SetPedArmour(PlayerPedId(), armour)
end


function tvRP.setHealth(health)
    local n = math.floor(health)
    SetEntityHealth(PlayerPedId(),n)
end

function tvRP.setFriendlyFire(flag)
    NetworkSetFriendlyFireOption(flag)
    SetCanAttackFriendly(PlayerPedId(), flag, flag)
end

function tvRP.setPolice(flag)
    local player = PlayerId()
    SetPoliceIgnorePlayer(player, not flag)
    SetDispatchCopsForPlayer(player, flag)
end

function getRandomComaAnimation()
-- --death emotes
    randomComaAnimations = {
        {"combat@damage@writheidle_a","writhe_idle_a"},
        {"combat@damage@writheidle_a","writhe_idle_b"},
        {"combat@damage@writheidle_a","writhe_idle_c"},
        {"combat@damage@writheidle_b","writhe_idle_d"},
        {"combat@damage@writheidle_b","writhe_idle_e"},
        {"combat@damage@writheidle_b","writhe_idle_f"},
        {"combat@damage@writheidle_c","writhe_idle_g"},
        {"combat@damage@rb_writhe","rb_writhe_loop"},
        {"combat@damage@writhe","writhe_loop"},
    }


    comaAnimation = {}
    
    math.randomseed(GetGameTimer())
    num = math.random(1,#randomComaAnimations)
    num = math.random(1,#randomComaAnimations)
    num = math.random(1,#randomComaAnimations)
    
    dict,anim = table.unpack(randomComaAnimations[num])
    comaAnimation["dict"] = dict
    comaAnimation["anim"] = anim
    --comaAnimation["dict"] = "combat@damage@writheidle_a"
    --comaAnimation["anim"] = "writhe_idle_a"
    --randomize this :)
    return comaAnimation
end

function HiDrawText3D(x, y, z, text)
    -- Use local function instead
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry('STRING')
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x, y, z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0 + 0.0125, 0.017 + factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end
