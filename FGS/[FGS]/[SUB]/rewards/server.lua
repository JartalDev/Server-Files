local timecache,collecting = {},{}
local Tunnel = module('vrp', 'lib/Tunnel')
local Proxy = module('vrp', 'lib/Proxy')
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "rewards")

Citizen.CreateThread(function()
	Wait(2500)
	exports.sql:execute("SELECT user_id,next_collect FROM `daily_free`",{},function(data)
		for k,v in ipairs(data) do
			timecache[v.user_id]=v.next_collect
		end
	end)
end)

function copyTbl(obj) -- why? because lua is kinda cancer with table copying
	if type(obj) ~= 'table' then return obj end
	local res = {}
	for k, v in pairs(obj) do res[copyTbl(k)] = copyTbl(v) end
	return res
end

RegisterServerEvent("free:updateTimeout")
AddEventHandler("free:updateTimeout", function()
	local _source = source
	local user_id = vRP.getUserId({_source})
	if not user_id then return end
	local now = os.time()
	if timecache[user_id] then
		TriggerClientEvent("free:setTimeout", _source, timecache[user_id])
	else
		exports.sql:execute('SELECT `next_collect` FROM `daily_free` WHERE `user_id`=@user_id;', {['@user_id'] = user_id}, function(collect)
			if collect[1] then
				TriggerClientEvent("free:setTimeout", _source, collect[1].next_collect)
				timecache[user_id] = collect[1].next_collect
			else
				TriggerClientEvent("free:setTimeout", _source, 0)
				timecache[user_id] = 0
			end
		end)
	end
end)

RegisterServerEvent("free:collect")
AddEventHandler("free:collect", function(t)
	local _source = source
	if collecting[_source] then return end
	collecting[_source]=true -- small cache, this fixes dupe bug
	local user_id = vRP.getUserId({_source})
	local now = os.time()
	local nextcollect = os.time() + 86399
	if timecache[user_id] then -- if the time is cached just check that first to make things faster
		if timecache[user_id] > now then
			TriggerClientEvent("free:setTimeout", _source, timecache[user_id])
			TriggerClientEvent("chat:addMessage", _source, {color={255,0,0}, multiline=false, args={"Daily Free", "It's still not time..."}})
			collecting[_source]=nil
			return
		end
	end
	exports.sql:execute('SELECT * FROM `daily_free` WHERE `user_id`=@user_id;', {['@user_id'] = user_id}, function(collect)
		if collect[1] then
			if collect[1].next_collect < now then
				vRP.giveBankMoney({user_id, 250000})
				vRPclient.notify(_source, {"~g~You claimed your daily reward"})
				TriggerClientEvent("free:toggleFreeMenu", _source, false)
				exports.sql:execute('UPDATE `daily_free` SET `next_collect`=@nextcollect,`times_collected`=@timescollected WHERE `user_id`=@user_id', {["@user_id"] = user_id, ["@nextcollect"] = nextcollect, ["@timescollected"] = collect[1].times_collected+1}, nil)
				TriggerClientEvent("free:setTimeout", _source, nextcollect)
			else
				TriggerClientEvent("free:setTimeout", _source, collect[1].next_collect)
				TriggerClientEvent("chat:addMessage", _source, {color={255,0,0}, multiline=false, args={"Daily Free", "It's still not time..."}})
			end
		else
			vRP.giveBankMoney({user_id, 250000})
			vRPclient.notify(_source, {"~g~You claimed your daily reward"})
			TriggerClientEvent("free:setTimeout", _source, nextcollect)
			TriggerClientEvent("free:toggleFreeMenu", _source, false)
			exports.sql:execute('INSERT INTO `daily_free` (`user_id`, `next_collect`, `times_collected`) VALUES (@user_id, @nextcollect, 1);', {['@user_id'] = user_id, ['@nextcollect'] = nextcollect}, nil)
		end
	end)
	collecting[_source]=nil
end)

RegisterCommand("daily", function(source, args, rawCommand)
	TriggerClientEvent("free:toggleFreeMenu", source, true)
end, false)