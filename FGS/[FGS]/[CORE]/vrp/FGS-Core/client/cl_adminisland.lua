local adminisland = AddBlipForRadius(3501.19,2581.57,12.04,100.0)
SetBlipColour(adminisland, 2)
SetBlipAlpha(adminisland, 180)

Citizen.CreateThread(function()
	while true do
		local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
		AdminIslandDist = #(plyCoords-vector3(3501.19,2581.57,12.04))
		if AdminIslandDist < 100 then
			adminisland = true 
		else 
			adminisland = false 
		end
		Wait(100)
	end
end)

Citizen.CreateThread(function()
	while true do
		if adminisland then
            SetTextEntry_2("STRING")
            AddTextComponentString("~g~You are on admin island, you are not allowed to kill here or RP here.")
            EndTextCommandPrint(1000, 1)
            --
			DisableControlAction(2, 37, true)
			DisablePlayerFiring(GetPlayerPed(-1),true)
			DisableControlAction(0, 45, true)
			DisableControlAction(0, 24, true)
			DisableControlAction(0, 263, true)
			DisableControlAction(0, 140, true)
		end
		Wait(0)
	end
end)