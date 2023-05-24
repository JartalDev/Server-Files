RegisterNetEvent('FGS:HeroinTrader')
AddEventHandler('FGS:HeroinTrader', function(amount)
    local source = source
    local user_id = vRP.getUserId(source)
    local amount = tonumber(amount)
    if vRP.tryGetInventoryItem(user_id, "heroin", amount, true) then
        vRP.giveMoney(user_id, amount * heroincfg.sellprice)
        vRPclient.notify(source, {'~g~Sold ' .. amount .. ' Heroin for £' ..  GetMoneyString(amount * heroincfg.sellprice)})
    else
        vRPclient.notify(source, {'~r~You dont have any heroin to sell'})
    end
end)