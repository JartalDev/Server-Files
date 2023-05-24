local spawnpoint = {vector3(-45.393093109131,-1173.7066650391,26.110569000244)}
local Ismenuopened = false
local display = false

RegisterNetEvent("FGS-RESPAWN-CORE:openrespawnmenu")
AddEventHandler("FGS-RESPAWN-CORE:openrespawnmenu", function()
    SetDisplay(true)
		backgroundBlur() 
end)

RegisterNUICallback("tptohomerton", function()
    SetDisplay(false)
	SetEntityCoords(PlayerPedId(), 361.84051513672,-593.13464355469,28.664552688599)
end)
RegisterNUICallback("tptopaleto", function()
    SetDisplay(false)
	SetEntityCoords(PlayerPedId(), -246.71606445313,6330.7153320313,32.426177978516)
end)
RegisterNUICallback("tptosandy", function()
    SetDisplay(false)
	SetEntityCoords(PlayerPedId(), 1841.5405273438,3668.8037109375,33.679920196533)
end)
RegisterNUICallback("tptopd", function()
	SetDisplay(false)
	SetEntityCoords(PlayerPedId(), 442.89712524414, -983.30938720703, 30.689605712891)
end)
RegisterNUICallback("tptovespucci", function()
	SetDisplay(false)
	SetEntityCoords(PlayerPedId(), -1107.4702148438,-835.88720703125,19.001470565796)
end)
RegisterNUICallback("tptorebel", function()
	SetDisplay(false)
	SetEntityCoords(PlayerPedId(), 1594.365234375,6447.1357421875,25.31713104248)
end)
RegisterNUICallback("tptovip", function()
	SetDisplay(false)
	SetEntityCoords(PlayerPedId(), 143.00798034668,-1071.6424560547,29.192348480225)
end)

function SetDisplay(bool)	
	display = bool
	SetNuiFocus(bool, bool)
	SendNUIMessage({
			type = "respawnmenu",
			status = bool,
	})		
end

function backgroundBlur() 
	 TransitionToBlurred(1000)
end 
  
function removebackgroundBlur() 
	TransitionFromBlurred(1000) 
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if Ismenuopened then
			FreezeEntityPosition(PlayerPedId(-1), true)
			SetDisplay(true)
			backgroundBlur() 
		else
			FreezeEntityPosition(PlayerPedId(-1), false)
            SetDisplay(false)
						removebackgroundBlur()
			Citizen.Wait(500)
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerCoords, isInMarker, currentZone, letSleep = GetEntityCoords(PlayerPedId()), false, nil, true
		for k,v in pairs(spawnpoint) do
			local distance = #(playerCoords - v)

			if distance < 120.0 then
				letSleep = false
				if distance < 1.5 then
					isInMarker, currentZone = true, k
				end
			end
		end
		if (isInMarker and not hasAlreadyEnteredMarker) or (isInMarker and lastZone ~= currentZone) then
			hasAlreadyEnteredMarker, lastZone = true, currentZone
			Ismenuopened = true
			SetDisplay(true)
			backgroundBlur() 
		end
		if not isInMarker and hasAlreadyEnteredMarker then
			hasAlreadyEnteredMarker = false
			Ismenuopened = false
			SetDisplay(false)
			removebackgroundBlur()
		end
		if letSleep then
			Citizen.Wait(500)
		end
	end
end)