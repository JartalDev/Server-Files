RegisterNetEvent('FGS:WeedTrader')
AddEventHandler('FGS:WeedTrader', function(amount)
    local source = source
    local user_id = vRP.getUserId(source)
    local amount = tonumber(amount)
    if vRP.tryGetInventoryItem(user_id, "weed", amount, true) then
        vRP.giveMoney(user_id, amount * weedcfg.sellprice)
        vRPclient.notify(source, {'~g~Sold ' .. amount .. ' Weed for £' ..  GetMoneyString(amount * weedcfg.sellprice)})
    else
        vRPclient.notify(source, {'~r~You dont have any Weed to sell'})
    end
end)