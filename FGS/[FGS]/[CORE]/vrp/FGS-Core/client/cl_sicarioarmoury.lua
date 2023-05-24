RMenu.Add('SicarioArmouryMenu', 'main', RageUI.CreateMenu("", "~b~Sicario Armoury", 1250,100, "armoury", "armoury"))
RMenu.Add('SicarioArmouryMenu', 'selectionscreen', RageUI.CreateMenu("", "~b~Sicario Armoury", 1250,100, "armoury", "armoury"))
RMenu.Add('SicarioArmouryMenu', 'confirmationscreen', RageUI.CreateMenu("", "~b~Sicario Armoury", 1250,100, "armoury", "armoury"))
RMenu.Add('SicarioArmouryMenu', 'ammoconfirmationscreen', RageUI.CreateMenu("", "~b~Sicario Armoury", 1250,100, "armoury", "armoury"))
RMenu.Add('SicarioArmouryMenu', 'WepWhitelists', RageUI.CreateMenu("", "~r~Weapon Whitelists", 1250,100, "armoury", "armoury"))


local weaponPrice = nil
local weaponAmmoPrice = nil
local weaponHash = nil
local weaponModel = nil
local weaponName = nil


local itemName = nil
local itemPrice = nil


local whitelistedguns = {}

RegisterNetEvent("FGS:ShowWhitelistsSicario", function(weptable)
    whitelistedguns = weptable
end)





RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('SicarioArmouryMenu', 'main')) then
        RageUI.DrawContent({ header = true, glare = true, instructionalButton = true}, function()

            for i , p in pairs(sicariocfg.guns.sicarioarmoury) do 
                RageUI.Button(p.name, nil, { RightLabel = ">>>" }, true, function(Hovered, Active, Selected)
                    if Selected then
                        weaponPrice = p.price
                        weaponHash = p.hash
                        weaponModel = p.model
                        weaponName = p.name
                    end
                end, RMenu:Get('SicarioArmouryMenu', 'selectionscreen'))
             end

             RageUI.Button("Weapon Whitelists" , nil, { RightLabel = ">>>" }, true, function(Hovered, Active, Selected)
                if Selected then

                end
            end, RMenu:Get('SicarioArmouryMenu', 'WepWhitelists'))
        end) 
    end

    if RageUI.Visible(RMenu:Get('SicarioArmouryMenu', 'WepWhitelists')) then
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
                end, RMenu:Get('SicarioArmouryMenu', 'selectionscreen'))
            end
        end)
    end
    if RageUI.Visible(RMenu:Get('SicarioArmouryMenu', 'confirmationscreen')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = true}, function()
            RageUI.Button("Yes" , "", {RightLabel = ">>>"}, true, function(Hovered, Active, Selected)
                if Selected then 
                    FGS_server_callback('SicarioArmouryMenu:GiveWap', weaponHash, weaponName)
                end
            end, RMenu:Get('SicarioArmouryMenu', 'main'))
            RageUI.Button("No" , "", {RightLabel = ">>>"}, true, function(Hovered, Active, Selected)
                if Selected then
                    notify("~r~Purchase Cancelled")
                end
            end, RMenu:Get('SicarioArmouryMenu', 'main'))
        end)
    end
    if RageUI.Visible(RMenu:Get('SicarioArmouryMenu', 'ammoconfirmationscreen')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = true}, function()
            RageUI.Button("Yes" , "", {RightLabel = ">>>"}, true, function(Hovered, Active, Selected)
                if Selected then 
                    FGS_server_callback('SicarioArmouryMenu:buyammo', weaponHash, weaponName)
                end
            end, RMenu:Get('SicarioArmouryMenu', 'main'))
            RageUI.Button("No" , "", {RightLabel = ">>>"}, true, function(Hovered, Active, Selected)
                if Selected then
                    notify("~r~Purchase Cancelled")
                end
            end, RMenu:Get('SicarioArmouryMenu', 'main'))
        end)
    end
    if RageUI.Visible(RMenu:Get('SicarioArmouryMenu', 'selectionscreen')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = true}, function()
            RageUI.Button("Purchase Weapon Body" , "", {RightLabel = ">>>"}, true, function(Hovered, Active, Selected)
            end, RMenu:Get('SicarioArmouryMenu', 'confirmationscreen'))
            RageUI.Button("Purchase Weapon Ammo [Max]" , "", {RightLabel = ">>>"}, true, function(Hovered, Active, Selected)
            end, RMenu:Get('SicarioArmouryMenu', 'ammoconfirmationscreen'))
        end)
    end
end)


isInSicarioArmouryMenu = false
currentSicarioArmouryMenu = nil
Citizen.CreateThread(function() 
    while true do
        for k, v in pairs(sicariocfg.gunshops) do 
            local x,y,z = table.unpack(v.sicarioarmoury)
            local sicarioarmourycoords = vector3(x,y,z)

            if isInArea(sicarioarmourycoords, 100.0) then 
                DrawMarker(27, vector3(x,y,z-0.9), 0, 0, 0, 0, 0, 0, 0.8, 0.8, 0.8, 0, 140, 255, 150, 0, 0, 0, 0, 0, 0, 0)
            end
 
            if isInSicarioArmouryMenu == false then
                if isInArea(sicarioarmourycoords, 1.4) then 
                    alert('Press ~INPUT_VEH_HORN~ to access Sicario Armoury')
                    if IsControlJustPressed(0, 51) then 
                        currentSicarioArmouryMenu = k
                        FGS_server_callback('FGS:GetWhitelistSicario')
                        FGS_server_callback('FGS:SicarioArmouryCheck')
                        isInSicarioArmouryMenu = true
                        currentSicarioArmouryMenu = k 
                    end
                end
            end
            if isInArea(sicarioarmourycoords, 1.4) == false and isInSicarioArmouryMenu and k == currentSicarioArmouryMenu then
                RageUI.Visible(RMenu:Get("SicarioArmouryMenu", "main"), false)
                isInSicarioArmouryMenu = false
                currentSicarioArmouryMenu = nil
            end
        end
        Citizen.Wait(0)
    end
end)

RegisterNetEvent("SicarioArmouryMenu:GiveAmmo")
AddEventHandler("SicarioArmouryMenu:GiveAmmo", function(hash)
    SetPedAmmo(PlayerPedId(), hash, 250)
end)

RegisterNetEvent('FGS:SicarioArmouryChecked')
AddEventHandler('FGS:SicarioArmouryChecked', function(clockedon, permission)
    if clockedon then
        RageUI.Visible(RMenu:Get("SicarioArmouryMenu", "main"),true)
    elseif not clockedon and not permission then
        RageUI.ActuallyCloseAll()
        RageUI.Visible(RMenu:Get("SicarioArmouryMenu", "main"), false)
        notify("You are not a part of the Sicario's")
    end
end)