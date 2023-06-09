RegisterCommand('showwarnings', function(player, args)
    local user_id = vRP.getUserId(player)
    local permID =  tonumber(args[1])
    if permID ~= nil then
        if vRP.hasPermission(user_id,"admin.showwarn") then
            vrpwarningstables = getvrpWarnings(permID,player)
            TriggerClientEvent("vrp:showWarningsOfUser",player,vrpwarningstables)
        end
    end
end)


	
function getvrpWarnings(user_id,source) 
	vrpwarningstables = exports['sql']:executeSync("SELECT * FROM vrp_warnings WHERE user_id = @uid", {uid = user_id})
	for warningID,warningTable in pairs(vrpwarningstables) do
		date = warningTable["warning_date"]
		newdate = tonumber(date) / 1000
		newdate = os.date('%Y-%m-%d', newdate)
		warningTable["warning_date"] = newdate
	end
	return vrpwarningstables
end

RegisterServerEvent("vrp:refreshWarningSystem")
AddEventHandler("vrp:refreshWarningSystem",function()
	local source = source
	local user_id = vRP.getUserId(source)	
	vrpwarningstables = getvrpWarnings(user_id,source)
	TriggerClientEvent("vrp:recievedRefreshedWarningData",source,vrpwarningstables)
end)

RegisterServerEvent("vrp:warnPlayer")
AddEventHandler("vrp:warnPlayer",function(target_id,warningReason)
	local source = source
	local user_id = vRP.getUserId(source)
        local adminName = GetPlayerName(source)
	if vRP.hasPermission(user_id,"admin.warn") then
		warning = "Warning"
		warningDate = getCurrentDate()
		exports['sql']:execute("INSERT INTO vrp_warnings (`user_id`, `warning_type`, `duration`, `admin`, `warning_date`, `reason`) VALUES (@user_id, @warning_type, 0, @admin, @warning_date,@reason);", {user_id = target_id,warning_type = warning, admin = adminName, warning_date = warningDate, reason = warningReason}, function() end)
	else
		vRPclient.notify(player,{"~r~No perms to warn player"})
	end
end)

function vRP.GiveWarning(target_id, adminName, warningReason)
	local warning = "Warning"
	local warningDate = getCurrentDate()
	exports['sql']:execute("INSERT INTO vrp_warnings (`user_id`, `warning_type`, `duration`, `admin`, `warning_date`, `reason`) VALUES (@user_id, @warning_type, 0, @admin, @warning_date,@reason);", {user_id = target_id,warning_type = warning, admin = adminName, warning_date = warningDate, reason = warningReason}, function() end)
end

RegisterServerEvent("vrp:removewarningPlayer")
AddEventHandler("vrp:removewarningPlayer",function(target_id,warningID)
	local source = source
	local user_id = vRP.getUserId(source)
        local adminName = GetPlayerName(source)
	if vRP.hasPermission(user_id,"admin.removewarn") then
		warning = "Warning"
		warningDate = getCurrentDate()
		exports['sql']:execute("INSERT INTO vrp_warnings (`user_id`, `warning_type`, `duration`, `admin`, `warning_date`, `reason`) VALUES (@user_id, @warning_type, 0, @admin, @warning_date,@reason);", {user_id = target_id,warning_type = warning, admin = adminName, warning_date = warningDate, reason = warningReason}, function() end)
	else
		vRPclient.notify(player,{"~r~no perms to warn player"})
	end
end)

function saveWarnLog(target_id,adminName,warningReason)
	warning = "Warning"
	warningDate = getCurrentDate()
	exports['sql']:execute("INSERT INTO vrp_warnings (`user_id`, `warning_type`, `duration`, `admin`, `warning_date`, `reason`) VALUES (@user_id, @warning_type, 0, @admin, @warning_date,@reason);", {user_id = target_id,warning_type = warning, admin = adminName, warning_date = warningDate, reason = warningReason}, function() end)
end

RegisterServerEvent("FGS:saveKickLog")
AddEventHandler("FGS:saveKickLog",function(target_id,adminName,warningReason)
	warning = "Kick"
	warningDate = getCurrentDate()
	exports['sql']:execute("INSERT INTO vrp_warnings (`warning_id`, `user_id`, `warning_type`, `duration`, `admin`, `warning_date`, `reason`) VALUES (NULL, @user_id, @warning_type, 0, @admin, @warning_date,@reason);", {user_id = target_id,warning_type = warning, admin = adminName, warning_date = warningDate, reason = warningReason}, function() end)
end)

RegisterServerEvent("FGS:BanPlayerLog")
AddEventHandler("FGS:BanPlayerLog",function(target_id,adminName,warningReason,warning_duration)
	warning = "Ban"
	warningDate = getCurrentDate()
	exports['sql']:execute("INSERT INTO vrp_warnings (`warning_id`, `user_id`, `warning_type`, `duration`, `admin`, `warning_date`, `reason`) VALUES (NULL, @user_id, @warning_type, @duration, @admin, @warning_date,@reason);", {user_id = target_id,warning_type = warning, admin = adminName, duration = warning_duration, warning_date = warningDate, reason = warningReason}, function() end)
end)

function getCurrentDate()
	date = os.date("%Y/%m/%d")
	return date
end
