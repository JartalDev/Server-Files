RMenu.Add('largeMenu', 'main', RageUI.CreateMenu("", "~r~large Dealer", 1300,100, "largearms", "largearms"))
RMenu.Add('largeMenu', 'selectionscreen', RageUI.CreateMenu("", "~r~Confirm Purchase", 1300,100, "largearms", "largearms"))
RMenu.Add('largeMenu', 'confirmationscreen', RageUI.CreateMenu("", "~r~Confirm Purchase", 1300,100, "largearms", "largearms")) 
RMenu.Add('largeMenu', 'ammoconfirmationscreen', RageUI.CreateMenu("", "~r~Confirm Purchase", 1300,100, "largearms", "largearms"))
RMenu.Add('largeMenu', 'WepWhitelists', RageUI.CreateMenu("", "~r~Weapon Whitelists", 1300,100, "largearms", "largearms"))


local weaponPrice = nil
local weaponAmmoPrice = nil
local weaponHash = nil
local weaponModel = nil
local weaponName = nil


local itemName = nil
local itemPrice = nil


local whitelistedguns = {}
RegisterNetEvent("FGS:ShowWhitelistslarge")
AddEventHandler("FGS:ShowWhitelistslarge", function(weptable)
    whitelistedguns = weptable
end)




RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('largeMenu', 'main')) then
        RageUI.DrawContent({ header = true, glare = true, instructionalButton = true}, function()
            for i , p in pairs(largecfg.guns.large) do 
                RageUI.Button(p.name.." [£"..GetMoneyString(p.price).."]" , nil, { RightLabel = ">>>" }, true, function(Hovered, Active, Selected)
                    if Selected then
                        weaponPrice = p.price
                        weaponHash = p.hash
                        weaponModel = p.model
                        weaponName = p.name
                        weaponAmmoPrice = math.floor(p.price / 2)
                    end
                end, RMenu:Get('largeMenu', 'selectionscreen'))
             end
             RageUI.Button("Level 1 Armour [£25,000]" , nil, { RightLabel = ">>>" }, true, function(Hovered, Active, Selected)
                if Selected then
                    FGS_server_callback('large:buyarmour', 25000, 25)
                end
            end)
            RageUI.Button("Level 2 Armour [£100,000]" , nil, { RightLabel = ">>>" }, true, function(Hovered, Active, Selected)
                if Selected then
                    FGS_server_callback('large:buyarmour', 100000, 50)
                end
            end)
            RageUI.Button("Level 3 Armour [£250,000]" , nil, { RightLabel = ">>>" }, true, function(Hovered, Active, Selected)
                if Selected then
                    FGS_server_callback('large:buyarmour', 250000, 75)
                end
            end)
            RageUI.Button("Weapon Whitelists" , nil, { RightLabel = ">>>" }, true, function(Hovered, Active, Selected)
                if Selected then
                    FGS_server_callback('FGS:GetWhitelistlarge')
                end
            end, RMenu:Get('largeMenu', 'WepWhitelists'))
    end)

    end
end)

RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('largeMenu', 'WepWhitelists')) then
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
                end, RMenu:Get('largeMenu', 'selectionscreen'))
            end
        end)
    end
end)

RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('largeMenu', 'confirmationscreen')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = true}, function()
            RageUI.Separator(" Are you sure you would like to purchase a "..weaponName.."?", function() end)
            RageUI.Separator(" Weapon Price: £"..GetMoneyString(weaponPrice), function() end)
            RageUI.Button("Yes" , "", {RightLabel = ">>>"}, true, function(Hovered, Active, Selected)
                if Selected then 
                    FGS_server_callback('largeMenu:buywap', weaponPrice, weaponHash, weaponName)
                end
            end, RMenu:Get('largeMenu', 'main'))
            RageUI.Button("No" , "", {RightLabel = ">>>"}, true, function(Hovered, Active, Selected)
                if Selected then
                    notify("~r~Purchase Cancelled")
                end
            end, RMenu:Get('largeMenu', 'main'))
        end)
    end
end)

RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('largeMenu', 'ammoconfirmationscreen')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = true}, function()
            RageUI.Separator(" Are you sure you would like to purchase "..weaponName.." ammo?", function() end)
            RageUI.Separator(" Ammunition Price: £"..GetMoneyString(weaponAmmoPrice), function() end)
            RageUI.Button("Yes" , "", {RightLabel = ">>>"}, true, function(Hovered, Active, Selected)
                if Selected then 
                    FGS_server_callback('largeMenu:buyammo', weaponAmmoPrice, weaponHash, weaponName)
                end
            end, RMenu:Get('largeMenu', 'main'))
            RageUI.Button("No" , "", {RightLabel = ">>>"}, true, function(Hovered, Active, Selected)
                if Selected then
                    notify("~r~Purchase Cancelled")
                end
            end, RMenu:Get('largeMenu', 'main'))
        end)
    end
end)

RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('largeMenu', 'selectionscreen')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = true}, function()
            RageUI.Button("Purchase Weapon Body [£"..GetMoneyString(weaponPrice).."]" , "Purchase "..weaponName.." Body & Max Ammunition", {RightLabel = ">>>"}, true, function(Hovered, Active, Selected)
            end, RMenu:Get('largeMenu', 'confirmationscreen'))
            RageUI.Button("Purchase Max Weapon Ammo [£"..GetMoneyString(weaponAmmoPrice).."]" , "Purchase "..weaponName.." Max Ammunition", {RightLabel = ">>>"}, true, function(Hovered, Active, Selected)
            end, RMenu:Get('largeMenu', 'ammoconfirmationscreen'))
        end)
    end
end)

RegisterNetEvent('largeMenu:menu')
AddEventHandler('largeMenu:menu', function()
    RageUI.Visible(RMenu:Get("largeMenu", "main"))
    alert('~r~Insufficent funds')
end)

isInlargeMenu = false
currentlargeMenu = nil
Citizen.CreateThread(function() 
    while true do
        for k, v in pairs(largecfg.gunshops) do 
            local x,y,z = table.unpack(v.large)
            local largecoords = vector3(x,y,z)

            if isInArea(largecoords, 100.0) then 
                DrawMarker(27, vector3(x,y,z-0.9), 0, 0, 0, 0, 0, 0, 0.8, 0.8, 0.8, 230, 0, 0, 150, 0, 0, 0, 0, 0, 0, 0)
            end
 
            if isInlargeMenu == false then
            if isInArea(largecoords, 1.4) then 
                alert('Press ~INPUT_VEH_HORN~ to access large Arms Dealer')
                if IsControlJustPressed(0, 51) then 
                    currentlargeMenu = k
                    RageUI.Visible(RMenu:Get("largeMenu", "main"), true)
                    isInlargeMenu = true
                    currentlargeMenu = k 
                end
            end
            end
            if isInArea(largecoords, 1.4) == false and isInlargeMenu and k == currentlargeMenu then
                RageUI.ActuallyCloseAll()
                RageUI.Visible(RMenu:Get("largeMenu", "main"), false)
                isInlargeMenu = false
                currentlargeMenu = nil
            end
        end
        Citizen.Wait(0)
    end
end)

RegisterNetEvent("largeMenu:GiveAmmo")
AddEventHandler("largeMenu:GiveAmmo", function(hash)
    local player = PlayerPedId()
    if HasPedGotWeapon(player,hash) then
        SetPedAmmo(PlayerPedId(), hash, 250)
        notify("~g~Paid £"..GetMoneyString(weaponAmmoPrice).." for "..weaponName.." ammo")
    else
        notify("~r~You do not have a "..weaponName.." equipped.")
    end
end)


RegisterNetEvent('Larges:menu')
AddEventHandler('Larges:menu', function()
    RageUI.Visible(RMenu:Get("large", "main"))
    alert('~r~Insufficent funds')
end)

function tvRP.setParachute()
  local player = PlayerPedId()
  GiveWeaponToPed(GetPlayerPed(-1), GetHashKey("gadget_parachute"), 1, false, false)
end

RegisterNetEvent("FGS:FullInventory")
AddEventHandler('FGS:FullInventory', function()
    alert('Unable to give item, Inventory is full')
end)