local user_id = 0

local foundMatch = false
local inSpectatorAdminMode = false
local players = {}
local searchPlayerGroups = {}
local selectedGroup
local Groups = {}
local SelectedPerm = nil

RMenu.Add('adminmenu', 'main', RageUI.CreateMenu("", "~b~Admin Player Interaction Menu", 1300,100, "adminmenu", "adminmenu"))
RMenu.Add("adminmenu", "players", RageUI.CreateSubMenu(RMenu:Get("adminmenu", "main")))
RMenu.Add("adminmenu", "searchoptions", RageUI.CreateSubMenu(RMenu:Get("adminmenu", "main")))
RMenu.Add("adminmenu", "settings", RageUI.CreateSubMenu(RMenu:Get("adminmenu", "main"),"","~b~Admin Player Interaction Menu", 1300, 100))

--[[ Functions ]]
RMenu.Add("adminmenu", "functions", RageUI.CreateSubMenu(RMenu:Get("adminmenu", "main")))
RMenu.Add("adminmenu", "generalfunctions", RageUI.CreateSubMenu(RMenu:Get("adminmenu", "main")))
RMenu.Add("adminmenu", "entityfunctions", RageUI.CreateSubMenu(RMenu:Get("adminmenu", "main")))
RMenu.Add("adminmenu", "vehiclefunctions", RageUI.CreateSubMenu(RMenu:Get("adminmenu", "main")))
RMenu.Add("adminmenu", "devfunctions", RageUI.CreateSubMenu(RMenu:Get("adminmenu", "main")))
--[[ End of Functions ]]

RMenu.Add("adminmenu", "submenu", RageUI.CreateSubMenu(RMenu:Get("adminmenu", "players")))
RMenu.Add("adminmenu", "searchname", RageUI.CreateSubMenu(RMenu:Get("adminmenu", "searchoptions")))
RMenu.Add("adminmenu", "searchtempid", RageUI.CreateSubMenu(RMenu:Get("adminmenu", "searchoptions")))
RMenu.Add("adminmenu", "searchpermid", RageUI.CreateSubMenu(RMenu:Get("adminmenu", "searchoptions")))
RMenu.Add("adminmenu", "teleportmenu", RageUI.CreateSubMenu(RMenu:Get("adminmenu", "players")))
RMenu.Add("adminmenu", "warnsub", RageUI.CreateSubMenu(RMenu:Get("adminmenu", "players")))
RMenu.Add("adminmenu", "bansub", RageUI.CreateSubMenu(RMenu:Get("adminmenu", "players")))

--[[groups]]
RMenu.Add("adminmenu", "groups", RageUI.CreateSubMenu(RMenu:Get("adminmenu", "submenu")))
RMenu.Add("adminmenu", "staffGroups", RageUI.CreateSubMenu(RMenu:Get("adminmenu", "groups")))
RMenu.Add("adminmenu", "LicenseGroups", RageUI.CreateSubMenu(RMenu:Get("adminmenu", "groups")))
RMenu.Add("adminmenu", "UserGroups", RageUI.CreateSubMenu(RMenu:Get("adminmenu", "groups")))
RMenu.Add("adminmenu", "PoliceGroups", RageUI.CreateSubMenu(RMenu:Get("adminmenu", "groups")))
RMenu.Add("adminmenu", "NHSGroups", RageUI.CreateSubMenu(RMenu:Get("adminmenu", "groups")))
RMenu.Add("adminmenu", "GangGroups", RageUI.CreateSubMenu(RMenu:Get("adminmenu", "groups")))
RMenu.Add("adminmenu", "addgroup", RageUI.CreateSubMenu(RMenu:Get("adminmenu", "groups")))
RMenu.Add("adminmenu", "removegroup", RageUI.CreateSubMenu(RMenu:Get("adminmenu", "groups")))

RMenu:Get('adminmenu', 'main')

local getStaffGroupsGroupIds = {
	["founder"] = "Founder",
    ["donorsupport"] = "Donator Support",
    ["staffmanager"] = "Staff Manager",
    ["commdirect"] = "Community Manager",
    ["generalmanager"] = "General Manager",
    ["headadmin"] = "Head Admin",
    ["senioradmin"] = "Senior Admin",
    ["leadcardev"] = "Lead Car Developer",
	["administrator"] = "Admin",
    ["dev"] = "Developer",
    ['srmoderator'] = "Senior Moderator",
	["moderator"] = "Moderator",
    ["support"] = "Support Team",
    ["trialstaff"] = "Trial Staff",
}
local getUserGroupsGroupIds = {
    ["vipgarage"] = "VIP DONT USE",
    ["bronze"] = "Bronze",
    ["silver"] = "Silver",
    ["gold"] = "Gold",
    ["platinum"] = "Platinum",
    ["diamond"] = "Diamond",
}
local getUserLicenseGroups = {
    ["weed"] = "Weed License",
    ["coke"] = "Coke License",
    ["ecstasy"] = "Ecstasy License",
    ["meth"] = "Meth License",
    ["heroin"] = "Heroin License",
    ["rebel"] = "Rebel License",
    ["diamond1"] = "Diamond License",
    ["scrap"] = "Scrap",

}

local getUserGangGroups = {
    ["sicario"] = "Sicario's",
    ["nazarious"] = "Nazarious",
}

local getUserPoliceGroups = {
    ["Commissioner"] = "Commissioner",
    ["Deputy Commissioner"] = "Deputy Commissioner",
    ["Assistant Commissioner"] = "Assistant Commissioner",
    ["Deputy Assistant Commissioner"] = "Deputy Assistant Commissioner",
    ["Commander"] = "Commander",
    ["BlackOPS"] = "Black OPS",
    ["Chief Superintendent"] = "Chief Superintendent",
    ["Superintendent"] = "Superintendent",
    ["Chief Inspector"] = "Chief Inspector",
    ["Inspector"] = "Inspector",
    ["Sergeant"] = "Sergeant",
    ["Special Police Constable"] = "Special Police Constable",
    ["Senior Police Constable"] = "Senior Police Constable",
    ["Police Constable"] = "Police Constable",
    ["PCSO"] = "PCSO",
    ["SCO-19"] = "SCO-19",
}

local getUserNHSGroups = {
    ["Head Chief Medical Officer"] = "Head Chief Medical Officer",
    ["Assistant Chief Medical Officer"] = "Assistant Chief Medical Officer",
    ["Deputy Chief Medical Officer"] = "Deputy Chief Medical Officer",
    ["Captain"] = "Captain",
    ["Consultant"] = "Consultant",
    ["Specialist"] = "Specialist",
    ["Senior Doctor"] = "Senior Doctor",
    ["Junior Doctor"] = "Junior Doctor",
    ["Critical Care Paramedic"] = "Critical Care Paramedic",
    ["Paramedic"] = "Paramedic",
    ["Trainee Paramedic"] = "Trainee Paramedic",
}


RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('adminmenu', 'main')) then
        RageUI.DrawContent({ header = true, glare = true, instructionalButton = true}, function()

        if admincfg.buttonsEnabled["adminMenu"][1] and buttons["adminMenu"] then
            RageUI.Button("All Players", "", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
            end, RMenu:Get('adminmenu', 'players'))
        end

        if admincfg.buttonsEnabled["adminMenu"][1] and buttons["adminMenu"] then
            RageUI.Button("Search Functions", "", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
            end, RMenu:Get('adminmenu', 'searchoptions'))
        end

        if admincfg.buttonsEnabled["adminMenu"][1] and buttons["adminMenu"] then
            RageUI.Button("Functions", "", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
            end, RMenu:Get('adminmenu', 'functions'))
        end

        if admincfg.buttonsEnabled["adminMenu"][1] and buttons["adminMenu"] then
            RageUI.Button("Settings", "", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
            end, RMenu:Get('adminmenu', 'settings'))
        end

    end)
