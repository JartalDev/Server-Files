AddEventHandler("playerSpawned", function(spawn)
	SetCanAttackFriendly(GetPlayerPed(-1), true, false)
	NetworkSetFriendlyFireOption(true)
end)

CreateThread(function()
	while true do
		if IsControlPressed(1, 19) and IsControlJustPressed(1, 32) then
			ExecuteCommand("e whistle2")
		end
		Wait(1)
	end
  end)