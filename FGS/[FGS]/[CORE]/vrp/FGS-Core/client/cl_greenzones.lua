--[[
DON'T TOUCH ANY THING HERE OR ILL REMOVE YOUR CAR DEV
]]

local cfg = module("FGS-CARS", "cfg/cfg_speedcap")

inGreenzone = false








local blips = {
	{title="Safe Zone", colour=2, id=1, pos=vector3(333.91488647461,-597.16156005859,29.292747497559),dist=35,nonRP=false,setBit=false}, --ST THOOMAS
	--{title="Safe Zone", colour=2, id=1, pos=vector3(15.886326789856,-1066.6859130859,38.152130126953),dist=85,nonRP=false,setBit=false}, --ST THOOMAS
	{title="Safe Zone", colour=2, id=1, pos=vector3(154.30529785156,-1049.1298828125,29.243709564209),dist=55,nonRP=false,setBit=false}, -- jd garage
	-- {title="Safe Zone", colour=2, id=1, pos=vector3(1779.1336669922,2583.392578125,45.797832489014),dist=80,nonRP=false,setBit=false}, --prison
	{title="Safe Zone", colour=2, id=1, pos=vector3(-538.44488525391,-218.1847076416,40.400074005127),dist=60,nonRP=false,setBit=false}, --Job
	{title="Safe Zone", colour=2, id=1, pos=vector3(246.30143737793,-782.50170898438,30.573167800903),dist=40,nonRP=false,setBit=false}, --legion garage
	{title="Safe Zone", colour=2, id=1, pos=vector3(3511.8503417969,2567.5361328125,9.545202255249),dist=105,adminzone=true,setBit=true}, --adminzone
	{title="Safe Zone", colour=2, id=1, pos=vector3(-2167.8471679688,5196.4565429688,16.880462646484),dist=130,nonRP=true,setBit=false}, --donater
	{title="Safe Zone", colour=2, id=1, pos=vector3(1112.1011962891,227.21548461914,-49.624801635742),dist=70,nonRP=false,setBit=false,interior=true}, --Casino
--	{title="Safe Zone", colour=2, id=1, pos=vector3(-1670.4360351563,-902.43530273438,8.4033660888672),dist=30,nonRP=false,setBit=false,interior=true}, --MOVIE
	{title="Safe Zone", colour=2, id=1, pos=vector3(445.16696166992,-995.29583740234,30.689491271973),dist=30,nonRP=false,setBit=false,interior=true}, --mrpd

	
}
     



--local pos = AddBlipForRadius(-1670.4360351563,-902.43530273438,8.4033660888672, 30.0) -- big screen
--SetBlipColour(pos, 2)
--SetBlipAlpha(pos, 170)
local pos = AddBlipForRadius(333.91488647461,-597.16156005859,29.292747497559, 35.0) -- st thomas
SetBlipColour(pos, 2)
SetBlipAlpha(pos, 170)
local pos = AddBlipForRadius(154.30529785156,-1049.1298828125,29.243709564209, 55.0) -- jd green 
SetBlipColour(pos, 2)
SetBlipAlpha(pos, 170)
local pos = AddBlipForRadius(108.45377349854,-1943.3997802734,20.803728103638, 35.0) -- Green circle at weed
SetBlipColour(pos, 2)
SetBlipAlpha(pos, 70)
local pos = AddBlipForRadius(246.30143737793,-782.50170898438,30.573167800903, 40.0) -- legion garage
SetBlipColour(pos, 2)
SetBlipAlpha(pos, 170)
local pos = AddBlipForRadius(-538.44488525391,-218.1847076416,40.400074005127, 60.0) -- town hall
SetBlipColour(pos, 2)
SetBlipAlpha(pos, 170)
local pos = AddBlipForRadius(445.16696166992,-995.29583740234,30.689491271973, 40.0) -- mrpd
SetBlipColour(pos, 2)
SetBlipAlpha(pos, 170)


InsideSafeZone = false
setDrawGreenZoneUI = false
setDrawNonRpZoneUI = false
setDrawAdminIsland = false
Citizen.CreateThread(function()
	while true do
		for index,info in pairs(blips) do
			local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
			safeZoneDist = #(plyCoords-info.pos) 
			while safeZoneDist < info.dist do
				local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
				safeZoneDist = #(plyCoords-info.pos)
				
				if info.nonRP then
					setDrawNonRpZoneUI = true
				else

					if not info.setBit then
						setDrawGreenZoneUI = true
						showEnterGreenzone = true
						showExitGreenzone = false
						greenzoneTimer = 1
						info.setBit = true
					end
					if info.interior then 
						setDrawGreenInterior = true
					end
					if info.adminzone then 
						setDrawAdminIsland = true
					end

				end
				Wait(1000)
			end
			if info.setBit then
				showEnterGreenzone = false
				showExitGreenzone = true
				greenzoneTimer = 1
				----print("greenzoneTimer = 10 #2 " .. tostring(greenzoneTimer))
				info.setBit = false
			end
			setDrawNonRpZoneUI = false
			setDrawGreenZoneUI = false
			setDrawAdminIsland = false
			showEnterGreenzone = false
			setDrawGreenInterior = false

            Citizen.InvokeNative(0x5FFE9B4144F9712F, false)
			SetEntityInvincible(GetPlayerPed(-1), false)
			SetPlayerInvincible(PlayerId(), false)
			--SetPedCanRagdoll(GetPlayerPed(-1), true)
			ClearPedBloodDamage(GetPlayerPed(-1))
			ResetPedVisibleDamage(GetPlayerPed(-1))
			ClearPedLastWeaponDamage(GetPlayerPed(-1))
			SetEntityProofs(GetPlayerPed(-1), false, false, false, false, false, false, false, false)
			SetEntityCanBeDamaged(GetPlayerPed(-1), true)
			NetworkSetFriendlyFireOption(true)
			inGreenzone = false
		end
		Wait(1000)
	end
end)

