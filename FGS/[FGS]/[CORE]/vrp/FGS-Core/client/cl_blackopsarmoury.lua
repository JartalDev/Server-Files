RMenu.Add('BLACKOPSArmouryMenu', 'main', RageUI.CreateMenu("", "~b~BLACKOPS Police Armoury", 1250,100, "armoury", "armoury"))
RMenu.Add('BLACKOPSArmouryMenu', 'selectionscreen', RageUI.CreateMenu("", "~b~BLACKOPS Police Armoury", 1250,100, "armoury", "armoury"))
RMenu.Add('BLACKOPSArmouryMenu', 'confirmationscreen', RageUI.CreateMenu("", "~b~BLACKOPS Police Armoury", 1250,100, "armoury", "armoury"))
RMenu.Add('BLACKOPSArmouryMenu', 'ammoconfirmationscreen', RageUI.CreateMenu("", "~b~BLACKOPS Police Armoury", 1250,100, "armoury", "armoury"))
RMenu.Add('BLACKOPSArmouryMenu', 'WepWhitelists', RageUI.CreateMenu("", "~r~Weapon Whitelists", 1250,100, "armoury", "armoury"))


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
    if RageUI.Visible(RMenu:Get('BLACKOPSArmouryMenu', 'main')) then
        RageUI.DrawContent({ header = true, glare = true, instructionalButton = true}, function()
            RageUI.Button("Armour" , nil, { RightLabel = ">>>" }, true, function(Hovered, Active, Selected)
                if Selected then
                    SetPedArmour(PlayerPedId(), 100)
                end
            end)
            for i , p in pairs(blackopscfg.guns.blackopsarmoury) do 
                RageUI.Button(p.name, nil, { RightLabel = ">>>" }, true, function(Hovered, Active, Selected)
                    if Selected then
                        weaponPrice = p.price
                        weaponHash = p.hash
                        weaponModel = p.model
                        weaponName = p.name
                    end
                end, RMenu:Get('BLACKOPSArmouryMenu', 'selectionscreen'))
             end

             RageUI.Button("Weapon Whitelists" , nil, { RightLabel = ">>>" }, true, function(Hovered, Active, Selected)
                if Selected then

                end
            end, RMenu:Get('BLACKOPSArmouryMenu', 'WepWhitelists'))
        end) 
    end

    if RageUI.Visible(RMenu:Get('BLACKOPSArmouryMenu', 'WepWhitelists')) then
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
                end, RMenu:Get('BLACKOPSArmouryMenu', 'selectionscreen'))
            end
        end)
    end
    if RageUI.Visible(RMenu:Get('BLACKOPSArmouryMenu', 'confirmationscreen')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = true}, function()
            RageUI.Button("Yes" , "", {RightLabel = ">>>"}, true, function(Hovered, Active, Selected)
                if Selected then 
                    FGS_server_callback('BLACKOPSArmouryMenu:GiveWap', weaponHash, weaponName)
                end
            end, RMenu:Get('BLACKOPSArmouryMenu', 'main'))
            RageUI.Button("No" , "", {RightLabel = ">>>"}, true, function(Hovered, Active, Selected)
                if Selected then
                    notify("~r~Purchase Cancelled")
                end
            end, RMenu:Get('BLACKOPSArmouryMenu', 'main'))
        end)
    end
    if RageUI.Visible(RMenu:Get('BLACKOPSArmouryMenu', 'ammoconfirmationscreen')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = true}, function()
            RageUI.Button("Yes" , "", {RightLabel = ">>>"}, true, function(Hovered, Active, Selected)
                if Selected then 
                    FGS_server_callback('BLACKOPSArmouryMenu:buyammo', weaponHash, weaponName)
                end
            end, RMenu:Get('BLACKOPSArmouryMenu', 'main'))
            RageUI.Button("No" , "", {RightLabel = ">>>"}, true, function(Hovered, Active, Selected)
                if Selected then
                    notify("~r~Purchase Cancelled")
                end
            end, RMenu:Get('BLACKOPSArmouryMenu', 'main'))
        end)
    end
    if RageUI.Visible(RMenu:Get('BLACKOPSArmouryMenu', 'selectionscreen')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = true}, function()
            RageUI.Button("Purchase Weapon Body" , "", {RightLabel = ">>>"}, true, function(Hovered, Active, Selected)
            end, RMenu:Get('BLACKOPSArmouryMenu', 'confirmationscreen'))
            RageUI.Button("Purchase Weapon Ammo [Max]" , "", {RightLabel = ">>>"}, true, function(Hovered, Active, Selected)
            end, RMenu:Get('BLACKOPSArmouryMenu', 'ammoconfirmationscreen'))
        end)
    end
end)


isInBLACKOPSArmouryMenu = false
currentBLACKOPSArmouryMenu = nil
Citizen.CreateThread(function() 
    while true do
        for k, v in pairs(blackopscfg.gunshops) do 
            local x,y,z = table.unpack(v.blackopsarmoury)
            local blackopsarmourycoords = vector3(x,y,z)

            if isInArea(blackopsarmourycoords, 100.0) then 
                DrawMarker(27, vector3(x,y,z-0.9), 0, 0, 0, 0, 0, 0, 0.8, 0.8, 0.8, 0, 140, 255, 150, 0, 0, 0, 0, 0, 0, 0)
            end
 
            if isInBLACKOPSArmouryMenu == false then
                if isInArea(blackopsarmourycoords, 1.4) then 
                    alert('Press ~INPUT_VEH_HORN~ to access BLACKOPS Police Armoury')
                    if IsControlJustPressed(0, 51) then 
                        currentBLACKOPSArmouryMenu = k
                        FGS_server_callback('FGS:GetWhitelistPD')
                        FGS_server_callback('FGS:BLACKOPSArmouryCheck')
                        isInBLACKOPSArmouryMenu = true
                        currentBLACKOPSArmouryMenu = k 
                    end
                end
            end
            if isInArea(blackopsarmourycoords, 1.4) == false and isInBLACKOPSArmouryMenu and k == currentBLACKOPSArmouryMenu then
                RageUI.Visible(RMenu:Get("BLACKOPSArmouryMenu", "main"), false)
                isInBLACKOPSArmouryMenu = false
                currentBLACKOPSArmouryMenu = nil
            end
        end
        Citizen.Wait(0)
    end
end)

RegisterNetEvent("BLACKOPSArmouryMenu:GiveAmmo")
AddEventHandler("BLACKOPSArmouryMenu:GiveAmmo", function(hash)
    SetPedAmmo(PlayerPedId(), hash, 250)
end)

RegisterNetEvent('FGS:BLACKOPSArmouryChecked')
AddEventHandler('FGS:BLACKOPSArmouryChecked', function(clockedon, permission)
    if clockedon then
        RageUI.Visible(RMenu:Get("BLACKOPSArmouryMenu", "main"),true)
    elseif not clockedon and not permission then
        RageUI.ActuallyCloseAll()
        RageUI.Visible(RMenu:Get("BLACKOPSArmouryMenu", "main"), false)
        notify("You are not a part of the BLACKOPS Police Division")
    end
end)