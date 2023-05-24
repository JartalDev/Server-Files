local carry = {
	InProgress = false,
	targetSrc = -1,
	type = "",
	personCarrying = {
		animDict = "missfinale_c2mcs_1",
		anim = "fin_c2_mcs_1_camman",
		flag = 49,
	},
	personCarried = {
		animDict = "nm",
		anim = "firemans_carry",
		attachX = 0.27,
		attachY = 0.15,
		attachZ = 0.63,
		flag = 33,
	}
}

RegisterCommand("carry",function(source, args)
	if not carry.InProgress then
		local closestPlayer = GetClosestPlayer(3)
		if closestPlayer then
			local targetSrc = GetPlayerServerId(closestPlayer)
			if targetSrc ~= -1 then
				FGS_server_callback('FGS:CarryRequest',targetSrc)
			else
				drawNativeNotification("~r~No one nearby to carry!")
			end
		else
			drawNativeNotification("~r~No one nearby to carry!")
		end
	else
		carry.InProgress = false
		ClearPedSecondaryTask(PlayerPedId())
		DetachEntity(PlayerPedId(), true, false)
		FGS_server_callback("CarryPeople:stop",carry.targetSrc)
		carry.targetSrc = 0
	end
end,false)

RegisterNetEvent("CarryPeople:syncTarget")
AddEventHandler("CarryPeople:syncTarget", function(targetSrc)
	local targetPed = GetPlayerPed(GetPlayerFromServerId(targetSrc))
	carry.InProgress = true
	ensureAnimDict(carry.personCarried.animDict)
	AttachEntityToEntity(PlayerPedId(), targetPed, 0, carry.personCarried.attachX, carry.personCarried.attachY, carry.personCarried.attachZ, 0.5, 0.5, 180, false, false, false, false, 2, false)
	carry.type = "beingcarried"
end)

RegisterNetEvent("CarryPeople:cl_stop")
AddEventHandler("CarryPeople:cl_stop", function()
	carry.InProgress = false
	ClearPedSecondaryTask(PlayerPedId())
	DetachEntity(PlayerPedId(), true, false)
end)

Citizen.CreateThread(function()
	while true do
		if carry.InProgress then
			if carry.type == "beingcarried" then
				if not IsEntityPlayingAnim(PlayerPedId(), carry.personCarried.animDict, carry.personCarried.anim, 3) then
					TaskPlayAnim(PlayerPedId(), carry.personCarried.animDict, carry.personCarried.anim, 8.0, -8.0, 100000, carry.personCarried.flag, 0, false, false, false)
				end
			elseif carry.type == "carrying" then
				if not IsEntityPlayingAnim(PlayerPedId(), carry.personCarrying.animDict, carry.personCarrying.anim, 3) then
					TaskPlayAnim(PlayerPedId(), carry.personCarrying.animDict, carry.personCarrying.anim, 8.0, -8.0, 100000, carry.personCarrying.flag, 0, false, false, false)
				end
			end
		end
		Wait(0)
	end
end)

senderSrc = nil

RegisterNetEvent("FGS:StartCarry")
AddEventHandler("FGS:StartCarry", function(targetSrc)
	local targetSrc = targetSrc
	carry.InProgress = true
	carry.targetSrc = targetSrc
	FGS_server_callback("CarryPeople:sync",targetSrc)
	ensureAnimDict(carry.personCarrying.animDict)
	carry.type = "carrying"
end)

RegisterNetEvent("FGS:CarryTargetAsk")
AddEventHandler("FGS:CarryTargetAsk", function(senderSrc)
	carryrequest = true
	Citizen.CreateThread(function()
		while carryrequest do
			if IsControlJustPressed(1, Keys["="]) then
				FGS_server_callback("FGS:CarryAccepted",senderSrc)
				carryrequest = false
			elseif IsControlJustPressed(1, Keys["-"]) then
				FGS_server_callback("FGS:CarryDeclined",senderSrc)
				carryrequest = false
			end
			Wait(0)
		end
	end)
end)
