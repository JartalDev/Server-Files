RMenu.Add('HeroinTrader', 'main', RageUI.CreateMenu("", "~r~Heroin Dealer", 1250,100, "heroin", "heroin"))

heroinindex = {
    heroinsell = 1
}

heroinamounts = { 
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
}

RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('HeroinTrader', 'main')) then
        RageUI.DrawContent({ header = true, glare = true, instructionalButton = true}, function()


            RageUI.List("Sell Heroin [£"..GetMoneyString(heroincfg.sellprice).."]", heroinamounts, heroinindex.heroinsell, "Press [ENTER] to sell the amount of heroin", {}, true, function(Hovered, Active, Selected, Index)
                if Active then 
                    heroinindex.heroinsell = Index;
                end
                if Selected then 
                    FGS_server_callback('FGS:HeroinTrader', heroinamounts[Index])
                end
            end)        

        end) 
    end
end)


RegisterNetEvent('HeroinTrader:menu')
AddEventHandler('HeroinTrader:menu', function()
    RageUI.Visible(RMenu:Get("HeroinTrader", "main"))
    alert('~r~Insufficent funds')
end)

isInHeroinTrader = false
currentHeroinTrader = nil
Citizen.CreateThread(function() 
    while true do
        for k, v in pairs(heroincfg.locations) do 
            local x,y,z = table.unpack(v.heroin)
            local herointradercoords = vector3(x,y,z)

            if isInArea(herointradercoords, 100.0) then 
                DrawMarker(27, vector3(x,y,z-0.9), 0, 0, 0, 0, 0, 0, 0.8, 0.8, 0.8, 230, 0, 0, 150, 0, 0, 0, 0, 0, 0, 0)
            end
 
            if isInHeroinTrader == false then
            if isInArea(herointradercoords, 1.4) then 
                alert('Press ~INPUT_VEH_HORN~ to access Heroin Trader')
                if IsControlJustPressed(0, 51) then 
                    currentHeroinTrader = k
                    RageUI.Visible(RMenu:Get("HeroinTrader", "main"), true)
                    isInHeroinTrader = true
                    currentHeroinTrader = k 
                end
            end
            end
            if isInArea(herointradercoords, 1.4) == false and isInHeroinTrader and k == currentHeroinTrader then
                RageUI.ActuallyCloseAll()
                RageUI.Visible(RMenu:Get("HeroinTrader", "main"), false)
                isInHeroinTrader = false
                currentHeroinTrader = nil
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