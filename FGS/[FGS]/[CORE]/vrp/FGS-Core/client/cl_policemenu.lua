RMenu.Add('FGSPoliceMenu', 'main', RageUI.CreateMenu("", "~b~MET Police Menu",1250,100, "policemenu", "policemenu"))
RMenu.Add('FGSPoliceMenu', 'objectmenu',  RageUI.CreateSubMenu(RMenu:Get("FGSPoliceMenu", "main")))
RMenu.Add('FGSPoliceMenu', 'speedzones',  RageUI.CreateSubMenu(RMenu:Get("FGSPoliceMenu", "main")))

local index = {
  object = 1,
  speedRad = 1,
  speed = 1
}

local radiusnum = {
  "0",
  "25",
  "50",
  "75",
  "100",
  "125",
  "150",
  "175",
  "200",
}

local speednum = {
  "0",
  "5",
  "10",
  "15",
  "20",
  "25",
  "30",
  "35",
  "40",
  "45",
  "50",
}
local speedzones = {}

local objects = {
 {"Big Cone","prop_roadcone01a"},
 {"Small Cone","prop_roadcone02b"},
 {"Gazebo","prop_gazebo_02"},
 {"Worklight","prop_worklight_03b"},
 {"Police Slow","prop_barrier_work05"},
 {"Gate Barrier","ba_prop_battle_barrier_02a"},
 {"Concrete Barrier","prop_mp_barrier_01"},
 {"Concrete Barrier 2","prop_mp_barrier_01b"},
}
local listObjects = {}

for k, v in pairs(objects) do 
  listObjects[k] = v[1]
end

local radius 
local speed
local cuffed = false

RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('FGSPoliceMenu', 'main')) then
        RageUI.DrawContent({ header = true, glare = true, instructionalButton = true}, function()
            if IsPedInAnyVehicle(GetPlayerPed(-1), false) == false then
                RageUI.Button("Object Menu" , nil, { RightLabel = '→→→'}, true, function(Hovered, Active, Selected) end, RMenu:Get('FGSPoliceMenu', 'objectmenu'))
                RageUI.Button("Cuff Nearest Player" , nil, { RightLabel = '→'}, true, function(Hovered, Active, Selected) 
                    if Selected then 
                        FGS_server_callback('FGS:Handcuff')
                    end
                end)
                RageUI.Button("Drag Nearest Player" , nil, { RightLabel = '→'}, true, function(Hovered, Active, Selected) 
                    if Selected then 
                        FGS_server_callback('FGS:Drag')
                    end
                end)
                RageUI.Button("Search Nearest Player" , nil, { RightLabel = '→'}, true, function(Hovered, Active, Selected) 
                    if Selected then 
                        FGS_server_callback('FGS:Search')
                    end
                end)
                RageUI.Button("Seize Items" , nil, { RightLabel = '→'}, true, function(Hovered, Active, Selected) 
                    if Selected then 
                        FGS_server_callback('FGS:SearchPlayer')
                    end
                end)
                RageUI.Button("Put Player in Vehicle" , nil, { RightLabel = '→'}, true, function(Hovered, Active, Selected) 
                    if Selected then 
                        FGS_server_callback('FGS:PutPlrInVeh')
                    end
                end)
                RageUI.Button("Remove Player From Vehicle" , nil, { RightLabel = '→'}, true, function(Hovered, Active, Selected) 
                    if Selected then 
                        FGS_server_callback('FGS:TakeOutOfVehicle')
                    end
                end)
                RageUI.Button("Fine Player" , nil, { RightLabel = '→'}, true, function(Hovered, Active, Selected) 
                    if Selected then 
                        FGS_server_callback('FGS:Fine')
                    end
                end)
                RageUI.Button("Jail Player" , nil, { RightLabel = '→'}, true, function(Hovered, Active, Selected) 
                    if Selected then 
                        FGS_server_callback('FGS:JailPlayer')
                    end
                end)
                RageUI.Button("Unjail Player" , nil, { RightLabel = '→'}, true, function(Hovered, Active, Selected) 
                    if Selected then 
                        FGS_server_callback('FGS:UnJailPlayer')
                    end
                end)

            end
        end)
    end
end)

RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('FGSPoliceMenu', 'objectmenu')) then
        RageUI.DrawContent({ header = true, glare = true, instructionalButton = true}, function()
            if IsPedInAnyVehicle(GetPlayerPed(-1), false) == false then
                RageUI.List("Spawn Object", listObjects, index.object, nil, {}, true, function(Hovered, Active, Selected, Index)
                    if (Selected) then
                        if IsPedInAnyVehicle(GetPlayerPed(-1), false) == false then
                        spawnObject(objects[Index][2])
                        end
                    end
                    if (Active) then 
                        index.object = Index;
                    end
                end)
                RageUI.Button("Delete Object" , nil, { RightLabel = '→→→'}, true, function(Hovered, Active, Selected) 
                    if Selected then 
                        if IsPedInAnyVehicle(GetPlayerPed(-1), false) == false then
                        deleteObject()
                        end
                    end
                end)
            end
        end)
    end