end
end)

RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('adminmenu', 'players')) then
        RageUI.DrawContent({ header = true, glare = true, instructionalButton = true}, function()
            for k,v in pairs(players) do
                RageUI.Button("[" .. v[3] .. "] " .. v[1], "Name: " .. v[1] .. " Perm ID: " .. v[3] .. " Temp ID: " .. v[2], {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        SelectedPlayer = players[k]
                        SelectedPerm = v[3]
                    end
                end, RMenu:Get('adminmenu', 'submenu'))
            end
        end)
    end
end)


RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('adminmenu', 'searchoptions')) then
        RageUI.DrawContent({ header = true, glare = true, instructionalButton = true}, function()
        foundMatch = false
        RageUI.Button("Search by Name", "", {RightLabel = "→"}, true, function(Hovered, Active, Selected)
        end, RMenu:Get('adminmenu', 'searchname'))
        
        RageUI.Button("Search by Perm ID", "", {RightLabel = "→"}, true, function(Hovered, Active, Selected)
        end, RMenu:Get('adminmenu', 'searchpermid'))

        RageUI.Button("Search by Temp ID", "", {RightLabel = "→"}, true, function(Hovered, Active, Selected)
        end, RMenu:Get('adminmenu', 'searchtempid'))
    end)
end
end)

RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('adminmenu', 'functions')) then
        RageUI.DrawContent({ header = true, glare = true, instructionalButton = true}, function()

        RageUI.Button("General Functions", "", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
        end, RMenu:Get('adminmenu', 'generalfunctions'))

        RageUI.Button("Entity Functions", "", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
        end, RMenu:Get('adminmenu', 'entityfunctions'))

        if admincfg.buttonsEnabled["vehFunctions"][1] and buttons["vehFunctions"] then
            RageUI.Button("Vehicle Functions", "", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
            end, RMenu:Get('adminmenu', 'vehiclefunctions'))
        end

        if admincfg.buttonsEnabled["devMenu"][1] and buttons["devMenu"] then
            RageUI.Button("Developer Functions", "", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
            end, RMenu:Get('adminmenu', 'devfunctions'))
        end

    end)
end
end)

RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('adminmenu', 'generalfunctions')) then
        RageUI.DrawContent({ header = true, glare = true, instructionalButton = true}, function()

            if admincfg.buttonsEnabled["tp2waypoint"][1] and buttons["tp2waypoint"] then
                RageUI.Button("Teleport to Waypoint", "", {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        local WaypointHandle = GetFirstBlipInfoId(8)
                        if DoesBlipExist(WaypointHandle) then
                            local waypointCoords = GetBlipInfoIdCoord(WaypointHandle)
                            for height = 1, 1000 do
                                SetPedCoordsKeepVehicle(PlayerPedId(), waypointCoords["x"], waypointCoords["y"], height + 0.0)
                                local foundGround, zPos = GetGroundZFor_3dCoord(waypointCoords["x"], waypointCoords["y"], height + 0.0)
                                if foundGround then
                                    SetPedCoordsKeepVehicle(PlayerPedId(), waypointCoords["x"], waypointCoords["y"], height + 0.0)
                                    break
                                end
                                Citizen.Wait(5)
                            end
                        else
                            notify("You do not have a waypoint set")
                        end
                    end
                end, RMenu:Get('adminmenu', 'generalfunctions'))

                if admincfg.buttonsEnabled["noClip"][1] and buttons["noClip"] then
                    RageUI.Button("Noclip Toggle","",{RightLabel = "→"}, true, function(Hovered, Active, Selected)
                        if Selected then
                            noclipActive = not noclipActive
    
                            if IsPedInAnyVehicle(PlayerPedId(), false) then
                                noclipEntity = GetVehiclePedIsIn(PlayerPedId(), false)
                            else
                                noclipEntity = PlayerPedId()
                            end
                        
                            SetEntityCollision(noclipEntity, not noclipActive, not noclipActive)
                            FreezeEntityPosition(noclipEntity, noclipActive)
                            if noclipActive then
                                SetEntityAlpha(noclipEntity, 50, false)
                            else
                                ResetEntityAlpha(noclipEntity)
                            end
                            SetVehicleRadioEnabled(noclipEntity, not noclipActive) -- [[Stop radio from appearing when going upwards.]] 
                        end
                    end, RMenu:Get('adminmenu', 'generalfunctions'))
                end
            end
            if admincfg.buttonsEnabled["spawnBmx"][1] and buttons["spawnBmx"] then
                RageUI.Button("Spawn BMX", "", {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        SpawnVehicle('bmx')
                    end
                end, RMenu:Get('adminmenu', 'generalfunctions'))
            end

            if admincfg.buttonsEnabled["removewarn"][1] and buttons["removewarn"] then
                RageUI.Button("Remove Warning", "", {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        local uid = GetPlayerServerId(PlayerId())
                        AddTextEntry('FMMC_MPM_NC', "Enter the Warning ID")
                        DisplayOnscreenKeyboard(1, "FMMC_MPM_NC", "", "", "", "", "", 30)
                        while (UpdateOnscreenKeyboard() == 0) do
                            DisableAllControlActions(0);
                            Wait(0);
                        end
                        if (GetOnscreenKeyboardResult()) then
                            local result = GetOnscreenKeyboardResult()
                            if result then 
                                FGS_server_callback('FGS:RemoveWarning', uid, result)
                            end
                        end
                    end
                end, RMenu:Get('adminmenu', 'generalfunctions'))
            end

            if admincfg.buttonsEnabled["ban"][1] and buttons["ban"] then
                RageUI.Button("Unban Player","",{RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        local permid = getPermId()
                        FGS_server_callback("FGS:Unban", permid)
                    end
                end)
            end

            if admincfg.buttonsEnabled["ban"][1] and buttons["ban"] then
                RageUI.Button("Offline Ban","",{RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        local permid = getPermId()
                        local banReason = KeyboardInput("Reason:", "", 100)
                        local banTime = KeyboardInput("Hours:", "", 20)
                        FGS_server_callback('FGS:BanPlayer', permid, banReason, tonumber(banTime))
                    end
                end)
            end
        end)
    end
end)

RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('adminmenu', 'entityfunctions')) then
        RageUI.DrawContent({ header = true, glare = true, instructionalButton = true}, function()

            if admincfg.buttonsEnabled["EntityShit"][1] and buttons["EntityShit"] then
                RageUI.Button("Entity Cleanup", "", {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        FGS_server_callback('FGS:PropCleanup')
                    end
                end, RMenu:Get('adminmenu', 'entityfunctions'))
            end

            if admincfg.buttonsEnabled["EntityShit"][1] and buttons["EntityShit"] then
                RageUI.Button("Deattach Entity Cleanup", "", {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        FGS_server_callback('FGS:DeAttachEntity')
                    end
                end, RMenu:Get('adminmenu', 'entityfunctions'))
            end

            if admincfg.buttonsEnabled["EntityShit"][1] and buttons["EntityShit"] then
                RageUI.Button("Vehicle Cleanup", "", {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        FGS_server_callback('FGS:VehCleanup')
                    end
                end, RMenu:Get('adminmenu', 'entityfunctions'))
            end

            if admincfg.buttonsEnabled["EntityShit"][1] and buttons["EntityShit"] then
                RageUI.Button("Ped Cleanup", "", {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        FGS_server_callback('FGS:PedCleanup')
                    end
                end, RMenu:Get('adminmenu', 'entityfunctions'))
            end

            if admincfg.buttonsEnabled["EntityShit"][1] and buttons["EntityShit"] then
                RageUI.Button("All Cleanup", "", {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        FGS_server_callback('FGS:CleanAll')
                    end
                end, RMenu:Get('adminmenu', 'entityfunctions'))
            end

            if admincfg.buttonsEnabled["EntityShit"][1] and buttons["EntityShit"] then
                RageUI.Button("Delete Gun", "", {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        FGS_server_callback("FGS:DelGun")
                    end
                end, RMenu:Get('adminmenu', 'entityfunctions'))
            end

        end)
    end
end)

RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('adminmenu', 'vehiclefunctions')) then
        RageUI.DrawContent({ header = true, glare = true, instructionalButton = true}, function()

            if admincfg.buttonsEnabled["vehFunctions"][1] and buttons["vehFunctions"] then
                RageUI.Button("Spawn Vehicle", "", {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        AddTextEntry('FMMC_MPM_NC', "Enter the car spawncode name")
                        DisplayOnscreenKeyboard(1, "FMMC_MPM_NC", "", "", "", "", "", 30)
                        while (UpdateOnscreenKeyboard() == 0) do
                            DisableAllControlActions(0);
                            Wait(0);
                        end
                        if (GetOnscreenKeyboardResult()) then
                            local result = GetOnscreenKeyboardResult()
                            if result then 
                                local mhash = GetHashKey(result)
                                local i = 0
                                while not HasModelLoaded(mhash) and i < 10000 do
                                    if IsControlJustPressed(0, 178) then
                                        break
                                    end
                                    RequestModel(mhash)
                                    Citizen.Wait(1)
                                    i = i+1
                                    if i > 10000 then 
                                        tvRP.notify('~r~Model could not be loaded!')
                                        break 
                                    end
                                end
                                -- spawn car
                                if HasModelLoaded(mhash) then
                                    local x,y,z = tvRP.getPosition()
                                    if pos then
                                        x,y,z = table.unpack(pos)
                                    end
                                    local nveh = CreateVehicle(mhash, x,y,z+0.5, 0.0, true, false)
                                    SetVehicleOnGroundProperly(nveh)
                                    SetEntityInvincible(nveh,false)
                                    SetPedIntoVehicle(GetPlayerPed(-1),nveh,-1) -- put player inside
                                    SetVehicleNumberPlateText(nveh, "P "..tvRP.getRegistrationNumber())
                                    SetVehicleHasBeenOwnedByPlayer(nveh,true)
                                    local nid = NetworkGetNetworkIdFromEntity(nveh)
                                    SetNetworkIdCanMigrate(nid,cfg.vehicle_migration)
                                end
                            end
                        end
                    end
                end, RMenu:Get('adminmenu', 'vehiclefunctions'))
            end

            if admincfg.buttonsEnabled["vehFunctions"][1] and buttons["vehFunctions"] then
                RageUI.Button("Fix Vehicle", "", {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        local playerPed = GetPlayerPed(-1)
                        if IsPedInAnyVehicle(playerPed, false) then
                            local vehicle = GetVehiclePedIsIn(playerPed, false)
                            SetVehicleEngineHealth(vehicle, 1000)
                            SetVehicleEngineOn( vehicle, true, true )
                            SetVehicleFixed(vehicle)
                            tvRP.notify("~g~Your vehicle has been fixed!")
                        else
                            tvRP.notify("~o~You're not in a vehicle! There is no vehicle to fix!")
                        end
                    end
                end, RMenu:Get('adminmenu', 'vehiclefunctions'))
            end


            if admincfg.buttonsEnabled["vehFunctions"][1] and buttons["vehFunctions"] then
                RageUI.Button("Clean Vehicle", "", {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        local playerPed = GetPlayerPed(-1)
                        if IsPedInAnyVehicle(playerPed, false) then
                            local vehicle = GetVehiclePedIsIn(playerPed, false)
                            SetVehicleDirtLevel(vehicle, 0)
                            tvRP.notify("~b~Your vehicle has been cleaned!")
                        else
                            tvRP.notify("~o~You're not in a vehicle! There is no vehicle to clean!")
                        end
                    end
                end, RMenu:Get('adminmenu', 'vehiclefunctions'))
            end
        end)
    end
end)

RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('adminmenu', 'devfunctions')) then
        RageUI.DrawContent({ header = true, glare = true, instructionalButton = true}, function()

            if admincfg.buttonsEnabled["spawnGun"][1] and buttons["spawnGun"] then
                RageUI.Button("Spawn Weapon", "", {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        AddTextEntry('FMMC_MPM_NA', "Enter Weapon Spawn Code")
                        DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "Enter Weapon Spawn Code", "", "", "", "", 100)
                        while (UpdateOnscreenKeyboard() == 0) do
                            DisableAllControlActions(0);
                            Wait(0);
                        end
                        if (GetOnscreenKeyboardResult()) then
                            local result = GetOnscreenKeyboardResult()
                            if result then
                                local legit = true
                                local source = source
                                tvRP.FGSGiveGun(legit, "WEAPON_"..result)
                            end
                        end
                        return false
                    end
                end, RMenu:Get('adminmenu', 'devfunctions'))
            end

            if admincfg.buttonsEnabled["devMenu"][1] and buttons["devMenu"] then
                RageUI.Button("Get Coords", "", {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        FGS_server_callback('VRPDEV:GetCoords')
                    end
                end, RMenu:Get('adminmenu', 'devfunctions'))
            end

            if admincfg.buttonsEnabled["devMenu"][1] and buttons["devMenu"] then
                RageUI.Button("Teleport to Coords","",{RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        FGS_server_callback("FGS:Tp2Coords")
                    end
                end, RMenu:Get('adminmenu', 'devfunctions'))
            end

            if admincfg.buttonsEnabled["devMenu"][1] and buttons["devMenu"] then
                RageUI.Button("Give Money [Founders]","",{RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        FGS_server_callback("FGS:GiveMoney")
                    end
                end, RMenu:Get('adminmenu', 'devfunctions'))
            end

        end)
    end
end)

RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('adminmenu', 'searchpermid')) then
        RageUI.DrawContent({ header = true, glare = true, instructionalButton = true}, function()

            if foundMatch == false then
                searchforPermID = KeyboardInput("Enter Perm ID", "", 10)
            end

            for k, v in pairs(players) do
                foundMatch = true
                if string.find(v[3],searchforPermID) then
                    RageUI.Button("[" .. v[3] .. "] " .. v[1], "Name: " .. v[1] .. " Perm ID: " .. v[3] .. " Temp ID: " .. v[2], {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                        if Selected then
                            SelectedPlayer = players[k]
                        end
                    end, RMenu:Get('adminmenu', 'submenu'))
                end
             end
            end)
        end
    end)

    RageUI.CreateWhile(1.0, true, function()
        if RageUI.Visible(RMenu:Get('adminmenu', 'searchtempid')) then
            RageUI.DrawContent({ header = true, glare = true, instructionalButton = true}, function()

                if foundMatch == false then
                    searchid = KeyboardInput("Enter Temp ID", "", 10)
                end
    
                for k, v in pairs(players) do
                    foundMatch = true
                    if string.find(v[2], searchid) then
                        RageUI.Button("[" .. v[3] .. "] " .. v[1], "Name: " .. v[1] .. " Perm ID: " .. v[3] .. " Temp ID: " .. v[2], {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                            if Selected then
                                SelectedPlayer = players[k]
                            end
                        end, RMenu:Get('adminmenu', 'submenu'))
                    end
                end
            end)
        end
    end)

        RageUI.CreateWhile(1.0, true, function()
            if RageUI.Visible(RMenu:Get('adminmenu', 'searchname')) then
                RageUI.DrawContent({ header = true, glare = true, instructionalButton = true}, function()

                    if foundMatch == false then
                        SearchName = string.upper(KeyboardInput("Enter Name", "", 10))
                    end

                    for k, v in pairs(players) do
                        foundMatch = true
                        if string.match(v[1],SearchName) then
                            RageUI.Button("[" .. v[3] .. "] " .. v[1], "Name: " .. v[1] .. " Perm ID: " .. v[3] .. " Temp ID: " .. v[2], {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                                if Selected then
                                    SelectedPlayer = players[k]
                                end
                            end, RMenu:Get('adminmenu', 'submenu'))
                        end
                    end
                end)
            end
        end)

    RageUI.CreateWhile(1.0, true, function()
        if RageUI.Visible(RMenu:Get('adminmenu', 'submenu')) then
            RageUI.DrawContent({ header = true, glare = true, instructionalButton = true}, function()
                if admincfg.buttonsEnabled["ban"][1] and buttons["ban"] then
                        RageUI.Button("Ban Player", "Name: " .. SelectedPlayer[1] .. " Perm ID: " .. SelectedPlayer[3] .. " Temp ID: " .. SelectedPlayer[2], {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                            if Selected then

                            end
                        end, RMenu:Get('adminmenu', 'bansub'))
                end
                    
                if admincfg.buttonsEnabled["kick"][1] and buttons["kick"] then
                    RageUI.Button("Kick Player", "Name: " .. SelectedPlayer[1] .. " Perm ID: " .. SelectedPlayer[3] .. " Temp ID: " .. SelectedPlayer[2], {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                        if Selected then
                            local kickReason = KeyboardInput("Reason:", "", 100)
                            local uid = GetPlayerServerId(PlayerId())
                            FGS_server_callback('FGS:KickPlayer', uid, SelectedPlayer[3], kickReason, SelectedPlayer[2])
                        end
                    end, RMenu:Get('adminmenu', 'submenu'))
                end

                if admincfg.buttonsEnabled["nof10kick"][1] and buttons["nof10kick"] then
                    RageUI.Button("No F10 Kick", "Name: " .. SelectedPlayer[1] .. " Perm ID: " .. SelectedPlayer[3] .. " Temp ID: " .. SelectedPlayer[2], {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                        if Selected then
                            local kickReason = KeyboardInput("Reason:", "", 100)
                            local uid = GetPlayerServerId(PlayerId())
                            FGS_server_callback('FGS:KickPlayerNoF10', uid, SelectedPlayer[3], kickReason)
                        end
                    end, RMenu:Get('adminmenu', 'submenu'))
                end

                if admincfg.buttonsEnabled["FREEZE"][1] and buttons["FREEZE"] then
                    RageUI.Button("Freeze Player", "Name: " .. SelectedPlayer[1] .. " Perm ID: " .. SelectedPlayer[3] .. " Temp ID: " .. SelectedPlayer[2], {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                        if Selected then
                            local uid = GetPlayerServerId(PlayerId())
                            isFrozen = not isFrozen
                            FGS_server_callback('FGS:FreezeSV', uid, SelectedPlayer[2], isFrozen)
                        end
                    end, RMenu:Get('adminmenu', 'submenu'))
                end

                if admincfg.buttonsEnabled["slap"][1] and buttons["slap"] then
                    RageUI.Button("Slap Player", "Name: " .. SelectedPlayer[1] .. " Perm ID: " .. SelectedPlayer[3] .. " Temp ID: " .. SelectedPlayer[2], {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                        if Selected then
                            local uid = GetPlayerServerId(PlayerId())
                            FGS_server_callback('FGS:SlapPlayer', uid, SelectedPlayer[2])
                        end
                    end, RMenu:Get('adminmenu', 'submenu'))
                end
                
                if admincfg.buttonsEnabled["addcar"][1] and buttons["addcar"] then
                    RageUI.Button("Add Vehicle", "Name: " .. SelectedPlayer[1] .. " Perm ID: " .. SelectedPlayer[3] .. " Temp ID: " .. SelectedPlayer[2], {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                        if Selected then
                            AddTextEntry('FMMC_MPM_NC', "Enter the car spawncode")
                            DisplayOnscreenKeyboard(1, "FMMC_MPM_NC", "", "", "", "", "", 30)
                            while (UpdateOnscreenKeyboard() == 0) do
                                DisableAllControlActions(0);
                                Wait(0);
                            end
                            if (GetOnscreenKeyboardResult()) then
                                local result = GetOnscreenKeyboardResult()
                                if result then 
                                    FGS_server_callback('FGS:AddCar', SelectedPlayer[3], result)
                                end
                            end
                        end
                    end, RMenu:Get('adminmenu', 'submenu'))
                end

                if admincfg.buttonsEnabled["revive"][1] and buttons["revive"] then
                    RageUI.Button("Revive Player", "Name: " .. SelectedPlayer[1] .. " Perm ID: " .. SelectedPlayer[3] .. " Temp ID: " .. SelectedPlayer[2], {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                        if Selected then
                            local uid = GetPlayerServerId(PlayerId())
                            FGS_server_callback('FGS:RevivePlayer', uid, SelectedPlayer[2])
                        end
                    end, RMenu:Get('adminmenu', 'submenu'))
                end

                if admincfg.buttonsEnabled["TP2"][1] and buttons["TP2"] then
                    RageUI.Button("Teleport Menu", "Name: " .. SelectedPlayer[1] .. " Perm ID: " .. SelectedPlayer[3] .. " Temp ID: " .. SelectedPlayer[2], {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)end, RMenu:Get('adminmenu', 'teleportmenu'))
                end

                if admincfg.buttonsEnabled["spectate"][1] and buttons["spectate"] then
                    RageUI.Button("Spectate Player", "Name: " .. SelectedPlayer[1] .. " Perm ID: " .. SelectedPlayer[3] .. " Temp ID: " .. SelectedPlayer[2], {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                        if Selected then
                            FGS_server_callback('FGS:SpectateCheck', SelectedPlayer[2])
                        end
                    end, RMenu:Get('adminmenu', 'submenu'))
                end

                if admincfg.buttonsEnabled["getgroups"][1] and buttons["getgroups"] then
                    RageUI.Button("Get Groups","Get Users Groups",{RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                        if Selected then
                            FGS_server_callback("FGS:getGroups", SelectedPlayer[2], SelectedPlayer[3])
                        end
                    end,RMenu:Get("adminmenu", "groups"))
                end

                if admincfg.buttonsEnabled["showwarn"][1] and buttons["showwarn"] then
                    RageUI.Button("Show Player Warnings", "Name: " .. SelectedPlayer[1] .. " Perm ID: " .. SelectedPlayer[3] .. " Temp ID: " .. SelectedPlayer[2], {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                        if Selected then
                            ExecuteCommand("showwarnings " .. SelectedPlayer[3])
                        end
                    end, RMenu:Get('adminmenu', 'submenu'))
                end

                if admincfg.buttonsEnabled["warn"][1] and buttons["warn"] then
                    RageUI.Button("Warn Player", "Name: " .. SelectedPlayer[1] .. " Perm ID: " .. SelectedPlayer[3] .. " Temp ID: " .. SelectedPlayer[2], {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                        if Selected then

                        end
                    end, RMenu:Get('adminmenu', 'warnsub'))
                end
                
            end)
        end
    end)

    warningbankick = {
        {name = "1.1 | NRTI - No Reason To Initiate", desc = ""},
        {name = "1.2 | RDM - Random Deathmatch", desc = ""},
        {name = "1.3 | VDM - Vehicle Deathmatch", desc = ""},
        {name = "1.4 | Meta Gaming", desc = ""},
        {name = "1.5 | Power Gaming", desc = ""},
        {name = "1.6 | Fail RP", desc = ""},
        {name = "1.7 | Bad RP", desc = ""},
        {name = "1.8 | NITRP - No Intent To Roleplay", desc = ""},
        {name = "1.9 | FTVL - Failure To Value Life", desc = ""},
        {name = "1.10 | NLR - New Life Rule", desc = ""},
        {name = "1.11 | Sexual RP", desc = ""},
        {name = "1.12 | Whitelist Abuse", desc = ""},
        {name = "1.13 | Cheating / external modifications", desc = ""},
        {name = "1.14 | Scamming", desc = ""},
        {name = "1.15 | Offensive Language, Discrimination", desc = ""},
        {name = "1.16 | OOGT - Out Of Game Transactions", desc = ""},
        {name = "1.17 | Staff Discretion / Wasting Admin Time", desc = ""},
        {name = "1.18 | Wasting Admin Time", desc = ""},
        {name = "1.19 | Blackmail", desc = ""},
        {name = "1.20 | Terrorist RP", desc = ""},
        {name = "1.21 | Multi Accounting / Ban Evading", desc = ""},
        {name = "1.22 | City Zone Rule", desc = ""},
        {name = "1.23 | Cop Baiting", desc = "Out of game transactions"},
        {name = "1.24 | Exploiting", desc = "Spite Reporting"},
        {name = "1.25 | GTA Driving", desc = "Scamming"}, 
    }
RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('adminmenu', 'warnsub')) then
        RageUI.DrawContent({ header = true, glare = true, instructionalButton = true}, function()

            if admincfg.buttonsEnabled["warn"][1] and buttons["warn"] then
                RageUI.Button("[Custom Warn Message]", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then
            
                        local uid  GetPlayerServerId(PlayerId())
         
                        local reason2 = KeyboardInput("Reason:", "", 60)

                        if reason2 == nil then 
                            RageUI.CloseAll()
                        end
                        print(reason2)

                        if reason2 then 
                            FGS_server_callback("vrp:warnPlayer",SelectedPlayer[3],reason2)
                        end
                    
                    end


                end, RMenu:Get('adminmenu', 'submenu'))











                for i , p in pairs(warningbankick) do 
                    RageUI.Button(""..p.name, p.desc, { RightLabel = ">>>" }, true, function(Hovered, Active, Selected)
                        if Selected then
                            FGS_server_callback("vrp:warnPlayer",SelectedPlayer[3],p.name)
                            notify("~g~Warned Player for "..p.name)
                        end
                    end, RMenu:Get('adminmenu', 'submenu'))
                 end
            end

        end)
    end
end)

RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('adminmenu', 'bansub')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = true}, function()

            
            if admincfg.buttonsEnabled["ban"][1] and buttons["ban"] then
                RageUI.Button("[Custom Ban Message]", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                     
                        local reason2 = KeyboardInput("Reason:", "", 60)

                        if reason2 == nil then 
                            RageUI.CloseAll()
                        end
                        if banTime == nil then 
                            RageUI.CloseAll()
                        end
                        print(reason2)
                        
                        if reason2 then 
                            timeForBan = KeyboardInput("Hours:", "", 20)
                            FGS_server_callback('FGS:BanPlayer', SelectedPlayer[3], reason2, timeForBan)
                        end
                        
                    end
                end, RMenu:Get('adminmenu', 'submenu'))

                for i , p in pairs(warningbankick) do 
                    RageUI.Button(""..p.name, p.desc, { RightLabel = ">>>" }, true, function(Hovered, Active, Selected)
                        if Selected then
                            local banTime = KeyboardInput("Hours:", "", 20)
                            FGS_server_callback('FGS:BanPlayer', SelectedPlayer[3], p.name, tonumber(banTime))
                        end
                    end, RMenu:Get('adminmenu', 'submenu'))
                 end

            end


        end)
    end
end)

RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('adminmenu', 'teleportmenu')) then
        RageUI.DrawContent({ header = true, glare = true, instructionalButton = true}, function()
            if admincfg.buttonsEnabled["TP2"][1] and buttons["TP2"] then
                RageUI.Button("Teleport to Player", "Name: " .. SelectedPlayer[1] .. " Perm ID: " .. SelectedPlayer[3] .. " Temp ID: " .. SelectedPlayer[2], {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        local newSource = GetPlayerServerId(PlayerId())
                        FGS_server_callback('FGS:TeleportToPlayer', newSource, SelectedPlayer[2])
                    end
                end, RMenu:Get('adminmenu', 'teleportmenu'))
            end

            if admincfg.buttonsEnabled["TP2ME"][1] and buttons["TP2ME"] then
                RageUI.Button("Teleport Player To Me", "Name: " .. SelectedPlayer[1] .. " Perm ID: " .. SelectedPlayer[3] .. " Temp ID: " .. SelectedPlayer[2], {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        FGS_server_callback('vRPAdmin:Bring', SelectedPlayer[3])
                    end
                end, RMenu:Get('adminmenu', 'teleportmenu'))
            end

            if admincfg.buttonsEnabled["TP2ME"][1] and buttons["TP2ME"] then
                RageUI.Button("Teleport Player To Admin Island", "Name: " .. SelectedPlayer[1] .. " Perm ID: " .. SelectedPlayer[3] .. " Temp ID: " .. SelectedPlayer[2], {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        FGS_server_callback("FGS:Teleport2AdminIsland", SelectedPlayer[2])
                    end
                end, RMenu:Get('adminmenu', 'teleportmenu'))
            end

            if admincfg.buttonsEnabled["TP2ME"][1] and buttons["TP2ME"] then
                RageUI.Button("Return Player to Previous Location", "Name: " .. SelectedPlayer[1] .. " Perm ID: " .. SelectedPlayer[3] .. " Temp ID: " .. SelectedPlayer[2], {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        FGS_server_callback("FGS:returnplayer", SelectedPlayer[2])
                    end
                end, RMenu:Get('adminmenu', 'teleportmenu'))
            end
            if admincfg.buttonsEnabled["TP2ME"][1] and buttons["TP2ME"] then
                for i,v in pairs(admincfg.placestosendpeople) do
                    RageUI.Button('Teleport Player To '..i, "Teleport A Player To Somewhere", {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                        if Selected then
                            FGS_server_callback("FGS:teleportToPlace", v.x, v.y, v.z, SelectedPlayer[3])
                        end
                    end, RMenu:Get('adminmenu', 'teleportmenu'))
                end
            end
        end)
    end
end)

RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('adminmenu', 'groups')) then
        RageUI.DrawContent({ header = true, glare = true, instructionalButton = true}, function()
            if admincfg.buttonsEnabled["staffGroups"][1] and buttons["staffGroups"] then
                RageUI.Button("Staff Groups", "", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
                    if (Hovered) then
        
                    end
                    if (Active) then
        
                    end
                    if (Selected) then
                        RMenu:Get("adminmenu", "groups"):SetTitle("")
                        RMenu:Get("adminmenu", "groups"):SetSubtitle("Staff Groups")
                    end
                end, RMenu:Get('adminmenu', 'staffGroups'))
            end
            if admincfg.buttonsEnabled["licenseGroups"][1] and buttons["licenseGroups"] then
                RageUI.Button("License Groups", "", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
                    if (Hovered) then
        
                    end
                    if (Active) then
        
                    end
                    if (Selected) then
                        RMenu:Get("adminmenu", "groups"):SetTitle("")
                        RMenu:Get("adminmenu", "groups"):SetSubtitle("License Groups")
                    end
                end, RMenu:Get('adminmenu', 'LicenseGroups'))
            end
            if admincfg.buttonsEnabled["mpdGroups"][1] and buttons["mpdGroups"] then
                RageUI.Button("Police Groups", "", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
                    if (Hovered) then

                    end
                    if (Active) then

                    end
                    if (Selected) then
                        RMenu:Get("adminmenu", "groups"):SetTitle("")
                        RMenu:Get("adminmenu", "groups"):SetSubtitle("Met-PD Groups")
                    end
                end, RMenu:Get('adminmenu', 'PoliceGroups'))
            end
            if admincfg.buttonsEnabled["nhsGroups"][1] and buttons["nhsGroups"] then
                RageUI.Button("NHS Groups", "", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
                    if (Hovered) then

                    end
                    if (Active) then

                    end
                    if (Selected) then
                        RMenu:Get("adminmenu", "groups"):SetTitle("")
                        RMenu:Get("adminmenu", "groups"):SetSubtitle("NHS Groups")
                    end
                end, RMenu:Get('adminmenu', 'NHSGroups'))
            end
            if admincfg.buttonsEnabled["GangGroups"][1] and buttons["GangGroups"] then
                RageUI.Button("Gang Groups", "", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
                    if (Hovered) then

                    end
                    if (Active) then

                    end
                    if (Selected) then
                        RMenu:Get("adminmenu", "groups"):SetTitle("")
                        RMenu:Get("adminmenu", "groups"):SetSubtitle("Gang Groups")
                    end
                end, RMenu:Get('adminmenu', 'GangGroups'))
            end
            if admincfg.buttonsEnabled["donoGroups"][1] and buttons["donoGroups"] then
                RageUI.Button("Donator Groups", "", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
                    if (Hovered) then
        
                    end
                    if (Active) then
        
                    end
                    if (Selected) then
                        
                    end
                end, RMenu:Get('adminmenu', 'UserGroups'))
            end
        end) 
    end
end)

RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('adminmenu', 'staffGroups')) then
        RageUI.DrawContent({ header = true, glare = true, instructionalButton = true}, function()
            for k,v in pairs(getStaffGroupsGroupIds) do
                if searchPlayerGroups[k] ~= nil then
                    RageUI.Button("~g~"..v, "~g~User has this group.", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            RMenu:Get("adminmenu", "removegroup"):SetTitle("")
                            RMenu:Get("adminmenu", "removegroup"):SetSubtitle("Remove Group")
                            selectedGroup = k
                        end
                    end, RMenu:Get('adminmenu', 'removegroup'))
                else
                    RageUI.Button("~r~"..v, "~r~User does not have this group.", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            RMenu:Get("adminmenu", "addgroup"):SetTitle("")
                            RMenu:Get("adminmenu", "addgroup"):SetSubtitle("Add Group")
                            selectedGroup = k
                        end
                    end, RMenu:Get('adminmenu', 'addgroup'))
                end
            end
        end)
    end
end)

RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('adminmenu', 'PoliceGroups')) then
        RageUI.DrawContent({ header = true, glare = true, instructionalButton = true}, function()
            for k,v in pairs(getUserPoliceGroups) do
                if searchPlayerGroups[k] ~= nil then
                    RageUI.Button("~g~"..v, "~g~User has this group.", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            RMenu:Get("adminmenu", "removegroup"):SetTitle("")
                            RMenu:Get("adminmenu", "removegroup"):SetSubtitle("Remove Group")
                            selectedGroup = k
                        end
                    end, RMenu:Get('adminmenu', 'removegroup'))
                else
                    RageUI.Button("~r~"..v, "~r~User does not have this group.", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            RMenu:Get("adminmenu", "addgroup"):SetTitle("")
                            RMenu:Get("adminmenu", "addgroup"):SetSubtitle("Add Group")
                            selectedGroup = k
                        end
                    end, RMenu:Get('adminmenu', 'addgroup'))
                end
            end
        end)
    end
end)

RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('adminmenu', 'UserGroups')) then
        RageUI.DrawContent({ header = true, glare = true, instructionalButton = true}, function()
            for k,v in pairs(getUserGroupsGroupIds) do
                if searchPlayerGroups[k] ~= nil then
                    RageUI.Button("~g~"..v, "~g~User has this group.", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            RMenu:Get("adminmenu", "removegroup"):SetTitle("")
                            RMenu:Get("adminmenu", "removegroup"):SetSubtitle("Remove Group")
                            selectedGroup = k
                        end
                    end, RMenu:Get('adminmenu', 'removegroup'))
                else
                    RageUI.Button("~r~"..v, "~r~User does not have this group.", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            RMenu:Get("adminmenu", "addgroup"):SetTitle("")
                            RMenu:Get("adminmenu", "addgroup"):SetSubtitle("Add Group")
                            selectedGroup = k
                        end
                    end, RMenu:Get('adminmenu', 'addgroup'))
                end
            end
        end)
    end
end)

RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('adminmenu', 'LicenseGroups')) then
        RageUI.DrawContent({ header = true, glare = true, instructionalButton = true}, function()
            for k,v in pairs(getUserLicenseGroups) do
                if searchPlayerGroups[k] ~= nil then
                    RageUI.Button("~g~"..v, "~g~User has this group.", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            RMenu:Get("adminmenu", "removegroup"):SetTitle("")
                            RMenu:Get("adminmenu", "removegroup"):SetSubtitle("Remove Group")
                            selectedGroup = k
                        end
                    end, RMenu:Get('adminmenu', 'removegroup'))
                else
                    RageUI.Button("~r~"..v, "~r~User does not have this group.", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            RMenu:Get("adminmenu", "addgroup"):SetTitle("")
                            RMenu:Get("adminmenu", "addgroup"):SetSubtitle("Add Group")
                            selectedGroup = k
                        end
                    end, RMenu:Get('adminmenu', 'addgroup'))
                end
            end
        end)
    end
end)



RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('adminmenu', 'NHSGroups')) then
        RageUI.DrawContent({ header = true, glare = true, instructionalButton = true}, function()
            for k,v in pairs(getUserNHSGroups) do
                if searchPlayerGroups[k] ~= nil then
                    RageUI.Button("~g~"..v, "~g~User has this group.", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            RMenu:Get("adminmenu", "removegroup"):SetTitle("")
                            RMenu:Get("adminmenu", "removegroup"):SetSubtitle("Remove Group")
                            selectedGroup = k
                        end
                    end, RMenu:Get('adminmenu', 'removegroup'))
                else
                    RageUI.Button("~r~"..v, "~r~User does not have this group.", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            RMenu:Get("adminmenu", "addgroup"):SetTitle("")
                            RMenu:Get("adminmenu", "addgroup"):SetSubtitle("Add Group")
                            selectedGroup = k
                        end
                    end, RMenu:Get('adminmenu', 'addgroup'))
                end
            end
        end)
    end
end)

RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('adminmenu', 'GangGroups')) then
        RageUI.DrawContent({ header = true, glare = true, instructionalButton = true}, function()
            for k,v in pairs(getUserGangGroups) do
                if searchPlayerGroups[k] ~= nil then
                    RageUI.Button("~g~"..v, "~g~User has this group.", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            RMenu:Get("adminmenu", "removegroup"):SetTitle("")
                            RMenu:Get("adminmenu", "removegroup"):SetSubtitle("Remove Group")
                            selectedGroup = k
                        end
                    end, RMenu:Get('adminmenu', 'removegroup'))
                else
                    RageUI.Button("~r~"..v, "~r~User does not have this group.", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            RMenu:Get("adminmenu", "addgroup"):SetTitle("")
                            RMenu:Get("adminmenu", "addgroup"):SetSubtitle("Add Group")
                            selectedGroup = k
                        end
                    end, RMenu:Get('adminmenu', 'addgroup'))
                end
            end
        end)
    end
end)

RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('adminmenu', 'addgroup')) then
        RageUI.DrawContent({ header = true, glare = true, instructionalButton = true}, function()

            RageUI.Button("Add this group to user", "", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
                if (Selected) then
                    FGS_server_callback("FGS:addGroup",SelectedPerm,selectedGroup)
                end
            end, RMenu:Get('adminmenu', 'groups'))
            
        end)
    end
end)

RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('adminmenu', 'removegroup')) then
        RageUI.DrawContent({ header = true, glare = true, instructionalButton = true}, function()

            RageUI.Button("Remove user from group", "", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
                if (Selected) then
                    FGS_server_callback("FGS:removeGroup",SelectedPerm,selectedGroup)
                end
            end, RMenu:Get('adminmenu', 'groups'))
            
        end)
    end
end)

RegisterNetEvent('FGS:SlapPlayer')
AddEventHandler('FGS:SlapPlayer', function()
    SetEntityHealth(PlayerPedId(), 0)
end)

FrozenPlayer = false

RegisterNetEvent('FGS:Freeze')
AddEventHandler('FGS:Freeze', function(isForzen)
    FrozenPlayer = isForzen
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if FrozenPlayer then
            FreezeEntityPosition(PlayerPedId(), true)
        else
            FreezeEntityPosition(PlayerPedId(), false)
        end
    end
end)

RegisterNetEvent('FGS:Teleport')
AddEventHandler('FGS:Teleport', function(coords)
    SetEntityCoords(PlayerPedId(), coords)
end)

RegisterNetEvent('vRPAdmin:Bring')
AddEventHandler('vRPAdmin:Bring', function(coords, plr)
    if coords then 
        SetEntityCoords(PlayerPedId(), coords)
    else 
        local targetPed = GetPlayerPed(GetPlayerFromServerId(plr))
        local plrcoords = GetEntityCoords(targetPed)
        SetEntityCoords(PlayerPedId(), plrcoords)
    end
end)

RegisterNetEvent("FGS:SendPlayersInfo")
AddEventHandler("FGS:SendPlayersInfo",function(players_table, btns)
    players = players_table    
    table.sort(players, function(a, b) 
        return a[3] < b[3] 
    end)
    buttons = btns
    RageUI.Visible(RMenu:Get("adminmenu", "main"), not RageUI.Visible(RMenu:Get("adminmenu", "main")))
end)

local InSpectatorMode	= false
local TargetSpectate	= nil
local LastPosition		= nil
local polarAngleDeg		= 0;
local azimuthAngleDeg	= 90;
local radius			= -3.5;
local cam 				= nil
local PlayerDate		= {}
local ShowInfos			= false
local group

local function polar3DToWorld3D(entityPosition, radius, polarAngleDeg, azimuthAngleDeg)

    local polarAngleRad   = polarAngleDeg   * math.pi / 180.0
	local azimuthAngleRad = azimuthAngleDeg * math.pi / 180.0

	local pos = {
		x = entityPosition.x + radius * (math.sin(azimuthAngleRad) * math.cos(polarAngleRad)),
		y = entityPosition.y - radius * (math.sin(azimuthAngleRad) * math.sin(polarAngleRad)),
		z = entityPosition.z - radius * math.cos(azimuthAngleRad)
	}

	return pos
end


RegisterNetEvent('FGS:SpectateClient')
AddEventHandler('FGS:SpectateClient', function(target)
    TargetSpectate = target
    SpectatePlayer()
end)


function StopSpectatePlayer()
    InSpectatorMode = false
    TargetSpectate  = nil
    local playerPed = PlayerPedId()
    SetCamActive(cam,  false)
    DestroyCam(cam, true)
    RenderScriptCams(false, false, 0, true, true)
    SetEntityVisible(playerPed, true)
    SetEntityCollision(playerPed, true, true)
    FreezeEntityPosition(playePed, false)
    if savedCoords ~= vec3(0,0,1) then SetEntityCoords(PlayerPedId(), savedCoords) else SetEntityCoords(PlayerPedId(), 3537.363, 3721.82, 36.467) end
end

function SpectatePlayer()
    savedCoords = GetEntityCoords(PlayerPedId())
    SetEntityCoords(PlayerPedId(), Coords)
    InSpectatorMode = true
    local playerPed = PlayerPedId()
    SetEntityCollision(playerPed, false, false)
    SetEntityVisible(playerPed, false)
    FreezeEntityPosition(playePed, true)
    Citizen.CreateThread(function()

        if not DoesCamExist(cam) then
            cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
        end

        SetCamActive(cam, true)
        RenderScriptCams(true, false, 0, true, true)

    end, TargetSpectate)
    RequestCollisionAtCoord(NetworkGetPlayerCoords(GetPlayerFromServerId(tonumber(TargetSpectate))))
end

Citizen.CreateThread(function()
    while (true) do
        Wait(0)
        if InSpectatorMode then
            DrawHelpMsg("Press ~INPUT_CONTEXT~ to Stop Spectating")
            if IsControlJustPressed(1, 51) then
                StopSpectatePlayer()
            end
        end
    end
end)

RegisterNetEvent("FGS:gotgroups")
AddEventHandler("FGS:gotgroups",function(gotGroups)
    searchPlayerGroups = gotGroups
end)

Citizen.CreateThread(function()
    while (true) do
        Wait(0)
        if InSpectatorMode then
        
			local targetPlayerId = GetPlayerFromServerId(tonumber(TargetSpectate))
			local playerPed	  = GetPlayerPed(-1)
			local targetPed	  = GetPlayerPed(targetPlayerId)
            local coords	 =  NetworkGetPlayerCoords(GetPlayerFromServerId(tonumber(TargetSpectate)))
            
            Draw2DText(0.22, 0.90, 'Health: ~g~' .. GetEntityHealth(targetPed) .. " / " .. GetEntityMaxHealth(targetPed), 0.65) 
            Draw2DText(0.22, 0.86, 'Armor: ~b~' .. GetPedArmour(targetPed) .. " / " .. GetPlayerMaxArmour(targetPlayerId), 0.65)
			for i=0, 32, 1 do
				if i ~= PlayerId() then
					local otherPlayerPed = GetPlayerPed(i)
					SetEntityNoCollisionEntity(playerPed,  otherPlayerPed,  true)
					SetEntityVisible(playerPed, false)
				end
			end

			if IsControlPressed(2, 241) then
				radius = radius + 2.0;
			end

			if IsControlPressed(2, 242) then
				radius = radius - 2.0;
			end

			if radius > -1 then
				radius = -1
			end

			local xMagnitude = GetDisabledControlNormal(0, 1);
			local yMagnitude = GetDisabledControlNormal(0, 2);

			polarAngleDeg = polarAngleDeg + xMagnitude * 10;

			if polarAngleDeg >= 360 then
				polarAngleDeg = 0
			end

			azimuthAngleDeg = azimuthAngleDeg + yMagnitude * 10;

			if azimuthAngleDeg >= 360 then
				azimuthAngleDeg = 0;
			end

			local nextCamLocation = polar3DToWorld3D(coords, radius, polarAngleDeg, azimuthAngleDeg)

            SetCamCoord(cam,  nextCamLocation.x,  nextCamLocation.y,  nextCamLocation.z)
            PointCamAtEntity(cam,  targetPed)
			SetEntityCoords(playerPed, coords.x, coords.y, coords.z + 10)
        end
    end
end)

function Draw2DText(x, y, text, scale)
    SetTextFont(4)
    SetTextProportional(7)
    SetTextScale(scale, scale)
    SetTextColour(255, 255, 255, 255)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextDropShadow()
    SetTextEdge(4, 0, 0, 0, 255)
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x, y)
  end

RegisterNetEvent('FGS:Notify')
AddEventHandler('FGS:Notify', function(string)
    notify('~g~' .. string)
end)

RegisterCommand('openadminmenu',function()
    FGS_server_callback("FGS:GetPlayerData")
end)

RegisterKeyMapping('openadminmenu', 'Opens the Admin menu', 'keyboard', 'F2')

function DrawHelpMsg(msg)
    SetTextComponentFormat("STRING")
    AddTextComponentString(msg)
    DisplayHelpTextFromStringLabel(0,0,1,-1)
end

function KeyboardInput(TextEntry, ExampleText, MaxStringLenght)
	AddTextEntry('FMMC_KEY_TIP1', TextEntry) 
	DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLenght)
    blockinput = true 
    
	while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do 
		Citizen.Wait(0)
	end
		
	if UpdateOnscreenKeyboard() ~= 2 then
		local result = GetOnscreenKeyboardResult() 
		Citizen.Wait(500) 
		blockinput = false 
		return result 
	else
		Citizen.Wait(500)
		blockinput = false 
		return nil 
	end
