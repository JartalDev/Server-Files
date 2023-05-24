local chipsDesk = vector3(1116.0949707031,218.64071655273,-49.435104370117)
local isInMenu = false


RMenu.Add('chipsDesk', 'main', RageUI.CreateMenu("Diamond Casino", "~b~Diamond Casino",1250,100))

RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('chipsDesk', 'main')) then
        RageUI.DrawContent({ header = true, glare = true, instructionalButton = true }, function()           
            RageUI.Button("Buy Chips", "",{ RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
                if (Selected) then
                    local amountOfChips = getTextFromUser()
                    TriggerServerEvent('casino:buyChips', amountOfChips)
                end
            end)
            RageUI.Button("Sell Chips", "",{ RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
                if (Selected) then
                    local amountOfChips = getTextFromUser()
                    TriggerServerEvent('casino:sellChips', amountOfChips)
                end
            end)
        end, function()
        end)
    end
end)



function getTextFromUser()
	AddTextEntry('FMMC_MPM_NA', 'Enter Amount')
	DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", 'Enter Amount', "", "", "", "", 30)
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



Citizen.CreateThread(function() 
    isInMenu = false
    while true do
        if isInArea(chipsDesk, 100.0) then 
            DrawMarker(27, chipsDesk-0.9, 0, 0, 0, 0, 0, 0, 0.8, 0.8, 0.8, 230, 0, 0, 150, 0, 0, 0, 0, 0, 0, 0)
        end
        if isInMenu == false then
            if isInArea(chipsDesk, 1.4) then 
                drawNativeNotification('Press ~INPUT_CONTEXT~ to buy/sell chips')
                if IsControlJustPressed(0, 51) then 
                    RageUI.Visible(RMenu:Get("chipsDesk", "main"), true)
                    isInMenu = true
                end
            end
        end
        if isInArea(chipsDesk, 1.4) == false and isInMenu then
            RageUI.Visible(RMenu:Get("chipsDesk", "main"), false)
            isInMenu = false
        end
        Citizen.Wait(0)
    end
end)



function isInArea(coords, radius)
    local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
    local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, coords.x, coords.y, coords.z)
    if dist <= radius then
        return true
    end
    return false
end