end)

RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('FGSPoliceMenu', 'speedzones')) then
        RageUI.DrawContent({ header = true, glare = true, instructionalButton = true}, function()
            if IsPedInAnyVehicle(GetPlayerPed(-1), false) == false then
                RageUI.List("Radius", radiusnum, index.speedRad, nil, {}, true, function(Hovered, Active, Selected, Index)
                    if (Active) then 
                        index.speedRad = Index;
                        radius = tonumber(radiusnum[Index])
                    end
                end)
                RageUI.List("Speed", speednum, index.speed, nil, {}, true, function(Hovered, Active, Selected, Index)
                    if (Active) then 
                        index.speed = Index;
                        speed = tonumber(speednum[Index])
                    end
                end)
                RageUI.Button("Create Speedzone" , nil, { }, true, function(Hovered, Active, Selected) 
                    if Selected then 
                      createZone()
                    end
                end)
                RageUI.Button("Delete Speedzone" , nil, {}, true, function(Hovered, Active, Selected) 
                    if Selected then 
                        FGS_server_callback('FGS:RemoveZone')
                        notify("Speed zone removed")
                    end
                end)
            end
        end)
    end
end)

RegisterCommand('pd', function()
  if IsPedInAnyVehicle(GetPlayerPed(-1), false) == false then
    FGS_server_callback('FGS:OpenPoliceMenu')
  end
end)

RegisterNetEvent("FGS:PoliceMenuOpened")
AddEventHandler("FGS:PoliceMenuOpened",function()
  RageUI.Visible(RMenu:Get('FGSPoliceMenu', 'main'), not RageUI.Visible(RMenu:Get('FGSPoliceMenu', 'main')))
end)

function spawnObject(object) 
    local Player = PlayerPedId()
    local heading = GetEntityHeading(Player)
    local x, y, z = table.unpack(GetEntityCoords(Player))
    RequestModel(object)
    while not HasModelLoaded(object) do
      Citizen.Wait(1)
    end
    local obj = CreateObject(GetHashKey(object), x, y, z, true, false);
    PlaceObjectOnGroundProperly(obj)
    SetEntityHeading(obj, heading)
    SetModelAsNoLongerNeeded(GetHashKey(object))
end

function deleteObject() 
  for k, v in pairs(objects) do 
    local theobject1 = v[2]
    local object1 = GetHashKey(theobject1)
    local x, y, z = table.unpack(GetEntityCoords(PlayerPedId(), true))
    if DoesObjectOfTypeExistAtCoords(x, y, z, 2.0, object1, true) then
        local obj1 = GetClosestObjectOfType(x, y, z, 2.0, object1, false, false, false)
        DeleteObject(obj1)
    end
  end
end

function createZone() 
  if radius == 0 then 
    notify("~r~Please set a radius")
    return
  end
  if speed == 0 then 
    notify("~r~Please set a speed")
    return
  end
      speedZoneActive = true
      notify("Created Speed Zone.")
      local x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1)))
      radius = radius + 0.0
      speed = speed + 0.0
  
      local streetName, crossing = GetStreetNameAtCoord(x, y, z)
      streetName = GetStreetNameFromHashKey(streetName)
  
      local message = "^* ^1Traffic Announcement: ^r^*^7MET Police have ordered that traffic on ^2" .. streetName .. " ^7is to travel at a speed of ^2" .. speed .. "mph ^7due to an incident." 
  
      FGS_server_callback('FGS:ActivateZone', message, speed, radius, x, y, z)
end

RegisterNetEvent('FGS:ZoneCreated')
AddEventHandler('FGS:ZoneCreated', function(speed, radius, x, y, z)

  blip = AddBlipForRadius(x, y, z, radius)
  SetBlipAlpha(blip,80)
  SetBlipSprite(blip,9)
  SetBlipColour(blip,26)
  local speedZone = AddSpeedZoneForCoord(x, y, z, radius, speed, false)

  table.insert(speedzones, {x, y, z, speedZone, blip})

end)

RegisterNetEvent('FGS:RemovedBlip')
AddEventHandler('FGS:RemovedBlip', function()

    if speedzones == nil then
      return
    end
    local playerPed =PlayerPedId()
    local closestSpeedZone = 0
    local closestDistance = 1000
    for i = 1, #speedzones, 1 do
        local distance = #(vector3(speedzones[i][1], speedzones[i][2], speedzones[i][3]) - GetEntityCoords(playerPed, true))
        if distance < closestDistance then
            closestDistance = distance
            closestSpeedZone = i
        end
    end
    RemoveSpeedZone(speedzones[closestSpeedZone][4])
    RemoveBlip(speedzones[closestSpeedZone][5])
    table.remove(speedzones, closestSpeedZone)

end)


other = nil
drag = false
playerStillDragged = false

RegisterNetEvent("FGS:DragPlayer")
AddEventHandler('FGS:DragPlayer', function(pl)
    other = pl
    drag = not drag
end)

