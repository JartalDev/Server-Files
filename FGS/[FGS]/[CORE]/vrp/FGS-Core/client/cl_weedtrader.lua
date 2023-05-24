RMenu.Add('WeedTrader', 'main', RageUI.CreateMenu("", "~r~Weed Dealer", 1250,100, "weedtrader", "weedtrader"))

weedindex = {
    weedsell = 1
}

weedamounts = { 
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
}

RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('WeedTrader', 'main')) then
        RageUI.DrawContent({ header = true, glare = true, instructionalButton = true}, function()


            RageUI.List("Sell Weed [£"..GetMoneyString(weedcfg.sellprice).."]", weedamounts, weedindex.weedsell, "Press [ENTER] to sell the amount of weed", {}, true, function(Hovered, Active, Selected, Index)
                if Active then 
                    weedindex.weedsell = Index;
                end
                if Selected then 
                    FGS_server_callback('FGS:WeedTrader', weedamounts[Index])
                end
            end)        

        end) 
    end
end)


RegisterNetEvent('WeedTrader:menu')
AddEventHandler('WeedTrader:menu', function()
    RageUI.Visible(RMenu:Get("WeedTrader", "main"))
    alert('~r~Insufficent funds')
end)

isInWeedTrader = false
currentWeedTrader = nil
Citizen.CreateThread(function() 
    while true do
        for k, v in pairs(weedcfg.locations) do 
            local x,y,z = table.unpack(v.weed)
            local weedtradercoords = vector3(x,y,z)

            if isInArea(weedtradercoords, 100.0) then 
                DrawMarker(27, vector3(x,y,z-0.9), 0, 0, 0, 0, 0, 0, 0.8, 0.8, 0.8, 230, 0, 0, 150, 0, 0, 0, 0, 0, 0, 0)
            end
 
            if isInWeedTrader == false then
            if isInArea(weedtradercoords, 1.4) then 
                alert('Press ~INPUT_VEH_HORN~ to access Weed Trader')
                if IsControlJustPressed(0, 51) then 
                    currentWeedTrader = k
                    RageUI.Visible(RMenu:Get("WeedTrader", "main"), true)
                    isInWeedTrader = true
                    currentWeedTrader = k 
                end
            end
            end
            if isInArea(weedtradercoords, 1.4) == false and isInWeedTrader and k == currentWeedTrader then
                RageUI.ActuallyCloseAll()
                RageUI.Visible(RMenu:Get("WeedTrader", "main"), false)
                isInWeedTrader = false
                currentWeedTrader = nil
            end
        end
        Citizen.Wait(0)
    end
end)

function getAmount()
	AddTextEntry('FMMC_MPM_NA', "Enter Amount (Blank to Cancel)")
	DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "Enter Amount (Blank to Cancel)", "", "", "", "", 30)
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