end

function notify(string)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(string)
    DrawNotification(true, false)
end

function SpawnVehicle(VehicleName)
	local hash = GetHashKey(VehicleName)
	RequestModel(hash)
	local i = 0
	while not HasModelLoaded(hash) and i < 50 do
		Citizen.Wait(10)
		i = i + 1
	end
    if i >= 50 then
        return
	end
	local Ped = PlayerPedId()
	local Vehicle = CreateVehicle(hash, GetEntityCoords(Ped), GetEntityHeading(Ped), true, 0)
    i = 0
	while not DoesEntityExist(Vehicle) and i < 50 do
		Citizen.Wait(10)
		i = i + 1
	end
	if i >= 50 then
		return
	end
    SetPedIntoVehicle(Ped, Vehicle, -1)
    SetModelAsNoLongerNeeded(hash)
end

function getWarningUserID()
AddTextEntry('FMMC_MPM_NA', "Enter ID of the player you want to warn?")
DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "Enter ID of the player you want to warn?", "1", "", "", "", 30)
while (UpdateOnscreenKeyboard() == 0) do
    DisableAllControlActions(0);
    Wait(0);
end
if (GetOnscreenKeyboardResult()) then
    local result = GetOnscreenKeyboardResult()
    if result then
        return result
    end
end
return false
end

