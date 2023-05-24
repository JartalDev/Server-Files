RMenu.Add('DiamondTrader', 'main', RageUI.CreateMenu("", "~r~Diamond Dealer", 1250,100, "diamond", "diamond"))

diamondindex = {
    diamondsell = 1
}

diamondamounts = { 
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
}

RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('DiamondTrader', 'main')) then
        RageUI.DrawContent({ header = true, glare = true, instructionalButton = true}, function()


            RageUI.List("Sell Diamond [£"..GetMoneyString(diamondcfg.sellprice).."]", diamondamounts, diamondindex.diamondsell, "Press [ENTER] to sell the amount of diamond", {}, true, function(Hovered, Active, Selected, Index)
                if Active then 
                    diamondindex.diamondsell = Index;
                end
                if Selected then 
                    FGS_server_callback('FGS:DiamondTrader', diamondamounts[Index])
                end
            end)        

        end) 
    end
end)


RegisterNetEvent('DiamondTrader:menu')
AddEventHandler('DiamondTrader:menu', function()
    RageUI.Visible(RMenu:Get("DiamondTrader", "main"))
    alert('~r~Insufficent funds')
end)

isInDiamondTrader = false
currentDiamondTrader = nil
Citizen.CreateThread(function() 
    while true do
        for k, v in pairs(diamondcfg.locations) do 
            local x,y,z = table.unpack(v.diamond)
            local diamondtradercoords = vector3(x,y,z)

            if isInArea(diamondtradercoords, 100.0) then 
                DrawMarker(27, vector3(x,y,z-0.9), 0, 0, 0, 0, 0, 0, 0.8, 0.8, 0.8, 230, 0, 0, 150, 0, 0, 0, 0, 0, 0, 0)
            end
 
            if isInDiamondTrader == false then
            if isInArea(diamondtradercoords, 1.4) then 
                alert('Press ~INPUT_VEH_HORN~ to access Diamond Trader')
                if IsControlJustPressed(0, 51) then 
                    currentDiamondTrader = k
                    RageUI.Visible(RMenu:Get("DiamondTrader", "main"), true)
                    isInDiamondTrader = true
                    currentDiamondTrader = k 
                end
            end
            end
            if isInArea(diamondtradercoords, 1.4) == false and isInDiamondTrader and k == currentDiamondTrader then
                RageUI.ActuallyCloseAll()
                RageUI.Visible(RMenu:Get("DiamondTrader", "main"), false)
                isInDiamondTrader = false
                currentDiamondTrader = nil
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