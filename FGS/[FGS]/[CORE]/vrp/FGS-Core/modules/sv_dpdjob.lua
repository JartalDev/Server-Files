-- Return safe deposit event
RegisterServerEvent('vrp_deliveries:returnSafe:server')
AddEventHandler('vrp_deliveries:returnSafe:server', function(deliveryType, safeReturn)
	local user_id = vRP.getUserId(source)
	if safeReturn then
		local SafeMoney = 4000
		for k, v in pairs(dpdcfg.Safe) do
			if k == deliveryType then
				SafeMoney = v
				break
			end
		end
		vRP.giveBankMoney(user_id,SafeMoney)
		vRPclient.notify(source,{"The safe deposit return to your bank account now"})
	else
		vRPclient.notify(source,{"Mission ~r~failed~w~, your safe deposit has been ~r~detain~w~."})
	end
end)

-- Finish delivery mission event
RegisterServerEvent('vrp_deliveries:finishDelivery:server')
AddEventHandler('vrp_deliveries:finishDelivery:server', function(deliveryType)
	local user_id = vRP.getUserId(source)
	local deliveryMoney = 800
	for k, v in pairs(dpdcfg.Rewards) do
		if k == deliveryType then
			deliveryMoney = v
			break
		end
	end
	vRP.giveMoney(user_id,deliveryMoney)
	vRPclient.notify(source,{"Shift complete, you received ~g~£"..tostring(deliveryMoney)})
end)

-- Remove safe deposit event (On start mission)
RegisterServerEvent('vrp_deliveries:removeSafeMoney:server')
AddEventHandler('vrp_deliveries:removeSafeMoney:server', function(deliveryType)
    local user_id = vRP.getUserId(source)
	local SafeMoney = 4000
	for k, v in pairs(dpdcfg.Safe) do
		if k == deliveryType then
			SafeMoney = v
			break
		end
	end
	local PlayerMoney = vRP.getBankMoney(user_id)
	if PlayerMoney >= SafeMoney then
		vRP.tryBankPayment(user_id,SafeMoney)
		vRPclient.notify(source,{"The safe deposit has been remove from your bank account"})
		TriggerClientEvent('vrp_deliveries:startJob:client', source, deliveryType)
	else
		vRPclient.notify(source,{"You do not enough bank money to pay the ~r~safe deposit~s~"})
	end
end)