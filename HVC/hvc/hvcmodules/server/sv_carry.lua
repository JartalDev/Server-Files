local carrying = {}
--carrying[source] = targetSource, source is carrying targetSource
local carried = {}
--carried[targetSource] = source, targetSource is being carried by source
local StaffsOnDuty = {}

RegisterNetEvent("HVC:carryForce")
AddEventHandler("HVC:carryForce", function(bool)
	StaffsOnDuty[source] = bool;
end)

RegisterServerEvent("CarryPeople:sync")
AddEventHandler("CarryPeople:sync", function(targetSrc)
	local source = source
	local sourcePed = GetPlayerPed(source)
   	local sourceCoords = GetEntityCoords(sourcePed)
	local targetPed = GetPlayerPed(targetSrc)
	local targetCoords = GetEntityCoords(targetPed)
	if #(sourceCoords - targetCoords) <= 3.0 then 
		if not StaffsOnDuty[source] then
			TriggerClientEvent("HVC:ClientcarryRequestReceive", targetSrc)
			carrying[source] = targetSrc
			carried[targetSrc] = source
		else
			TriggerClientEvent("CarryPeople:syncTarget", targetSrc, source)
			TriggerClientEvent("HVC:SyncCarrying", source, targetSrc)
			carrying[source] = source
			carried[targetSrc] = targetSrc
		end
	end
end)

RegisterServerEvent("CarryPeople:stop")
AddEventHandler("CarryPeople:stop", function(targetSrc)
	local source = source

	if carrying[source] then
		TriggerClientEvent("CarryPeople:cl_stop", targetSrc)
		carrying[source] = nil
		carried[targetSrc] = nil
	elseif carried[source] then
		TriggerClientEvent("CarryPeople:cl_stop", carried[source])			
		carrying[carried[source]] = nil
		carried[source] = nil
	end
end)

AddEventHandler('playerDropped', function(reason)
	local source = source
	
	if carrying[source] then
		TriggerClientEvent("CarryPeople:cl_stop", carrying[source])
		carried[carrying[source]] = nil
		carrying[source] = nil
	end

	if carried[source] then
		TriggerClientEvent("CarryPeople:cl_stop", carried[source])
		carrying[carried[source]] = nil
		carried[source] = nil
	end
end)


RegisterServerEvent("HVC:CarryServerValidEmote") 
AddEventHandler("HVC:CarryServerValidEmote", function(target)
	TriggerClientEvent("CarryPeople:syncTarget", source, target)
	TriggerClientEvent("HVC:SyncCarrying", target, source)
end)