Citizen.CreateThread(function()
    while true do
        if drag and other ~= nil then
            local ped = GetPlayerPed(GetPlayerFromServerId(other))
            local myped = GetPlayerPed(-1)
            AttachEntityToEntity(myped, ped, 4103, 11816, 0.54, 0.04, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
            playerStillDragged = true
        else
            if(playerStillDragged) then
                DetachEntity(GetPlayerPed(-1), true, false)
                playerStillDragged = false
            end
        end
        Citizen.Wait(0)
    end
end)

local frozen = false
local unfrozen = false
function tvRP.loadFreeze(notify,god,ghost)
	if not frozen then
	  if notify then
	    vRP.notify({"~r~You've been frozen."})
	  end
	  frozen = true
	  invincible = god
	  invisible = ghost
	  unfrozen = false
	else
	  if notify then
	    vRP.notify({"~g~You've been unfrozen."})
	  end
	  unfrozen = true
	  invincible = false
	  invisible = false
	end
end

RegisterKeyMapping('pd', 'Opens the PD menu', 'keyboard', 'U')




---blips below

local BlipsEnabled = false
local lastSirenState = false

local longBlips = {}
local nearBlips = {}
local myBlip = {}

Citizen.CreateThread(function()
    AddTextEntryByHash("BLIP_OTHPLYR", "colleague "..'~w~')
end)

AddEventHandler('onResourceStop', function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end

    removeAllBlips()
end)



function goOnDuty()
    TriggerServerEvent('District_blips:setDuty', true)
end

RegisterCommand("blips", function(source, args)
	BlipsEnabled = not BlipsEnabled
    vRPserver.GetWhitelistJob({}, function(whitelistjob)
        print(whitelistjob)
        if whitelistjob then 
            if BlipsEnabled then 
                goOnDuty()
                tvRP.notify("~g~Blips Enabled")
            else
                goOffDuty()
                tvRP.notify("~r~Blips Disabled")
            end
        end
    end)
end)



function goOffDuty()
    TriggerServerEvent('District_blips:setDuty', false)
    removeAllBlips()
end


function removeAllBlips()
    restoreBlip(myBlip.blip or GetMainPlayerBlipId())
    for k, v in pairs(nearBlips) do
        RemoveBlip(v.blip)
    end
    for k, v in pairs(longBlips) do
        RemoveBlip(v.blip)
    end
    nearBlips = {}
    longBlips = {}
    myBlip = {}
end

RegisterNetEvent('District_blips:removeUser')
AddEventHandler('District_blips:removeUser', function(plyId)
    if nearBlips[plyId] then
        RemoveBlip(nearBlips[plyId].blip)
        nearBlips[plyId] = nil
    end
    if longBlips[plyId] then
        RemoveBlip(longBlips[plyId].blip)
        longBlips[plyId] = nil
    end
end)

RegisterNetEvent('District_blips:receiveData')
AddEventHandler('District_blips:receiveData', function(data) 
    for k, v in pairs(data) do
        local cId = GetPlayerFromServerId(v.playerId)
        if tonumber(GetPlayerServerId(PlayerId())) ~= tonumber(v.playerId) then
            if cId ~= -1 then
                if nearBlips[v.playerId] == nil then
                    if longBlips[v.playerId] then
                        RemoveBlip(longBlips[v.playerId].blip)
                        longBlips[v.playerId] = nil
                    end
                    nearBlips[v.playerId] = {}
                    nearBlips[v.playerId].blip = AddBlipForEntity(GetPlayerPed(cId))
                    setupBlip(nearBlips[v.playerId].blip, v)
                end
            else
                if longBlips[v.playerId] == nil then
                    if nearBlips[v.playerId] then
                        RemoveBlip(nearBlips[v.playerId].blip)
                        nearBlips[v.playerId] = nil
                    end
                    longBlips[v.playerId] = {}
                    longBlips[v.playerId].blip = AddBlipForCoord(v.coords)
                    setupBlip(longBlips[v.playerId].blip, v)
                else
                    if longBlips[v.playerId] then
                        RemoveBlip(longBlips[v.playerId].blip)
                    end
                    longBlips[v.playerId].blip = AddBlipForCoord(v.coords)
                    setupBlip(longBlips[v.playerId].blip, v)
                end

            end
        end
    end
end)

function setupBlip(blip, data)
	SetBlipSprite(blip, 1)
	SetBlipDisplay(blip, 2)
	SetBlipScale(blip, 1.0)
	SetBlipColour(blip, data.blipcolour)
    SetBlipCategory(blip, 7)
	BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(data.name)
	EndTextCommandSetBlipName(blip)
end


function restoreBlip(blip)
    SetBlipSprite(blip, 6)
    SetBlipDisplay(blip, 4)
    SetBlipScale(blip, 0.7)
    SetBlipColour(blip, 0)
    SetBlipShowCone(blip, false)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(GetPlayerName(PlayerId()))
    EndTextCommandSetBlipName(blip)
    SetBlipCategory(blip, 1)
end



RegisterNetEvent("District:stopblips")
AddEventHandler("District:stopblips", function()
    removeAllBlips()
end)