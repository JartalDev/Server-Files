local loaded = false
local totalDamageEvents = 0
local totalHeadshots = 0
local count = 0

AddEventHandler("playerSpawned", function()
	Citizen.Wait(15000)
	loaded = true
end)
AddEventHandler("playerDropped", function (reason)
	loaded = false
end)

Citizen.CreateThread(function()
	while not loaded do
		Citizen.Wait(500)
	end
	while true do
		Citizen.Wait(5000)
		SetPlayerTargetingMode(0)
	end
end)

AddEventHandler("gameEventTriggered", function(name, data)
	if name == "CEventNetworkEntityDamage" then
		local targetEntity = data[1]
		local ped = data[2]
		local hash = data[3]

		if not IsEntityAPed(targetEntity) then
			return
		end

		if IsPedAPlayer(ped) and not IsPedDeadOrDying(targetEntity) then
			local camcoords = GetFinalRenderedCamCoord()
			local _, bone = GetPedLastDamageBone(targetEntity)
			local rays = {[1] = camcoords, [2] = vec3(camcoords.x, camcoords.y, camcoords.z + 2.5), [3] = GetOffsetFromEntityInWorldCoords(ped, 2.5, 1.5, 0.8), [4] = GetOffsetFromEntityInWorldCoords(ped, -2.5, 1.5, 0.8)}
			local dest = GetPedBoneCoords(targetEntity, bone, 0.0, 0.0, 0.0)

			for i = 1, #rays do
    			local testRay = StartShapeTestRay(rays[i], dest, 1, ped, 7)
    			local _, hit, hitLocation, _, _, entityHit = GetShapeTestResultEx(testRay)

				if hit == 1 and (entityHit == 0 or entityHit == targetEntity) then
					local threshold = GetDistanceBetweenCoords(dest, hitLocation)
					if threshold > 5.0 then
						count = count + 1
						if count >= #rays then
							TriggerServerEvent("anticheat:aimbotCheater", "Aimbot [T2]")
						end
					end
				else
					count = 0
				end
			end
		end
	end
end)

AddEventHandler("gameEventTriggered", function(name, data)
	if name == "CEventNetworkEntityDamage" then
		local targetEntity = data[1]
		local ped = data[2]
		local hash = data[3]
		local headshot = data[11]

		if not IsEntityAPed(targetEntity) then
			return
		end

		if IsPedAPlayer(ped) then
			totalDamageEvents = totalDamageEvents + 1
			if headshot == 1 then
				totalHeadshots = totalHeadshots + 1
			end
		end
	end
end)

Citizen.CreateThread(function()
	while not loaded do
		Citizen.Wait(500)
	end
	while true do
		Citizen.Wait(5000)
		if totalDamageEvents > 16 then
			local percentage = (totalHeadshots / totalDamageEvents)
			if percentage > 0.9 then
				TriggerServerEvent("anticheat:aimbotCheater", "Aimbot [T1]")
				return
			end
		end
		if totalDamageEvents > 128 then
			totalDamageEvents = 0
			totalHeadshots = 0
		end
	end
end)