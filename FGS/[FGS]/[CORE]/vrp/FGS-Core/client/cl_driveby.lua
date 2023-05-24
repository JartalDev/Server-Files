Citizen.CreateThread(function()
	while true do
		if GetVehiclePedIsIn(PlayerPedId(),false) ~= 0 then
			if GetVehicleClass(GetVehiclePedIsIn(PlayerPedId(), false)) == 15 then
				SetPlayerCanDoDriveBy(PlayerId(), true)
			else 
				SetPlayerCanDoDriveBy(PlayerId(), false)
			end
		end
		Wait(0)
	end
end)