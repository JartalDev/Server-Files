RMenu.Add('RebelMenu', 'main', RageUI.CreateMenu("", "~r~Rebel Dealer", 1300,100, "rebel", "rebel"))
RMenu.Add('RebelMenu', 'selectionscreen', RageUI.CreateMenu("", "~r~Confirm Purchase", 1300,100, "rebel", "rebel"))
RMenu.Add('RebelMenu', 'confirmationscreen', RageUI.CreateMenu("", "~r~Confirm Purchase", 1300,100, "rebel", "rebel")) 
RMenu.Add('RebelMenu', 'ammoconfirmationscreen', RageUI.CreateMenu("", "~r~Confirm Purchase", 1300,100, "rebel", "rebel"))
RMenu.Add('RebelMenu', 'WepWhitelists', RageUI.CreateMenu("", "~r~Weapon Whitelists", 1300,100, "rebel", "rebel"))


local weaponPrice = nil
local weaponAmmoPrice = nil
local weaponHash = nil
local weaponModel = nil
local weaponName = nil


local itemName = nil
local itemPrice = nil


local whitelistedguns = {}
RegisterNetEvent("FGS:ShowWhitelistsLarge")
AddEventHandler("FGS:ShowWhitelistsLarge", function(weptable)
    whitelistedguns = weptable
end)




RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('RebelMenu', 'main')) then
        RageUI.DrawContent({ header = true, glare = true, instructionalButton = true}, function()
            for i , p in pairs(rebelcfg.guns.large) do 
                RageUI.Button(p.name.." [£"..GetMoneyString(p.price).."]" , nil, { RightLabel = ">>>" }, true, function(Hovered, Active, Selected)
                    if Selected then
                        weaponPrice = p.price
                        weaponHash = p.hash
                        weaponModel = p.model
                        weaponName = p.name
                        weaponAmmoPrice = math.floor(p.price / 2)
                    end
                end, RMenu:Get('RebelMenu', 'selectionscreen'))
             end
             RageUI.Button("Level 1 Armour [£25,000]" , nil, { RightLabel = ">>>" }, true, function(Hovered, Active, Selected)
                if Selected then
                    FGS_server_callback('rebel:buyarmour', 25000, 25)
                end
            end)
            RageUI.Button("Level 2 Armour [£50,000]" , nil, { RightLabel = ">>>" }, true, function(Hovered, Active, Selected)
                if Selected then
                    FGS_server_callback('rebel:buyarmour', 50000, 50)
                end
            end)

            RageUI.Button("Level 3 Armour [£75,000]" , nil, { RightLabel = ">>>" }, true, function(Hovered, Active, Selected)
                if Selected then
                    FGS_server_callback('rebel:buyarmour', 75000, 75)
                end
            end)
            RageUI.Button("Level 4 Armour [£100,000]" , nil, { RightLabel = ">>>" }, true, function(Hovered, Active, Selected)
                if Selected then
                    FGS_server_callback('rebel:buyarmour', 100000, 100)
                end
            end)
            RageUI.Button("Weapon Whitelists" , nil, { RightLabel = ">>>" }, true, function(Hovered, Active, Selected)
                if Selected then
                    FGS_server_callback('FGS:GetWhitelistLarge')
                end
            end, RMenu:Get('RebelMenu', 'WepWhitelists'))
    end)

    end
end)

RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('RebelMenu', 'WepWhitelists')) then
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
                end, RMenu:Get('RebelMenu', 'selectionscreen'))
            end
        end)
    end
end)

RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('RebelMenu', 'confirmationscreen')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = true}, function()
            RageUI.Separator(" Are you sure you would like to purchase a "..weaponName.."?", function() end)
            RageUI.Separator(" Weapon Price: £"..GetMoneyString(weaponPrice), function() end)
            RageUI.Button("Yes" , "", {RightLabel = ">>>"}, true, function(Hovered, Active, Selected)
                if Selected then 
                    FGS_server_callback('RebelMenu:buywap', weaponPrice, weaponHash, weaponName)
                end
            end, RMenu:Get('RebelMenu', 'main'))
            RageUI.Button("No" , "", {RightLabel = ">>>"}, true, function(Hovered, Active, Selected)
                if Selected then
                    notify("~r~Purchase Cancelled")
                end
            end, RMenu:Get('RebelMenu', 'main'))
        end)
    end
