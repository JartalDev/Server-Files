--------------------------------------------------
---- CINEMATIC CAM FOR FIVEM MADE BY KIMINAZE ----
--------------------------------------------------

local whitelisted = "steam:11000013515ea3b"

RegisterServerEvent('CinematicCam:requestPermissions')
AddEventHandler('CinematicCam:requestPermissions', function()
	local isWhitelisted = false

	-- \/ -- permission check here (set "isWhitelisted") -- \/ --

    if (GetPlayerIdentifiersSorted(source)["steam"] == whitelisted) then
        isWhitelisted = true
    end
	
	-- /\ -- permission check here (set "isWhitelisted") -- /\ --

	TriggerClientEvent('CinematicCam:receivePermissions', source, isWhitelisted)
end)

-- Return an array with all identifiers - e.g. ids["license"] = license:xxxxxxxxxxxxxxxx
function GetPlayerIdentifiersSorted(playerServerId)
    local ids = {
        ['license']    = "",
        ['steam']    = "",
        ['discord']    = "",
        ['xbl']        = "",
        ['live']    = "",
        ['fivem']    = "",
        ['name']    = "",
        ['ip']        = "",
    }

    local identifiers = GetPlayerIdentifiers(playerServerId)

    for k, identifier in pairs (identifiers) do
        local i, j = string.find(identifier, ":")
        local idType = string.sub(identifier, 1, i-1)

        ids[idType] = identifier
    end

    return ids
end