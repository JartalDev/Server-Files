RMenu.Add('EcstasyTrader', 'main', RageUI.CreateMenu("", "~r~Ecstasy Dealer", 1250,100, "ecstasy", "ecstasy"))

ecstasyindex = {
    ecstasysell = 1
}

ecstasyamounts = { 
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
}

RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('EcstasyTrader', 'main')) then
        RageUI.DrawContent({ header = true, glare = true, instructionalButton = true}, function()

            RageUI.List("Sell Ecstasy [£"..GetMoneyString(ecstasycfg.sellprice).."]", ecstasyamounts, ecstasyindex.ecstasysell, "Press [ENTER] to sell the amount of Ecstasy", {}, true, function(Hovered, Active, Selected, Index)
                if Active then 
                    ecstasyindex.ecstasysell = Index;
                end
                if Selected then 
                    FGS_server_callback('FGS:EcstasyTrader', ecstasyamounts[Index])
                end
            end)     

        end) 
    end
end)


RegisterNetEvent('EcstasyTrader:menu')
AddEventHandler('EcstasyTrader:menu', function()
    RageUI.Visible(RMenu:Get("EcstasyTrader", "main"))
    alert('~r~Insufficent funds')
end)

isInEcstasyTrader = false
currentEcstasyTrader = nil
Citizen.CreateThread(function() 
    while true do
        for k, v in pairs(ecstasycfg.locations) do 
            local x,y,z = table.unpack(v.ecstasy)
            local ecstasytradercoords = vector3(x,y,z)

            if isInArea(ecstasytradercoords, 100.0) then 
                DrawMarker(27, vector3(x,y,z-0.9), 0, 0, 0, 0, 0, 0, 0.8, 0.8, 0.8, 230, 0, 0, 150, 0, 0, 0, 0, 0, 0, 0)
            end
 
            if isInEcstasyTrader == false then
            if isInArea(ecstasytradercoords, 1.4) then 
                alert('Press ~INPUT_VEH_HORN~ to access Ecstasy Trader')
                if IsControlJustPressed(0, 51) then 
                    currentEcstasyTrader = k
                    RageUI.Visible(RMenu:Get("EcstasyTrader", "main"), true)
                    isInEcstasyTrader = true
                    currentEcstasyTrader = k 
                end
            end
            end
            if isInArea(ecstasytradercoords, 1.4) == false and isInEcstasyTrader and k == currentEcstasyTrader then
                RageUI.ActuallyCloseAll()
                RageUI.Visible(RMenu:Get("EcstasyTrader", "main"), false)
                isInEcstasyTrader = false
                currentEcstasyTrader = nil
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