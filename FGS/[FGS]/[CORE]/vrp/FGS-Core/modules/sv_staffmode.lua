local staffmode = {}

RegisterCommand("staffon", function(source, args)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id, "staff.mode") then 
		if not staffmode[source] then
			TriggerClientEvent("FGS:staffon", source, true)
			staffmode[source] = source
		else
			TriggerClientEvent("FGS:staffon", source, false)
			staffmode[source] = nil
		end
	end
end)

RegisterServerEvent('FGS:NoClipCheck')
AddEventHandler('FGS:NoClipCheck', function()
    local source = source
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id, "admin.noclip") then 
		vRPclient.toggleNoclip(source)
	else
		vRPclient.notify(source,{"~r~You do not have permission to noclip while in staff mode."})
	end
end)