--- Hey Person, If You Have Dumped This Then Good Luck As Most Main Parts Of Anticheat Are In Server Side Thanks.

---
--- HVC Anticheat By Vrxith & Callum
--- 01 October 2021 
--- 15:37 PM
---

Test = "This file was obfuscated using PSU Obfuscator 4.0.A"

RMenu.Add('anticheat', 'main', RageUI.CreateMenu("", "~b~Anticheat", positionx, positiony, "banners", "anticheat"))
RMenu:Get('anticheat', 'main')

RMenu.Add('anticheat', 'bannedplayers', RageUI.CreateMenu("", "~b~Anticheat Banned Players", positionx, positiony, "banners", "anticheat"))
RMenu:Get('anticheat', 'bannedplayers')

RMenu.Add('anticheat', 'submenu', RageUI.CreateMenu("", "~b~Anticheat Banned Settings", positionx, positiony, "banners", "anticheat"))
RMenu:Get('anticheat', 'submenu')

RMenu.Add('anticheat', 'banmeanings', RageUI.CreateMenu("", "~b~Anticheat Ban Meanings", positionx, positiony, "banners", "anticheat"))
RMenu:Get('anticheat', 'banmeanings')

local globalAdminLevel = 0
local SelectedPlayer = nil
local adminname = "N/A"
local bannedplayersamt = 0
local players = {}

