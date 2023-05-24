vRP = Proxy.getInterface("vRP")
vRPbodybag = Proxy.getInterface("vRP_BodyBag")

local bodyBag = nil

local attached = false
local notloaded = true
Citizen.CreateThread(function()
    Citizen.Wait(1)
    while notloaded == true do
        RequestModel(Config.bag_model)

        while not HasModelLoaded(Config.bag_model) do
            Citizen.Wait(1)
        end
        notloaded = false
    end


end)

Citizen.CreateThread(function()
    while true do
        Wait(100)
        local pedEntity =PlayerPedId()
        if IsEntityVisible(pedEntity) then
            local playerPed = PlayerPedId()
            DeleteObject(bodyBag)
            DeleteEntity(bodyBag)
            SetEntityAsMissionEntity(bodyBag, false, false)
            SetEntityVisible(bodybag, false)
            SetModelAsNoLongerNeeded(bodyBag)
            bodyBag = nil
            attached = false
            justBagged = false
        end
    end


end)


RegisterCommand("bodybag", function(source, args, rawCommand)



    local closestPlayer = vRP.getNearestPlayer({2})
    local pedEntity = GetPlayerPed(GetPlayerFromServerId(closestPlayer))
    local targetPed = GetPlayerPed(closestPlayer)
    if IsEntityVisible(pedEntity) == false then
        return vRP.notify({"~r~ Already bagged"})
    end
    if closestPlayer then

        TriggerServerEvent('VRP_BODYBAG:Trigger', closestPlayer)

    end
end, false)



function PutInBodybag()

    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)

    deadCheck = vRP.isInComa()
    print(deadCheck)

    if deadCheck then
        attached = true
        SetEntityVisible(playerPed, false, false)
        Wait(1000)
        RequestModel(Config.bag_model)

        while not HasModelLoaded(Config.bag_model) do
            Citizen.Wait(1)
        end

        bodyBag = CreateObject(Config.bag_hash, playerCoords.x, playerCoords.y, playerCoords.z, true, true, true)
        TriggerServerEvent("VRPANTI:MRCAR",ObjToNet(bodyBag))
        AttachEntityToEntity(bodyBag, playerPed, 0, -0.2, 0.75, -0.2, 0.0, 0.0, 0.0, false, false, false, false, 20, false)
        attached = true

    end
end

RegisterNetEvent('VRP_BODYBAG:PutInBag')
AddEventHandler('VRP_BODYBAG:PutInBag', function()

    print("Bagged")

    PutInBodybag()

end)

Citizen.CreateThread(function()
    while true do
        Wait(0)
        if attached == true then
            local playerPed = PlayerPedId()
            Wait(299999)
            DeleteObject(bodyBag)
            DeleteEntity(bodyBag)
            DetachEntity(playerPed, true, false)
            SetEntityVisible(playerPed, true, true)
            SetEntityAsMissionEntity(bodyBag, false, false)
            SetEntityVisible(bodybag, false)
            SetModelAsNoLongerNeeded(bodyBag)
            bodyBag = nil
            attached = false
            justBagged = false
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(100)
        local playerPed = PlayerPedId()

        deadCheck =  vRP.isInComa()

        if deadCheck == false and attached == true then

            DetachEntity(playerPed, true, false)
            SetEntityVisible(playerPed, true, true)

            SetEntityAsMissionEntity(bodyBag, false, false)
            SetEntityVisible(bodybag, false)
            SetModelAsNoLongerNeeded(bodyBag)

            DeleteObject(bodyBag)
            DeleteEntity(bodyBag)

            bodyBag = nil
            attached = false
            justBagged = false

        end

        Citizen.Wait(Config.freq_bag_off)

    end
end)
