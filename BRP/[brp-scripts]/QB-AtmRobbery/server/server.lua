local QBCore = exports['qb-core']:GetCoreObject()
cooldowntime = Config.Cooldown 

undercd = false

RegisterServerEvent('BRP:CooldownServer')
AddEventHandler('BRP:CooldownServer', function(bool)
    undercd = bool
    if bool then 
        cooldown()
    end	 
end)

RegisterNetEvent('BRP:rewarditem')
AddEventHandler('BRP:rewarditem', function(listKey)
    local src = source 
    local Player = QBCore.Functions.GetPlayer(src)
    local item = Config.Items[math.random(1, #Config.Items)]
            Player.Functions.AddItem(item, math.random(1, 10))
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], 'add')
end)


QBCore.Functions.CreateCallback("BRP:getHackerDevice",function(source,cb)
	local xPlayer = QBCore.Functions.GetPlayer(source)
	if xPlayer.Functions.GetItemByName("laptop") then
		cb(true)
	else
		cb(false)
		TriggerClientEvent('QBCore:Notify', source, "You need a Laptop to proceed")
	end
end)

QBCore.Functions.CreateCallback("BRP:getHardrive",function(source,cb)
	local xPlayer = QBCore.Functions.GetPlayer(source)
	if xPlayer.Functions.GetItemByName("hardrive") then
		cb(true)
	else
		cb(false)
		TriggerClientEvent('QBCore:Notify', source, "You need a Hardrive to proceed")
	end
end)

RegisterServerEvent("BRP:ResetCooldown")
AddEventHandler("BRP:ResetCooldown", function()
    cooldowntime2 = 0
end)


RegisterServerEvent('BRP:CooldownNotify')
AddEventHandler('BRP:CooldownNotify', function()
	TriggerClientEvent("QBCore:Notify",source,"An ATM Robbery has happened Recently. Please Wait "..cooldowntime2.." Minutes!")
end)



RegisterServerEvent('BRP:crypto')
AddEventHandler('BRP:crypto', function()
	local _source = source
	local Player = QBCore.Functions.GetPlayer(_source)
    Player.Functions.AddMoney("crypto", 15, "extracted-crypto")
    TriggerClientEvent("QBCore:Notify", _source, "You extracted 15 Crypto", "success")
    Player.Functions.RemoveItem("hardrive", 1)
    TriggerClientEvent('inventory:client:ItemBox', _source, QBCore.Shared.Items['hardrive'], "remove", 1)
end)

QBCore.Functions.CreateCallback("BRP:GetCooldown",function(source,cb)
	cb(undercd)
end)

function cooldown()
cooldowntime2 = cooldowntime
    while true do 
    Citizen.Wait(60000)

    cooldowntime2 = cooldowntime2 - 1 

    if cooldowntime2 <= 0 then
        undercd = false
        break
    end

  end
  
end

