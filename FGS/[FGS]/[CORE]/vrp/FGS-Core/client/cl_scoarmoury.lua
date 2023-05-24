RMenu.Add('SCOArmouryMenu', 'main', RageUI.CreateMenu("", "~b~SCO-19 Police Armoury", 1250,100, "armoury", "armoury"))
RMenu.Add('SCOArmouryMenu', 'selectionscreen', RageUI.CreateMenu("", "~b~SCO-19 Police Armoury", 1250,100, "armoury", "armoury"))
RMenu.Add('SCOArmouryMenu', 'confirmationscreen', RageUI.CreateMenu("", "~b~SCO-19 Police Armoury", 1250,100, "armoury", "armoury"))
RMenu.Add('SCOArmouryMenu', 'ammoconfirmationscreen', RageUI.CreateMenu("", "~b~SCO-19 Police Armoury", 1250,100, "armoury", "armoury"))
RMenu.Add('SCOArmouryMenu', 'WepWhitelists', RageUI.CreateMenu("", "~r~Weapon Whitelists", 1250,100, "armoury", "armoury"))


local weaponPrice = nil
local weaponAmmoPrice = nil
local weaponHash = nil
local weaponModel = nil
local weaponName = nil


local itemName = nil
local itemPrice = nil


local whitelistedguns = {}

RegisterNetEvent("FGS:ShowWhitelistsPD", function(weptable)
    whitelistedguns = weptable
end)





RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('SCOArmouryMenu', 'main')) then
        RageUI.DrawContent({ header = true, glare = true, instructionalButton = true}, function()

            for i , p in pairs(scocfg.guns.scoarmoury) do 
                RageUI.Button(p.name, nil, { RightLabel = ">>>" }, true, function(Hovered, Active, Selected)
                    if Selected then
                        weaponPrice = p.price
                        weaponHash = p.hash
                        weaponModel = p.model
                        weaponName = p.name
                    end
                end, RMenu:Get('SCOArmouryMenu', 'selectionscreen'))
             end

             RageUI.Button("Weapon Whitelists" , nil, { RightLabel = ">>>" }, true, function(Hovered, Active, Selected)
                if Selected then

                end
            end, RMenu:Get('SCOArmouryMenu', 'WepWhitelists'))
        end) 
    end

    if RageUI.Visible(RMenu:Get('SCOArmouryMenu', 'WepWhitelists')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = true}, function()
            for i , p in pairs(whitelistedguns) do 
                RageUI.Button(p.wepname.." [£"..GetMoneyString(p.price).."]" , nil, { RightLabel = ">>>" }, true, function(Hovered, Active, Selected)
                    if Selected then
                        weaponPrice = tonumber(p.price)
                        weaponHash = p.weapon
                        weaponModel = p.weapon
                        weaponName = p.wepname
                        weaponAmmoPrice = math.floor(tonumber(p.price) / 2)
                    end
                end, RMenu:Get('SCOArmouryMenu', 'selectionscreen'))
            end
        end)
    end
    if RageUI.Visible(RMenu:Get('SCOArmouryMenu', 'confirmationscreen')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = true}, function()
            RageUI.Button("Yes" , "", {RightLabel = ">>>"}, true, function(Hovered, Active, Selected)
                if Selected then 
                    FGS_server_callback('SCOArmouryMenu:GiveWap', weaponHash, weaponName)
                end
            end, RMenu:Get('SCOArmouryMenu', 'main'))
            RageUI.Button("No" , "", {RightLabel = ">>>"}, true, function(Hovered, Active, Selected)
                if Selected then
                    notify("~r~Purchase Cancelled")
                end
            end, RMenu:Get('SCOArmouryMenu', 'main'))
        end)
    end
    if RageUI.Visible(RMenu:Get('SCOArmouryMenu', 'ammoconfirmationscreen')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = true}, function()
            RageUI.Button("Yes" , "", {RightLabel = ">>>"}, true, function(Hovered, Active, Selected)
                if Selected then 
                    FGS_server_callback('SCOArmouryMenu:buyammo', weaponHash, weaponName)
                end
            end, RMenu:Get('SCOArmouryMenu', 'main'))
            RageUI.Button("No" , "", {RightLabel = ">>>"}, true, function(Hovered, Active, Selected)
                if Selected then
                    notify("~r~Purchase Cancelled")
                end
            end, RMenu:Get('SCOArmouryMenu', 'main'))
        end)
    end
    if RageUI.Visible(RMenu:Get('SCOArmouryMenu', 'selectionscreen')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = true}, function()
            RageUI.Button("Purchase Weapon Body" , "", {RightLabel = ">>>"}, true, function(Hovered, Active, Selected)
            end, RMenu:Get('SCOArmouryMenu', 'confirmationscreen'))
            RageUI.Button("Purchase Weapon Ammo [Max]" , "", {RightLabel = ">>>"}, true, function(Hovered, Active, Selected)
            end, RMenu:Get('SCOArmouryMenu', 'ammoconfirmationscreen'))
        end)
    end
end)


isInSCOArmouryMenu = false
currentSCOArmouryMenu = nil
Citizen.CreateThread(function() 
    while true do
        for k, v in pairs(scocfg.gunshops) do 
            local x,y,z = table.unpack(v.scoarmoury)
            local scoarmourycoords = vector3(x,y,z)

            if isInArea(scoarmourycoords, 100.0) then 
                DrawMarker(27, vector3(x,y,z-0.9), 0, 0, 0, 0, 0, 0, 0.8, 0.8, 0.8, 0, 140, 255, 150, 0, 0, 0, 0, 0, 0, 0)
            end
 
            if isInSCOArmouryMenu == false then
                if isInArea(scoarmourycoords, 1.4) then 
                    alert('Press ~INPUT_VEH_HORN~ to access SCO-19 Police Armoury')
                    if IsControlJustPressed(0, 51) then 
                        currentSCOArmouryMenu = k
                        FGS_server_callback('FGS:GetWhitelistPD')
                        FGS_server_callback('FGS:SCOArmouryCheck')
                        isInSCOArmouryMenu = true
                        currentSCOArmouryMenu = k 
                    end
                end
            end
            if isInArea(scoarmourycoords, 1.4) == false and isInSCOArmouryMenu and k == currentSCOArmouryMenu then
                RageUI.Visible(RMenu:Get("SCOArmouryMenu", "main"), false)
                isInSCOArmouryMenu = false
                currentSCOArmouryMenu = nil
            end
        end
        Citizen.Wait(0)
    end
end)

RegisterNetEvent("SCOArmouryMenu:GiveAmmo")
AddEventHandler("SCOArmouryMenu:GiveAmmo", function(hash)
    SetPedAmmo(PlayerPedId(), hash, 250)
end)

RegisterNetEvent('FGS:SCOArmouryChecked')
AddEventHandler('FGS:SCOArmouryChecked', function(clockedon, permission)
    if clockedon then
        RageUI.Visible(RMenu:Get("SCOArmouryMenu", "main"),true)
    elseif not clockedon and not permission then
        RageUI.ActuallyCloseAll()
        RageUI.Visible(RMenu:Get("SCOArmouryMenu", "main"), false)
        notify("You are not a part of the SCO-19 Police Division")
    end
end)