Citizen.CreateThread(function()
	while true do
		local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
		--cityZoneDist = #(plyCoords-vector3(4755.7666015625,3700.8986816406,15.580455780029))

		cityZoneDist = #(plyCoords-vector3(171.07974243164,-1024.8974609375,29.3747520446784))
		if cityZoneDist < 550 then
			inCityZone = true 
		else 
			inCityZone = false 
		end
		--print("inCityZone: " .. tostring(inCityZone))
		Wait(1000)
	end
end)

Citizen.CreateThread(function()
	while true do
		if setDrawGreenZoneUI then
			DisableControlAction(2, 37, true) -- disable weapon wheel (Tab)
			DisablePlayerFiring(GetPlayerPed(-1),true) -- Disables firing all together if they somehow bypass inzone Mouse Disable
			DisableControlAction(0, 106, true) -- Disable in-game mouse controls
			DisableControlAction(0, 45, true)
			DisableControlAction(0, 24, true)
			DisableControlAction(0, 263, true)
			DisableControlAction(0, 170, true)
            Citizen.InvokeNative(0x5FFE9B4144F9712F, true)
		end
		if setDrawNonRpZoneUI then
			bank_drawTxt(0.83, 1.40, 1.0, 1.0, 0.43, "You have entered a non-RP greenzone, you may talk OOC here", 0, 255, 0, 255)
			DisableControlAction(2, 37, true) -- disable weapon wheel (Tab)
			DisablePlayerFiring(GetPlayerPed(-1),true) -- Disables firing all together if they somehow bypass inzone Mouse Disable
			DisableControlAction(0, 45, true)
			DisableControlAction(0, 24, true)
			DisableControlAction(0, 263, true)
			DisableControlAction(0, 170, true)
            Citizen.InvokeNative(0x5FFE9B4144F9712F, true)
		end
		if setDrawAdminIsland then
			inRedZone = false
			bank_drawTxt(0.83, 1.40, 1.0, 1.0, 0.43, "You have entered Admin Island, You may talk OOC here", 0, 255, 0, 255)
			DisableControlAction(2, 37, true) -- disable weapon wheel (Tab)
			DisablePlayerFiring(GetPlayerPed(-1),true) -- Disables firing all together if they somehow bypass inzone Mouse Disable
			DisableControlAction(0, 45, true)
			DisableControlAction(0, 24, true)
			DisableControlAction(0, 263, true)
			DisableControlAction(0, 170, true)
            Citizen.InvokeNative(0x5FFE9B4144F9712F, true)
		end
		if setDrawGreenInterior then 
			DisableControlAction(0, 106, true) -- Disable in-game mouse controls
			DisableControlAction(0, 45, true)
			DisableControlAction(0, 24, true)
			DisableControlAction(0, 263, true)
			DisableControlAction(0, 170, true)
			DisableControlAction(0, 22, true)
            Citizen.InvokeNative(0x5FFE9B4144F9712F, true)
		end
		Wait(0)
	end
end)



Citizen.CreateThread(function()
	while true do
		if setDrawGreenZoneUI or setDrawNonRpZoneUI then
			SetEntityMaxSpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false),22.3)
			SetEntityInvincible(GetPlayerPed(-1), true)
			SetPlayerInvincible(PlayerId(), true)
			-- SetPedCanRagdoll(GetPlayerPed(-1), false)
			ClearPedBloodDamage(GetPlayerPed(-1))
			SetCurrentPedWeapon(GetPlayerPed(-1),GetHashKey("WEAPON_UNARMED"),true)
			ResetPedVisibleDamage(GetPlayerPed(-1))
			ClearPedLastWeaponDamage(GetPlayerPed(-1))
			SetEntityProofs(GetPlayerPed(-1), true, true, true, true, true, true, true, true)
			SetEntityCanBeDamaged(GetPlayerPed(-1), false)
		else
			if GetVehiclePedIsIn(PlayerPedId(), false) ~= 0 then
				if not inCityZone then
					if GetVehicleClass(GetVehiclePedIsIn(GetPlayerPed(-1),true)) ~= 13 then
						SetEntityMaxSpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false),111.5)
					else
						SetEntityMaxSpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false),11001.5)
					end
				else 
					if GetVehicleClass(GetVehiclePedIsIn(GetPlayerPed(-1),true)) ~= 13 then
						SetEntityMaxSpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false),44.6)
					else
						SetEntityMaxSpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false),11001.5)
					end
				end
			end
		end
		Wait(0)
	end
