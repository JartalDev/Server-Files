RMenu.Add('methTrader', 'main', RageUI.CreateMenu("", "~r~meth Dealer", 1250,100, "meth", "meth"))
methindex = {
    methsell = 1
}

methamounts = { 
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
}

RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('methTrader', 'main')) then
        RageUI.DrawContent({ header = true, glare = true, instructionalButton = true}, function()


            RageUI.List("Sell meth [£"..GetMoneyString(methcfg.sellprice).."]", methamounts, methindex.methsell, "Press [ENTER] to sell the amount of meth", {}, true, function(Hovered, Active, Selected, Index)
                if Active then 
                    methindex.methsell = Index;
                end
                if Selected then 
                    FGS_server_callback('FGS:methTrader', methamounts[Index])
                end
            end)        

        end) 
    end
end)


RegisterNetEvent('methTrader:menu')
AddEventHandler('methTrader:menu', function()
    RageUI.Visible(RMenu:Get("methTrader", "main"))
    alert('~r~Insufficent funds')
end)

isInmethTrader = false
currentmethTrader = nil
Citizen.CreateThread(function() 
    while true do
        for k, v in pairs(methcfg.locations) do 
            local x,y,z = table.unpack(v.meth)
            local methtradercoords = vector3(x,y,z)

            if isInArea(methtradercoords, 100.0) then 
                DrawMarker(27, vector3(x,y,z-0.9), 0, 0, 0, 0, 0, 0, 0.8, 0.8, 0.8, 230, 0, 0, 150, 0, 0, 0, 0, 0, 0, 0)
            end
 
            if isInmethTrader == false then
            if isInArea(methtradercoords, 1.4) then 
                alert('Press ~INPUT_VEH_HORN~ to access meth Trader')
                if IsControlJustPressed(0, 51) then 
                    currentmethTrader = k
                    RageUI.Visible(RMenu:Get("methTrader", "main"), true)
                    isInmethTrader = true
                    currentmethTrader = k 
                end
            end
            end
            if isInArea(methtradercoords, 1.4) == false and isInmethTrader and k == currentmethTrader then
                RageUI.ActuallyCloseAll()
                RageUI.Visible(RMenu:Get("methTrader", "main"), false)
                isInmethTrader = false
                currentmethTrader = nil
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