function getWarningUserMsg()
AddTextEntry('FMMC_MPM_NA', "Enter warning message")
DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "Enter warning message", "", "", "", "", 30)
while (UpdateOnscreenKeyboard() == 0) do
    DisableAllControlActions(0);
    Wait(0);
end
if (GetOnscreenKeyboardResult()) then
    local result = GetOnscreenKeyboardResult()
    if result then
        return result
    end
end
return false
end

RegisterNetEvent("FGS:TPCoords")
AddEventHandler("FGS:TPCoords", function(coords)
    SetEntityCoordsNoOffset(GetPlayerPed(-1), coords.x, coords.y, coords.z, false, false, false)
end)

function getPermId()
	AddTextEntry('FMMC_MPM_NA', "Enter Perm ID")
	DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "Enter Perm ID", "", "", "", "", 30)
    while (UpdateOnscreenKeyboard() == 0) do
        DisableAllControlActions(0);
        Wait(0);
    end
    if (GetOnscreenKeyboardResult()) then
        local result = GetOnscreenKeyboardResult()
		if result then
			return result
		end
    end
	return false
end

RegisterNetEvent("FGS:EntityWipe")
AddEventHandler("FGS:EntityWipe", function(id)
    Citizen.CreateThread(function() 
        for k,v in pairs(GetAllEnumerators()) do 
            local enum = v
            for entity in enum() do 
                local owner = NetworkGetEntityOwner(entity)
                local playerID = GetPlayerServerId(owner)
                NetworkDelete(entity)
            end
        end
    end)
end)



