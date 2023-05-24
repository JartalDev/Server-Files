RMenu.Add('cokecainTrader', 'main', RageUI.CreateMenu("", "~r~coke Dealer", 1250,100, "cokecain", "cokecain"))

cokecainindex = {
    cokecainsell = 1
}

cokecainamounts = { 
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
}

RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('cokecainTrader', 'main')) then
        RageUI.DrawContent({ header = true, glare = true, instructionalButton = true}, function()


            RageUI.List("Sell cokecain [£"..GetMoneyString(cokecaincfg.sellprice).."]", cokecainamounts, cokecainindex.cokecainsell, "Press [ENTER] to sell the amount of Cocaine", {}, true, function(Hovered, Active, Selected, Index)
                if Active then 
                    cokecainindex.cokecainsell = Index;
                end
                if Selected then 
                    FGS_server_callback('FGS:cokecainTrader', cokecainamounts[Index])
                end
            end)        

        end) 
    end
end)


RegisterNetEvent('cokecainTrader:menu')
AddEventHandler('cokecainTrader:menu', function()
    RageUI.Visible(RMenu:Get("cokecainTrader", "main"))
    alert('~r~Insufficent funds')
end)

isIncokecainTrader = false
currentcokecainTrader = nil
Citizen.CreateThread(function() 
    while true do
        for k, v in pairs(cokecaincfg.locations) do 
            local x,y,z = table.unpack(v.cokecain)
            local cokecaintradercoords = vector3(x,y,z)

            if isInArea(cokecaintradercoords, 100.0) then 
                DrawMarker(27, vector3(x,y,z-0.9), 0, 0, 0, 0, 0, 0, 0.8, 0.8, 0.8, 230, 0, 0, 150, 0, 0, 0, 0, 0, 0, 0)
            end
 
            if isIncokecainTrader == false then
            if isInArea(cokecaintradercoords, 1.4) then 
                alert('Press ~INPUT_VEH_HORN~ to access Cocaine Trader')
                if IsControlJustPressed(0, 51) then 
                    currentcokecainTrader = k
                    RageUI.Visible(RMenu:Get("cokecainTrader", "main"), true)
                    isIncokecainTrader = true
                    currentcokecainTrader = k 
                end
            end
            end
            if isInArea(cokecaintradercoords, 1.4) == false and isIncokecainTrader and k == currentcokecainTrader then
                RageUI.ActuallyCloseAll()
                RageUI.Visible(RMenu:Get("cokecainTrader", "main"), false)
                isIncokecainTrader = false
                currentcokecainTrader = nil
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