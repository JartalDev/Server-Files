RMenu.Add('callmenu', 'main', RageUI.CreateMenu("", "~b~Call Management", 1300,100, "callmanager", "callmanager"))
RMenu.Add('callmenu', 'Admin', RageUI.CreateSubMenu(RMenu:Get('callmenu', 'main')))
RMenu.Add('callmenu', 'Police', RageUI.CreateSubMenu(RMenu:Get('callmenu', 'main')))
RMenu.Add('callmenu', 'NHS', RageUI.CreateSubMenu(RMenu:Get('callmenu', 'main')))
RMenu.Add('callmenu', 'Lawyer', RageUI.CreateSubMenu(RMenu:Get('callmenu', 'main')))

local LFB = false
local Police = false
local NHS = false
local Admin = false
local LAWYER = false

adminCalls = {}
policeCalls = {}
nhsCalls = {}
layercalls = {}
desc = desc or ""
policedesc = policedesc or ""
local user_id = GetPlayerServerId(GetPlayerPed(-1))

-- RageUI.CreateWhile(wait, menu, key, closure)
RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('callmenu', 'main')) then
        RageUI.DrawContent({ header = true, glare = true, instructionalButton = true}, function()
            adminBtn()
            policeBtn()
            medicBtn()
            laywerBtn()
        end)
    end
    adminSM()
    policeSM()
    medicSM()
    LawyerSM()
end)


function adminBtn()
    if Admin == false then return end
    RageUI.Button("Admin Calls" , nil, {RightLabel = "→→→",}, true, function(Hovered, Active, Selected)
        if Selected then
            --FGS_server_callback('FGS:adminNotification')
        end
    end, RMenu:Get('callmenu', 'Admin'))
end

function medicBtn()
    if NHS == false then return end
    RageUI.Button("NHS Calls" , nil, {RightLabel = "→→→",}, true, function(Hovered, Active, Selected)
        if Selected then
            --FGS_server_callback('FGS:adminNotification')
        end
    end, RMenu:Get('callmenu', 'NHS'))
end

function policeBtn()
    if Police == false then return end
    RageUI.Button("MET Police Calls" , nil, {RightLabel = "→→→",}, true, function(Hovered, Active, Selected)
        if Selected then
            --FGS_server_callback('FGS:adminNotification')
        end
    end, RMenu:Get('callmenu', 'Police'))
end

function laywerBtn()
    if LAWYER == false then return end
    RageUI.Button("Laywer Request" , nil, {RightLabel = "→→→",}, true, function(Hovered, Active, Selected)
        if Selected then
            --FGS_server_callback('FGS:adminNotification')
        end
    end, RMenu:Get('callmenu', 'Lawyer'))
end


RegisterNetEvent('FGS:CheckingPerms')
AddEventHandler('FGS:CheckingPerms', function(var)
    RageUI.Visible(RMenu:Get("callmenu", "main"), true)
    if var == "LFB" then
        LFB = true
    end
    if var == "Admin" then
        Admin = true
    end
    if var == "Police" then
        Police = true
    end
    if var == "NHS" then
        NHS = true
    end
    if var == "Lawyer" then
        LAWYER = true
    end
end)

--[[Sub Menus]]
local cooldown = false
function adminSM()
    if RageUI.Visible(RMenu:Get('callmenu', 'Admin')) then
        RageUI.DrawContent({ header = true, glare = true, instructionalButton = true}, function()
            for k,v in pairs(adminCalls) do
                RageUI.Button(v.reason, "Name: "..v.Name.." | PermID: "..v.PermID.. " | TempID: "..v.callerSource,{}, true, function(Hovered, Active, Selected)
                    if Selected then
                        local  playerlocal2 = GetPlayerServerId(PlayerId())
                    if v.callerSource == playerlocal2 then
                            notify("~r~You aren't allowed to go to your own ticket")
                            return
                        end
                        local FGSCallerSource = v.callerSource
                        updateAdmin()
                        cooldown = true
                        FGS_server_callback('FGS:staffTeleport', FGSCallerSource)
                        FGS_server_callback('FGS:removeAdminTicket',k)
                        FGS_server_callback('FGS:checkstaffWhitelist')
                        Citizen.Wait(1)
                        FGS_server_callback('FGS:checkstaffWhitelist2')
                        Citizen.Wait(1)
                        FGS_server_callback('FGS:checkstaffWhitelist3')
                        Citizen.Wait(1)
                        FGS_server_callback('FGS:checkstaffWhitelist4')
                        Citizen.Wait(1)
                        FGS_server_callback('FGS:checkstaffWhitelist5')
                        Citizen.Wait(1)
                        FGS_server_callback('FGS:checkstaffWhitelist6')
                        Citizen.Wait(1)
                        FGS_server_callback('FGS:checkstaffWhitelist7')
                        Citizen.Wait(1)
                        FGS_server_callback('FGS:checkstaffWhitelist8')
                        Citizen.Wait(1)
                    end
                end)
            end
        end)
    end
end

Citizen.CreateThread(function()
while true do
Wait(5000)
if cooldown == true then
cooldown = false
end
end
end)


