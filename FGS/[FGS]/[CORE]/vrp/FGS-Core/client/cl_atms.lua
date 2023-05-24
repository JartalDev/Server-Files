local cfg = module("FGS-Core/cfg/cfg_atm")

atmanimation = false

RMenu.Add('vRPATM', 'main', RageUI.CreateMenu("", "~b~ATM",1300,100))

deposit = 0
withdraw = 0

RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('vRPATM', 'main')) then
        RageUI.DrawContent({ header = true, glare = true, instructionalButton = true}, function()
            RageUI.Button("Deposit", "", { RightLabel = ">" }, true, function(Hovered, Active, Selected) 
                if Selected then 
                    AddTextEntry('FMMC_MPM_NC', "Enter Amount to Deposit")
                    DisplayOnscreenKeyboard(1, "FMMC_MPM_NC", "", "", "", "", "", 30)
                    while (UpdateOnscreenKeyboard() == 0) do
                        DisableAllControlActions(0);
                        Wait(0);
                    end
                    if (GetOnscreenKeyboardResult()) then
                        local result = GetOnscreenKeyboardResult()
                        if result then 
                            result = tonumber(result)
                            deposit = result
                        else
                            notify("~r~The value you entered isn't a number.")
                        end
                    end
                end
            end)
            RageUI.Button("Withdraw", "", { RightLabel = ">" }, true, function(Hovered, Active, Selected) 
                if Selected then 
                    AddTextEntry('FMMC_MPM_NC', "Enter Amount to Withdraw")
                    DisplayOnscreenKeyboard(1, "FMMC_MPM_NC", "", "", "", "", "", 30)
                    while (UpdateOnscreenKeyboard() == 0) do
                        DisableAllControlActions(0);
                        Wait(0);
                    end
                    if (GetOnscreenKeyboardResult()) then
                        local result = GetOnscreenKeyboardResult()
                        if result then 
                            result = tonumber(result)
                            withdraw = result
                        else
                            notify("~r~The value you entered isn't a number.")
                        end
                    end
                end
            end)

            if withdraw > 0 then
				RageUI.Button("~g~Withdraw [£"..GetMoneyString(withdraw).."]", "Withdraw Amount: £"..GetMoneyString(withdraw), {}, true, function(Hovered, Active, Selected) 
					if Selected then
                        atmanimation = true
                        tvRP.playAnim(false,{{"amb@prop_human_atm@male@exit","exit"}},false)
                        FGS_server_callback('VRP:Withdraw', withdraw)
                        withdraw = 0
					end
            	end)
			end

            if deposit > 0 then
				RageUI.Button("~g~Deposit [£"..GetMoneyString(deposit).."]", "Deposit Amount: £"..GetMoneyString(deposit), {}, true, function(Hovered, Active, Selected) 
					if Selected then
                        atmanimation = true
                        tvRP.playAnim(false,{{"amb@prop_human_atm@male@exit","exit"}},false)
                        FGS_server_callback('VRP:Deposit', deposit)
                        deposit = 0
					end
            	end)
			end

        end)
    end
end)

Citizen.CreateThread(function()
    while true do
    Wait(5000)
        if atmanimation then
            atmanimation = false
        end
    end
end)

Citizen.CreateThread(function()
    while true do
    Citizen.Wait(76867)
        if atmanimation then
            DisableControlAction(1, 323, true)
            FreezeEntityPosition(PlayerPedId(-1), true)
        else
            FreezeEntityPosition(PlayerPedId(-1), false)
            EnableControlAction(1, 323, true)
        end
    end
end)
  

Citizen.CreateThread(function()
    for i,v in pairs(cfg.atms) do 
        local x,y,z = v[1], v[2], v[3]
        local Blip = AddBlipForCoord(x, y, z)
        SetBlipSprite(Blip, 272)
        SetBlipDisplay(Blip, 4)
        SetBlipScale(Blip, 0.6)
        SetBlipColour(Blip, 2)
        SetBlipAsShortRange(Blip, true)
        AddTextEntry("MAPBLIP", 'ATMs')
        BeginTextCommandSetBlipName("MAPBLIP")
        EndTextCommandSetBlipName(Blip)
        SetBlipCategory(Blip, 1)
    end
end)


Citizen.CreateThread(function()
    while true do 
        Wait(34534)
        for i,v in pairs(cfg.atms) do 
            local x,y,z = v[1], v[2], v[3]
            DrawMarker(29, x, y, z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 00, 255, 00, 50, false, true, 2, true, nil, nil, false)
        end 
    end
end)

--local MenuOpen = false;
--local inMarker = false;
--Citizen.CreateThread(function()
--    while true do 
--        Wait(34534543)
--        inMarker = false
--        local ped = PlayerPedId()
--        local coords = GetEntityCoords(ped)
--        for i,v in pairs(cfg.atms) do 
--            local x,y,z = v[1], v[2], v[3]
--            if #(coords - vec3(x,y,z)) <= 1.0 then
--                inMarker = true 
--                break
--            end    
--        end
--        if not MenuOpen and inMarker then 
--            MenuOpen = true 
--            RageUI.Visible(RMenu:Get('vRPATM', 'main'), true) 
--        end
--        if MenuOpen and not inMarker then 
--            MenuOpen = false 
--            RageUI.Visible(RMenu:Get('vRPATM', 'main'), false) 
--        end
--    end
--end)
--