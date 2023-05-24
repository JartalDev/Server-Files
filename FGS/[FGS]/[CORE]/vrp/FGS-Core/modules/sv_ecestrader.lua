RegisterNetEvent('FGS:EcstasyTrader')
AddEventHandler('FGS:EcstasyTrader', function(amount)
    local source = source
    local user_id = vRP.getUserId(source)
    local amount = tonumber(amount)
    if vRP.tryGetInventoryItem(user_id, "ecstasy", amount, true) then
        vRP.giveMoney(user_id, amount * ecstasycfg.sellprice)
        vRPclient.notify(source, {'~g~Sold ' .. amount .. ' Ecstasy for £' ..  GetMoneyString(amount * ecstasycfg.sellprice)})
    else
        vRPclient.notify(source, {'~r~You dont have any Ecstasy to sell'})
    end
end)