end)

RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('RebelMenu', 'ammoconfirmationscreen')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = true}, function()
            RageUI.Separator(" Are you sure you would like to purchase "..weaponName.." ammo?", function() end)
            RageUI.Separator(" Ammunition Price: £"..GetMoneyString(weaponAmmoPrice), function() end)
            RageUI.Button("Yes" , "", {RightLabel = ">>>"}, true, function(Hovered, Active, Selected)
                if Selected then 
                    FGS_server_callback('RebelMenu:buyammo', weaponAmmoPrice, weaponHash, weaponName)
                end
            end, RMenu:Get('RebelMenu', 'main'))
            RageUI.Button("No" , "", {RightLabel = ">>>"}, true, function(Hovered, Active, Selected)
                if Selected then
                    notify("~r~Purchase Cancelled")
                end
            end, RMenu:Get('RebelMenu', 'main'))
        end)
    end
end)

RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('RebelMenu', 'selectionscreen')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = true}, function()
            RageUI.Button("Purchase Weapon Body [£"..GetMoneyString(weaponPrice).."]" , "Purchase "..weaponName.." Body & Max Ammunition", {RightLabel = ">>>"}, true, function(Hovered, Active, Selected)
            end, RMenu:Get('RebelMenu', 'confirmationscreen'))
            RageUI.Button("Purchase Max Weapon Ammo [£"..GetMoneyString(weaponAmmoPrice).."]" , "Purchase "..weaponName.." Max Ammunition", {RightLabel = ">>>"}, true, function(Hovered, Active, Selected)
            end, RMenu:Get('RebelMenu', 'ammoconfirmationscreen'))
        end)
    end
end)

RegisterNetEvent('RebelMenu:menu')
AddEventHandler('RebelMenu:menu', function()
    RageUI.Visible(RMenu:Get("RebelMenu", "main"))
    alert('~r~Insufficent funds')
end)

isInRebelMenu = false
currentRebelMenu = nil
Citizen.CreateThread(function() 
    while true do
        for k, v in pairs(rebelcfg.gunshops) do 
            local x,y,z = table.unpack(v.large)
            local largecoords = vector3(x,y,z)

            if isInArea(largecoords, 100.0) then 
                DrawMarker(27, vector3(x,y,z-0.9), 0, 0, 0, 0, 0, 0, 0.8, 0.8, 0.8, 230, 0, 0, 150, 0, 0, 0, 0, 0, 0, 0)
            end
 
            if isInRebelMenu == false then
            if isInArea(largecoords, 1.4) then 
                alert('Press ~INPUT_VEH_HORN~ to access Large Dealer')
                if IsControlJustPressed(0, 51) then 
                    currentRebelMenu = k
                    RageUI.Visible(RMenu:Get("RebelMenu", "main"), true)
                    isInRebelMenu = true
                    currentRebelMenu = k 
                end
            end
            end
            if isInArea(largecoords, 1.4) == false and isInRebelMenu and k == currentRebelMenu then
                RageUI.ActuallyCloseAll()
                RageUI.Visible(RMenu:Get("RebelMenu", "main"), false)
                isInRebelMenu = false
                currentRebelMenu = nil
            end
        end
        Citizen.Wait(0)
    end
end)

RegisterNetEvent("RebelMenu:GiveAmmo")
AddEventHandler("RebelMenu:GiveAmmo", function(hash)
    local player = PlayerPedId()
    if HasPedGotWeapon(player,hash) then
        SetPedAmmo(PlayerPedId(), hash, 250)
        notify("~g~Paid £"..GetMoneyString(weaponAmmoPrice).." for "..weaponName.." ammo")
    else
        notify("~r~You do not have a "..weaponName.." equipped.")
    end
end)

RegisterNetEvent("Larges:givearmour")
AddEventHandler("Larges:givearmour", function(level) 
    SetPedArmour(PlayerPedId(), level)
end)

RegisterNetEvent('Larges:menu')
AddEventHandler('Larges:menu', function()
    RageUI.Visible(RMenu:Get("rebel", "main"))
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