RegisterNetEvent('FGS:methTrader')
AddEventHandler('FGS:methTrader', function(amount)
    local source = source
    local user_id = vRP.getUserId(source)
    local amount = tonumber(amount)
    if vRP.tryGetInventoryItem(user_id, "meth", amount, true) then
        vRP.giveMoney(user_id, amount * methcfg.sellprice)
        vRPclient.notify(source, {'~g~Sold ' .. amount .. ' Meth for £' ..  GetMoneyString(amount * methcfg.sellprice)})
    else
        vRPclient.notify(source, {'~r~You dont have any meth to sell'})
    end
end)