RegisterNetEvent("DeleteAllVeh", function()
    for vehicle in EnumerateVehicles() do
        if (not IsPedAPlayer(GetPedInVehicleSeat(vehicle, -1))) then 
            SetVehicleHasBeenOwnedByPlayer(vehicle, false) 
            SetEntityAsMissionEntity(vehicle, false, false) 
            DeleteVehicle(vehicle)
            if (DoesEntityExist(vehicle)) then 
                DeleteVehicle(vehicle) 
            end
        end
    end
end)

local EntityCleanupGun = false;
RegisterNetEvent("FGS:DelGun", function()
    EntityCleanupGun = not EntityCleanupGun
    if EntityCleanupGun then 
        GiveWeaponToPed(PlayerPedId(), GetHashKey('WEAPON_STAFFGUN'), 250, false, true)
        tvRP.notify("~g~Entity cleanup gun enabled.")
    else 
        tvRP.notify("~r~Entity cleanup gun disabled.")
        RemoveWeaponFromPed(PlayerPedId(), GetHashKey('WEAPON_STAFFGUN'))
    end
end)

local function NetworkDelete(entity)
    Citizen.CreateThread(function()
        if DoesEntityExist(entity) and not (IsEntityAPed(entity) and IsPedAPlayer(entity)) then
            NetworkRequestControlOfEntity(entity)
            local timeout = 5
            while timeout > 0 and not NetworkHasControlOfEntity(entity) do
                Citizen.Wait(1)
                timeout = timeout - 1
            end
            DetachEntity(entity, 0, false)
            SetEntityCollision(entity, false, false)
            SetEntityAlpha(entity, 0.0, true)
            SetEntityAsMissionEntity(entity, true, true)
            SetEntityAsNoLongerNeeded(entity)
            DeleteEntity(entity)
        end
    end)
end

Citizen.CreateThread(function()
    while true do 
        Wait(0)
        if EntityCleanupGun then 
            local plr = PlayerId()
            if GetSelectedPedWeapon(PlayerPedId()) == GetHashKey('WEAPON_STAFFGUN') then
                DisablePlayerFiring(plr, true)
                local yes, entity = GetEntityPlayerIsFreeAimingAt(plr)
                if yes then 
                    tvRP.notify('~g~Deleted Entity: ' .. GetEntityModel(entity))
                    NetworkDelete(entity)
                end
            else 
                RemoveWeaponFromPed(PlayerPedId(), GetHashKey('WEAPON_STAFFGUN'))
                EntityCleanupGun = false;
                tvRP.notify("~r~Entity cleanup gun disabled.")
            end 
        end
    end
end)

