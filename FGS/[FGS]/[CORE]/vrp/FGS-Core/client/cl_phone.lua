RMenu.Add('FGSPhone', 'phonemain', RageUI.CreateMenu("", "~b~Options Menu",1300,100, "mobilebanking", "mobilebanking"))
RMenu.Add('FGSPhone', 'mpay', RageUI.CreateMenu("", "~b~MPay Menu",1300,100, "mobilebanking", "mobilebanking"))
RMenu.Add('FGSPhone', 'cash', RageUI.CreateMenu("", "~b~MPay Menu",1300,100, "mobilebanking", "mobilebanking"))

RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('FGSPhone', 'phonemain')) then
        RageUI.DrawContent({ header = true, glare = true, instructionalButton = true}, function()

            RageUI.Button("Ask ID", "Ask the nearest player for his ID", { RightLabel = ">" }, true, function(Hovered, Active, Selected)
                if Selected then
                    FGS_server_callback('FGS:AskID')
                end
            end)
			RageUI.Button("Search Player", "Search the nearest player", { RightLabel = ">" }, true, function(Hovered, Active, Selected)
                if Selected then
                    FGS_server_callback('FGS:SearchPlr')
                end
            end)

			RageUI.Button("MPay", "Open the MPay menu", { RightLabel = ">>>" }, true, function(Hovered, Active, Selected)
            end, RMenu:Get('FGSPhone', 'mpay'))

			RageUI.Button("Give cash", "Give Cash", { RightLabel = ">>>" }, true, function(Hovered, Active, Selected)
            end, RMenu:Get('FGSPhone', 'cash'))

       end)
    end
end)

permid = 0
amountmoney = 0
RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('FGSPhone', 'mpay')) then
        RageUI.DrawContent({ header = true, glare = true, instructionalButton = true}, function()

			RageUI.Button("Payment MPay ID [MPayID: "..permid.."]", "", {}, true, function(Hovered, Active, Selected) 
                if Selected then 
                    AddTextEntry('FMMC_MPM_NC', "Enter perm id to send money to: ")
                    DisplayOnscreenKeyboard(1, "FMMC_MPM_NC", "", "", "", "", "", 30)
                    while (UpdateOnscreenKeyboard() == 0) do
                        DisableAllControlActions(0);
                        Wait(0);
                    end
                    if (GetOnscreenKeyboardResult()) then
                        local result = GetOnscreenKeyboardResult()
                        if result == tostring(tonumber(result)) then 
                            result = tonumber(result)
                            permid = result
						else
							notify("~r~The value you entered isn't a number.")
                        end
                    end
                end
            end)
            RageUI.Button("Transaction Amount [Money: £"..GetMoneyString(amountmoney).."]", "", {}, true, function(Hovered, Active, Selected) 
                if Selected then 
                    AddTextEntry('FMMC_MPM_NC', "Enter amount of money to send to Perm ID: "..permid)
                    DisplayOnscreenKeyboard(1, "FMMC_MPM_NC", "", "", "", "", "", 30)
                    while (UpdateOnscreenKeyboard() == 0) do
                        DisableAllControlActions(0);
                        Wait(0);
                    end
                    if (GetOnscreenKeyboardResult()) then
                        local amount = GetOnscreenKeyboardResult()
                        if amount == tostring(tonumber(amount)) then 
                            amount = tonumber(amount)
                            amountmoney = amount
						else
							notify("~r~The value you entered isn't a number.")
                        end
                    end
                end
            end)
            if permid > 0 and amountmoney > 0 then
				RageUI.Button("~g~~h~Send money", "MPay ID: "..permid.." Transaction Amount: £"..GetMoneyString(amountmoney), {}, true, function(Hovered, Active, Selected) 
					if Selected then 
						FGS_server_callback('FGS:MPay',permid,amountmoney)
					end
            	end)
			end

       end)
    end

    if RageUI.Visible(RMenu:Get('FGSPhone', 'cash')) then
        RageUI.DrawContent({ header = true, glare = true, instructionalButton = true}, function()

			RageUI.Button("Payment ID [ID: "..permid.."]", "", {}, true, function(Hovered, Active, Selected) 
                if Selected then 
                    AddTextEntry('FMMC_MPM_NC', "Enter perm id to give money to: ")
                    DisplayOnscreenKeyboard(1, "FMMC_MPM_NC", "", "", "", "", "", 30)
                    while (UpdateOnscreenKeyboard() == 0) do
                        DisableAllControlActions(0);
                        Wait(0);
                    end
                    if (GetOnscreenKeyboardResult()) then
                        local result = GetOnscreenKeyboardResult()
                        if result == tostring(tonumber(result)) then 
                            result = tonumber(result)
                            permid = result
						else
							notify("~r~The value you entered isn't a number.")
                        end
                    end
                end
            end)
            RageUI.Button("Transaction Amount [Money: £"..GetMoneyString(amountmoney).."]", "", {}, true, function(Hovered, Active, Selected) 
                if Selected then 
                    AddTextEntry('FMMC_MPM_NC', "Enter amount of money to give to Perm ID: "..permid)
                    DisplayOnscreenKeyboard(1, "FMMC_MPM_NC", "", "", "", "", "", 30)
                    while (UpdateOnscreenKeyboard() == 0) do
                        DisableAllControlActions(0);
                        Wait(0);
                    end
                    if (GetOnscreenKeyboardResult()) then
                        local amount = GetOnscreenKeyboardResult()
                        if amount == tostring(tonumber(amount)) then 
                            amount = tonumber(amount)
                            amountmoney = amount
						else
							notify("~r~The value you entered isn't a number.")
                        end
                    end
                end
            end)
            if permid > 0 and amountmoney > 0 then
				RageUI.Button("~g~~h~Give money", "MPay ID: "..permid.." Transaction Amount: £"..GetMoneyString(amountmoney), {}, true, function(Hovered, Active, Selected) 
					if Selected then 
						FGS_server_callback('FGS:Pay', permid, amountmoney)
					end
            	end)
			end

       end)
    end
end)

Citizen.CreateThread(function()
	while (true) do
		Citizen.Wait(0)
	  	if IsControlJustPressed(1, 116) then
			if not RageUI.Visible(RMenu:Get("FGSPhone", "phonemain"), true) then
				RageUI.Visible(RMenu:Get("FGSPhone", "phonemain"), true)
			else
                RageUI.ActuallyCloseAll()
				RageUI.Visible(RMenu:Get("FGSPhone", "phonemain"), false)
			end
	  	end
	end
end)

Citizen.CreateThread(function()
	while (true) do
	  Citizen.Wait(0)
	  if IsControlJustPressed(1, 166) then
		if IsPedInAnyVehicle(GetPlayerPed(-1), false) == false then
			FGS_server_callback('FGS:TrunkOpened', source)
		else
			notify("~r~You cannot do this from inside of the vehicle")
		end
	  end
	end
  end)