RageUI.CreateWhile(1.0,RMenu:Get('anticheat', "main"),nil,function()
    RageUI.IsVisible(RMenu:Get('anticheat', "main"),true, false,true,function()
        if globalAdminLevel >= cfganticheat.permission.MainMenu then

            RageUI.Separator("Anticheat Duration: Lifetime", function() end)
            RageUI.Separator("Banned Players: " .. bannedplayersamt, function() end)
            RageUI.Separator("Your Name: " ..adminname, function() end)

            if globalAdminLevel >= cfganticheat.permission.BannedPlayers then
                RageUI.ButtonWithStyle("Banned Players","Gets All Banned Players",{RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        
                    end
                end, RMenu:Get('anticheat', 'bannedplayers'))
            end

            if globalAdminLevel >= cfganticheat.permission.BanMeanings then
                RageUI.ButtonWithStyle("Ban Meanings","Tells You What Ban Reasons Are.",{RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                end, RMenu:Get('anticheat', 'banmeanings'))
            end

        end
    end)
end)

RageUI.CreateWhile(1.0,RMenu:Get('anticheat', "bannedplayers"),nil,function()
    RageUI.IsVisible(RMenu:Get('anticheat', "bannedplayers"),true, false,true,function()
        if globalAdminLevel >= cfganticheat.permission.MainMenu then

            RageUI.Separator("Anticheat Duration: Lifetime", function() end)
            RageUI.Separator("Banned Players: ".. bannedplayersamt, function() end)
            RageUI.Separator("Your Name: " ..adminname, function() end)

            for k, v in pairs(players) do
                RageUI.ButtonWithStyle("[" .. v[1] .. "]", "ID: ~g~"..v[1].. "\n~w~Reason: ~r~" ..v[2], {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        RMenu:Get("anticheat", "submenu"):SetSubtitle("Perm ID: ~g~" .. v[1] .. "\n~w~Ban Reason: ~r~" .. v[2])
                        SelectedPlayer = players[k]
                    end
                end, RMenu:Get('anticheat', 'submenu'))
            end

        end
    end)
end)


local banmeanings = {
    {"Type #1", "~r~Infinite Ammo"},
    {"Type #2", "~r~Armour Modifications"},
    {"Type #3", ""},
    {"Type #4", ""},
    {"Type #5", "~r~Giving All Weapons"},
    {"Type #6", "~r~Remove All Weapons"},
    {"Type #7", "~r~Chat Spam With Mod Menu"},
    {"Type #8", "~r~Fake Chat Message"},
    {"Type #9", "~r~Ammo Store Explioting"},
    {"Type #10", "~r~Gun Store Modification"},
    {"Type #11", "~r~Server Menu Modifications"},
    {"Type #12", "~r~Remove Player Group"},
    {"Type #13", "~r~Teleport 2 Waypoint [AdminMenu]"},
    {"Type #14", "~r~Slapping Players [AdminMenu]"},
    {"Type #15", "~r~Spawning Weapon"},
    {"Type #16", "~r~Infinite Combat Roll"},
    {"Type #17", "~r~Semi-Godmode"},
    {"Type #18", "~r~Godmode"},
    {"Type #19", "~r~Excessive Ammo"},
    {"Type #20", "~r~Health Modifications"}, 
    {"Type #21", "~r~Removing Player From Cars"}, 
    {"Type #22", "~r~Stopping Resources"},
    
    {"Type #brksxvrxith #KYSNERD", "~r~Eulen Noclip"},
}

RageUI.CreateWhile(1.0,RMenu:Get('anticheat', "banmeanings"),nil,function()
    RageUI.IsVisible(RMenu:Get('anticheat', "banmeanings"),true, false,true,function()
        if globalAdminLevel >= cfganticheat.permission.MainMenu then

            RageUI.Separator("Anticheat Duration: Lifetime", function() end)
            RageUI.Separator("Banned Players: ".. bannedplayersamt, function() end)
            RageUI.Separator("Your Name: " ..adminname, function() end)

            for k, v in pairs(banmeanings) do

                RageUI.ButtonWithStyle(v[1], v[2], {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)

                end, RMenu:Get('anticheat', 'main'))

            end

        end
    end)
end)

RageUI.CreateWhile(1.0,RMenu:Get("anticheat", "submenu"),nil,function()
    RageUI.IsVisible(RMenu:Get("anticheat", "submenu"),true, false,true,function()

        if globalAdminLevel >= cfganticheat.permission.Unban then
            RageUI.ButtonWithStyle("Unban Player","Unban Selected User",{RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                if Selected then 
                    TriggerServerEvent('HVC:A.U.B', SelectedPlayer[1])
                end
            end, RMenu:Get("anticheat", "main"))
        end

        RageUI.ButtonWithStyle("Show Warning Log","Show The Player Warnings",{RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
            if Selected then
                if showwarning == true then
                    showwarning = false
                    TriggerServerEvent("hvc_admin:stopwarn", SelectedPlayer[3])
                else
                    showwarning = true
                    TriggerServerEvent("hvc_admin:showwarn", SelectedPlayer[3])
                end
            end
        end,RMenu:Get("anticheat", "main"))
    end)
end)


RegisterNetEvent("HVC:SendAnticheatData")
AddEventHandler("HVC:SendAnticheatData",function(bannedplayers, adminlevel, admin_name, BannedPlayersAmt)

    if adminlevel >= 1 then
        players = {}
        Wait(10)
        globalAdminLevel = adminlevel
        players = json.decode(bannedplayers)
        adminname = admin_name
        bannedplayersamt = BannedPlayersAmt


        --print(bannedplayers)
        RageUI.CloseAll()
        RageUI.Visible(RMenu:Get('anticheat', 'main'), not RageUI.Visible(RMenu:Get('anticheat', 'main')))
    end

end)


Citizen.CreateThread(function() 
    while true do
        Citizen.Wait(0)
        if IsControlJustPressed(1, 288) then
            players = {}
            TriggerServerEvent("HVC:AnticheatGetData")
        end
    end
end)




























---------------------------------------------------------------------------- Anticheat Start Here -----------------------------------------------------------------------------



local playerSpawned = false
local playerSpawned2 = true
local SGA = false
local Spectate = false
local LastArmour = nil
local EntityofPed = 0
local AllowArmourChecks = false
local CheckFalse = false
local HasPlayerFullySpawned = false
local LastHealth = nil
local AllowHealthChecks = false
local SGH = false
local isNotInComa = false

RegisterNetEvent("HVC:AC:BanCheat:EulenCheck")
AddEventHandler("HVC:AC:BanCheat:EulenCheck", function(boolean)
    CheckFalse = boolean
end)


AddEventHandler("playerSpawned", function()
    playerSpawned = true 
    Wait(30000)
    playerSpawned = false
end)



RegisterNetEvent("HVC:ServerGotArmd")
AddEventHandler("HVC:ServerGotArmd", function()
    SGA = true
    Wait(1000)
    SGA = false
end)

RegisterNetEvent("HVC:512954159185")
AddEventHandler("HVC:512954159185", function(bool)
    Spectate = bool
end)

RegisterNetEvent("HVC:AC:BanCheat")
AddEventHandler("HVC:AC:BanCheat", function(bool)
    SGH = bool
end)

RegisterNetEvent("HVC:AC:BanCheat2")
AddEventHandler("HVC:AC:BanCheat2", function(bool)
    isNotInComa = bool
end)


AddEventHandler("playerSpawned", function()
    Wait(60000)
    HasPlayerFullySpawned = true
end)

--[[
    Warping into Cars
    Kicking Outa Car
]]

Citizen.CreateThread(function()
    while true do 
        Wait(5)
        local PlayerPed = PlayerPedId()
        local Player = PlayerId()
        local Armour = GetPedArmour(PlayerPed)
        local Health = GetEntityHealth(PlayerPed)
        local Coords = GetEntityCoords(PlayerPed)
        local Invisible = IsEntityVisible(PlayerPed)
        local GodModing = GetPlayerInvincible_2(Player)
        local Ammo = GetAmmoInPedWeapon(PlayerPed, GetSelectedPedWeapon(PlayerPed))
        local _, MpInfiniteStats0 = StatGetInt(GetHashKey("mp0_shooting_ability"), true)

        if MpInfiniteStats0 > 100 then
            TriggerServerEvent("HVC:AnticheatBan", "Type #16", "Infinite Combat Roll")
            break;
        end

        if IsPedShooting(PlayerPed) and Ammo == 250 and not HasPedGotWeapon(PlayerPedId(),GetHashKey("WEAPON_STUNGUN"),false) then
            RemoveAllPedWeapons(PlayerPedId(), false)
            TriggerServerEvent("HVC:AnticheatBan", "Type #1", Ammo)  
            break;
        end

        if Ammo > 250 and not HasPedGotWeapon(PlayerPedId(),GetHashKey("WEAPON_STUNGUN"),false) and not HasPedGotWeapon(PlayerPedId(),GetHashKey("WEAPON_JERRYCAN"),false) then
            RemoveAllPedWeapons(PlayerPedId(), false)
            TriggerServerEvent("HVC:AnticheatBan", "Type #19", Ammo)  
            break;
        end

        if GodModing == 1 and not CheckFalse and not playerSpawned and HasPlayerFullySpawned and not isNotInComa then
            TriggerServerEvent("HVC:AnticheatBan", "Type #18", "Godmoding")  
            break;
        end
    end
end)




--- Needs Testing




--[[
-- Speed Boost Detection

RegisterCommand("modspeed", function(_, args) 
    local veh = GetVehiclePedIsIn(PlayerPedId(), false)
    SetVehicleHandlingFloat(veh, 'CHandlingData', 'fInitialDriveForce', tonumber(args[1]))

    if SetVehicleHandlingFloat(veh, 'CHandlingData', 'fInitialDriveForce', tonumber(args[1])) then
        Notify("~b~Acceleration Set To " ..tonumber(args[1]))
    end
end)

Citizen.CreateThread(function()
    while true do
        Wait(100)
        local veh = GetVehiclePedIsIn(PlayerPedId(), false)

        --Notify(veh)
        --Notify(GetVehicleHandlingFloat(veh, 'CHandlingData', 'fInitialDriveForce'))

        if IsPedSittingInAnyVehicle(PlayerPedId()) then
            if GetVehicleHandlingFloat(veh, 'CHandlingData', 'fInitialDriveForce') > 3.0 then
                Notify("You Have Been Caught By The Anticheat")
            end
        end
    end
end)
]]


-- RegisterCommand("addarmour", function(source, args)
--     SetPedArmour(PlayerPedId(), tonumber(args[1]))
-- end)

-- RegisterCommand("resetcombatroll", function(source, args)
--     for i = 0, 3 do
--         StatSetInt(GetHashKey("mp" .. i .. "_shooting_ability"), 100, true)
--         StatSetInt(GetHashKey("sp" .. i .. "_shooting_ability"), 100, true)
--     end
-- end)

-- RegisterCommand("healthdecrease", function(source, args)
--     Citizen.CreateThread(function()
--         while true do 
--             Wait(1)
--             local PlayerPed = PlayerPedId()
--             local Health = GetEntityHealth(PlayerPed)

--             if Health > 115 then
--                 SetEntityHealth(PlayerPedId(), Health-1)
--             else
--                 break;
--             end
--         end
--     end)
-- end)