end)

--speed in mph/2.236936


-- Citizen.CreateThread(function()
--         while true do
--             Citizen.Wait(0)
-- 			-- lambolb = [85589954]
-- 			-- topv = [-647307409]
--             if not inCityZone then
--                 local model = GetEntityModel(GetVehiclePedIsIn(GetPlayerPed(-1)))
				
--                 if model == 85589954 or model == -852361603 then
--                     SetEntityMaxSpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false), 156.4) -- lambolb
--                 elseif model == -647307409  then
--                     SetEntityMaxSpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false), 223.5) --topv
--                 elseif model == -493410377 or model == 1065452892 or model == 974390719 then
--                     SetEntityMaxSpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false), 89.4) --raptor150 --offroaders
-- 					elseif model == -830945829 or model == -13115633488 or model == -1881066373 then
--                     SetEntityMaxSpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false), 102.81) -- Suvs
--                 else
--                     SetEntityMaxSpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false), 111.75) -- all cars 250
--                 end
--             end
--         end
--     end)


	RegisterCommand('getmodel', function(source, args, RawCommand)
		local model = GetEntityModel(GetVehiclePedIsIn(GetPlayerPed(-1)))
		print(model)
	end)
	

	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(0)
			local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
			if not inCityZone then		
			if vehicle ~= false then
				local model = GetEntityModel(vehicle)
	
				if cfg.vehicleMaxSpeeds[model] ~= nil then
					SetEntityMaxSpeed(vehicle, cfg.maxSpeeds[cfg.vehicleMaxSpeeds[model]])
				else
					SetEntityMaxSpeed(vehicle, cfg.maxSpeeds["250"])
					end
				end
			end
		end
	end)
	
	--[[
	
		DON'T TOUCH
	
		GO TO CONFIG FILE TO CHANGE MAX SPEEDS!
	
	]]



showEnterGreenzone = false
showExitGreenzone = false
greenzoneTimer = 0

--[[ Citizen.CreateThread(function()
	local ticks = 5000
	while true do
		if showEnterGreenzone and greenzoneTimer > 0 then
			ticks = 1
			-- bank_drawTxt(0.92, 1.44, 1.0,1.0,0.4, "You have entered a greenzone, OOC is allowed!", 0, 255, 0, 255)
			TriggerEvent("swt_notifications:Success",nil,"You have entered a Greenzone!","top-right",nil,true)
		end
		if showExitGreenzone and greenzoneTimer > 0 then
			ticks = 1
			-- bank_drawTxt(0.92, 1.44, 1.0,1.0,0.4, "You have left a greenzone, Please follow city rules!", 255, 17, 0, 255)
			TriggerEvent("swt_notifications:Negative",nil,"You have exited a Greenzone!","top-right",nil,true)
		end
		Wait(ticks)
		ticks = 5000
	end
end) ]]

Citizen.CreateThread(function()
	while true do
		greenzoneTimer = greenzoneTimer - 1
		Wait(0)
	end
end)

function bank_drawTxt(x,y ,width,height,scale, text, r,g,b,a, outline)
    SetTextFont(0)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    if(outline)then
	    SetTextOutline()
	end
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end

function bank_drawTxt2(x,y ,width,height,scale, text, r,g,b,a, outline)
    SetTextFont(7)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    if(outline)then
	    SetTextOutline()
	end
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end

function DrawAdvancedText(x,y ,w,h,sc, text, r,g,b,a,font,jus)
    SetTextFont(font)
    SetTextProportional(0)
    SetTextScale(sc, sc)
	N_0x4e096588b13ffeca(jus)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
	DrawText(x - 0.1+w, y - 0.02+h)
end

--Citizen.CreateThread(function()
 --   blip = AddBlipForCoord(1779.1336669922,2583.392578125,45.797832489014)
 --   SetBlipSprite(blip, 84)
 --   SetBlipScale(blip, 0.5)
 --   SetBlipDisplay(blip, 2)
 --   SetBlipColour(blip, 1)
 --   SetBlipAsShortRange(blip, true)
 --   BeginTextCommandSetBlipName("STRING")
 --   AddTextComponentString("Prison")
 --   EndTextCommandSetBlipName(blip)
--  end)


-- weather = "EXTRASUNNY"

--   Citizen.CreateThread(function()
-- 	while true do
-- 	  Citizen.Wait(0)
-- 	  DisableControlAction(0, 140, true)
-- 	  WaterOverrideSetStrength(0.8)
-- 	  SetWeatherTypePersist(weather)
-- 	  SetWeatherTypeNowPersist(weather)
-- 	  SetWeatherTypeNow(weather)
-- 	  SetOverrideWeather(weather)
-- 	 end
--   end)
  
  