function medicSM()
    if RageUI.Visible(RMenu:Get('callmenu', 'NHS')) then
        RageUI.DrawContent({ header = true, glare = true, instructionalButton = true}, function()
            for k,v in pairs(nhsCalls) do
                RageUI.Button("Name: "..v.policeName, "Reason: "..v.policereason,{}, true, function(Hovered, Active, Selected)
                    if Selected then
                        local  playerlocal2 = GetPlayerServerId(PlayerId())
                        if v.callerSource == playerlocal2 then
                            notify("~r~You can't take your own NHS Call")
                            return
                        end
                        FGS_server_callback('FGS:setpoliceWaypoint', v.policecallerSource)
                        FGS_server_callback('FGS:removeNHSCall',k)
                    end
                end)
            end
        end)
    end
end

function policeSM()
    if RageUI.Visible(RMenu:Get('callmenu', 'Police')) then
        RageUI.DrawContent({ header = true, glare = true, instructionalButton = true}, function()
            for k,v in pairs(policeCalls) do
                RageUI.Button("Name: "..v.policeName, "Reason: "..v.policereason,{}, true, function(Hovered, Active, Selected)
                    if Hovered then
                        FGS_server_callback('FGS:setpoliceWaypoint', v.policecallerSource)
                    end
                    if Selected then
                        local  playerlocal2 = GetPlayerServerId(PlayerId())
                        if v.policecallerSource == playerlocal2 then
                            notify("~r~You can't take your own Police Call")
                            return
                        end
                        FGS_server_callback('FGS:setpoliceWaypoint', v.policecallerSource)
                        FGS_server_callback('FGS:removePoliceTicket',k)
                    end
                end)
            end
        end)
    end
end


function LawyerSM()
    if RageUI.Visible(RMenu:Get('callmenu', 'Lawyer')) then
        RageUI.DrawContent({ header = true, glare = true, instructionalButton = true}, function()
            for k,v in pairs(layercalls) do
                RageUI.Button("Name: "..v.policeName, "Reason: "..v.policereason,{}, true, function(Hovered, Active, Selected)
                    if Hovered then
                        FGS_server_callback('FGS:setpoliceWaypoint', v.policecallerSource)
                    end
                    if Selected then
                        local  playerlocal2 = GetPlayerServerId(PlayerId())
                        if v.policecallerSource == playerlocal2 then
                            notify("~r~You can't take your own request.")
                            return
                        end
                        FGS_server_callback('FGS:setpoliceWaypoint', v.policecallerSource)
                        FGS_server_callback('FGS:removePoliceTicket',k)
                    end
                end)
            end
        end)
    end
end


function notify(msg)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(msg)
    DrawNotification(true, false)
end

RegisterNetEvent('FGS:staffTPTOPlayer')
AddEventHandler('FGS:staffTPTOPlayer',function(callerSource)
    local callerSource = callerSource
    local player =PlayerPedId()
    local player2 = GetPlayerPed(callerSource)
    local toPlayer = GetPlayerFromServerId(callerSource)
    local player2 = GetPlayerPed(callerSource)
    local coords = callerSource
    SetEntityCoordsNoOffset(player, coords.x, coords.y, coords.z, false, false, false)
end)

RegisterNetEvent("_35635675789685225345")
AddEventHandler("_35635675789685225345", function(coords)
    SetEntityCoordsNoOffset(GetPlayerPed(-1), coords.x, coords.y, coords.z, false, false, false)
end)

RegisterNetEvent('FGS:policeWaypoint')
AddEventHandler('FGS:policeWaypoint', function(policecallerSource)
    local player =PlayerPedId()
    local coords = policecallerSource
    SetNewWaypoint(coords.x, coords.y)
end)
RegisterNetEvent('FGS:policeWaypoint2')
AddEventHandler('FGS:policeWaypoint2', function(x, y)
    SetNewWaypoint(x, y)
end)
RegisterCommand('opencallmanager',function()
    FGS_server_callback('FGS:CheckingPerms')
    updateAdmin()
    LFB = false
    Admin = false
    Police = false
    NHS = false
    Lawyer = false
end)

RegisterKeyMapping('opencallmanager', 'Opens the Call Manager menu', 'keyboard', 'END')

function updateAdmin()
    FGS_server_callback('FGS:updateAdmin')
    FGS_server_callback('FGS:updatePolice')
    FGS_server_callback("FGS:updateNHS")
    FGS_server_callback("FGS:updateLawyer")
end

RegisterNetEvent('FGS:receiveAdminCalls')
AddEventHandler('FGS:receiveAdminCalls', function(table)
    adminCalls = table
end)
RegisterNetEvent('FGS:CloseMenu')
AddEventHandler('FGS:CloseMenu', function()
    RageUI.Visible(RMenu:Get("callmenu", "main"), false)
    RageUI.Visible(RMenu:Get("callmenu", "Admin"), false)
    RageUI.Visible(RMenu:Get("callmenu","Police"), false)
    RageUI.Visible(RMenu:Get("callmenu","NHS"), false)
    RageUI.Visible(RMenu:Get("callmenu","Lawyer"), false)
end)

RegisterNetEvent('FGS:updatePolice')
AddEventHandler('FGS:updatePolice', function(table)
    policeCalls = table
end)


RegisterNetEvent('FGS:updateNHS')
AddEventHandler('FGS:updateNHS', function(table)
    nhsCalls = table
end)

RegisterNetEvent('FGS:updateLawyer')
AddEventHandler('FGS:updateLawyer', function(table)
    layercalls = table
end)
