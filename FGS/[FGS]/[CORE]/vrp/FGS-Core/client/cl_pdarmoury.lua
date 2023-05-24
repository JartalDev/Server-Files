RMenu.Add('PDArmouryMenu', 'main', RageUI.CreateMenu("", "~b~MET Police Armoury", 1250,100, "armoury", "armoury"))
RMenu.Add('PDArmouryMenu', 'selectionscreen', RageUI.CreateMenu("", "~b~MET Police Armoury", 1250,100, "armoury", "armoury"))
RMenu.Add('PDArmouryMenu', 'confirmationscreen', RageUI.CreateMenu("", "~b~MET Police Armoury", 1250,100, "armoury", "armoury"))
RMenu.Add('PDArmouryMenu', 'ammoconfirmationscreen', RageUI.CreateMenu("", "~b~MET Police Armoury", 1250,100, "armoury", "armoury"))

local weaponobj = nil
local weaponHash = nil
local weaponModel = nil
local weaponName = nil

RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('PDArmouryMenu', 'main')) then
        RageUI.DrawContent({ header = true, glare = true, instructionalButton = true}, function()
            RageUI.Button("Armour" , nil, { RightLabel = ">>>" }, true, function(Hovered, Active, Selected)
                if Selected then
                    SetPedArmour(PlayerPedId(), 100)
                end
            end)
            for i , p in pairs(pdcfg.guns.pdarmoury) do 
                RageUI.Button(p.name, nil, { RightLabel = ">>>" }, true, function(Hovered, Active, Selected)
                    if Selected then
                        weaponHash = p.hash
                        weaponModel = p.model
                        weaponName = p.name
                    end
                end, RMenu:Get('PDArmouryMenu', 'selectionscreen'))
             end
        end) 
    end
end)

RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('PDArmouryMenu', 'confirmationscreen')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = true}, function()
            RageUI.Separator(" Are you sure you would like to take out a "..weaponName.."?", function() end)
            RageUI.Button("Yes" , "", {RightLabel = ">>>"}, true, function(Hovered, Active, Selected)
                if Selected then 
                    FGS_server_callback('PDArmouryMenu:GiveWap', weaponHash, weaponName)
                end
            end, RMenu:Get('PDArmouryMenu', 'main'))
            RageUI.Button("No" , "", {RightLabel = ">>>"}, true, function(Hovered, Active, Selected)
                if Selected then
                    notify("~r~Purchase Cancelled")
                end
            end, RMenu:Get('PDArmouryMenu', 'main'))
        end)
    end
end)

RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('PDArmouryMenu', 'ammoconfirmationscreen')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = true}, function()
            RageUI.Separator(" Are you sure you would like to take out "..weaponName.." ammo?", function() end)
            RageUI.Button("Yes" , "", {RightLabel = ">>>"}, true, function(Hovered, Active, Selected)
                if Selected then 
                    FGS_server_callback('PDArmouryMenu:buyammo', weaponHash, weaponName)
                end
            end, RMenu:Get('PDArmouryMenu', 'main'))
            RageUI.Button("No" , "", {RightLabel = ">>>"}, true, function(Hovered, Active, Selected)
                if Selected then
                    notify("~r~Purchase Cancelled")
                end
            end, RMenu:Get('PDArmouryMenu', 'main'))
        end)
    end
end)

RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('PDArmouryMenu', 'selectionscreen')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = true}, function()
            RageUI.Button("Purchase Weapon Body" , "", {RightLabel = ">>>"}, true, function(Hovered, Active, Selected)
            end, RMenu:Get('PDArmouryMenu', 'confirmationscreen'))
            RageUI.Button("Purchase Weapon Ammo [Max]" , "", {RightLabel = ">>>"}, true, function(Hovered, Active, Selected)
            end, RMenu:Get('PDArmouryMenu', 'ammoconfirmationscreen'))
        end)
    end
end)


RegisterNetEvent('PDArmouryMenu:menu')
AddEventHandler('PDArmouryMenu:menu', function()
    RageUI.Visible(RMenu:Get("PDArmouryMenu", "main"))
    alert('~r~Insufficent funds')
end)

isInPDArmouryMenu = false
currentPDArmouryMenu = nil
Citizen.CreateThread(function() 
    while true do
        for k, v in pairs(pdcfg.gunshops) do 
            local x,y,z = table.unpack(v.pdarmoury)
            local pdarmourycoords = vector3(x,y,z)

            if isInArea(pdarmourycoords, 100.0) then 
                DrawMarker(27, vector3(x,y,z-0.9), 0, 0, 0, 0, 0, 0, 0.8, 0.8, 0.8, 0, 140, 255, 150, 0, 0, 0, 0, 0, 0, 0)
            end
 
            if isInPDArmouryMenu == false then
            if isInArea(pdarmourycoords, 1.4) then 
                alert('Press ~INPUT_VEH_HORN~ to access MET Police Armoury')
                if IsControlJustPressed(0, 51) then 
                    currentPDArmouryMenu = k
                    FGS_server_callback('FGS:PDArmouryCheck')
                    isInPDArmouryMenu = true
                    currentPDArmouryMenu = k 
                end
            end
            end
            if isInArea(pdarmourycoords, 1.4) == false and isInPDArmouryMenu and k == currentPDArmouryMenu then
                RageUI.ActuallyCloseAll()
                RageUI.Visible(RMenu:Get("PDArmouryMenu", "main"), false)
                isInPDArmouryMenu = false
                currentPDArmouryMenu = nil
            end
        end
        Citizen.Wait(0)
    end
end)

RegisterNetEvent("PDArmouryMenu:GiveAmmo")
AddEventHandler("PDArmouryMenu:GiveAmmo", function(hash)
    SetPedAmmo(PlayerPedId(), hash, 250)
end)

RegisterNetEvent('PDArmourys:menu')
AddEventHandler('PDArmourys:menu', function()
    RageUI.Visible(RMenu:Get("PDArmouryArms", "main"))
    alert('~r~Insufficent funds')
end)

RegisterNetEvent('FGS:PDArmouryChecked')
AddEventHandler('FGS:PDArmouryChecked', function(clockedon, permission)
    if clockedon then
        RageUI.Visible(RMenu:Get("PDArmouryMenu", "main"),true)
    elseif not clockedon and permission then
        RageUI.ActuallyCloseAll()
        RageUI.Visible(RMenu:Get("PDArmouryMenu", "main"), false)
        notify("You are not on duty")
    elseif not clockedon and not permission then
        RageUI.ActuallyCloseAll()
        RageUI.Visible(RMenu:Get("PDArmouryMenu", "main"), false)
        notify("You are not a part of the MET Police")
    end
end)