RegisterNetEvent('FGS:DiamondTrader')
AddEventHandler('FGS:DiamondTrader', function(amount)
    local source = source
    local user_id = vRP.getUserId(source)
    local amount = tonumber(amount)
    if vRP.tryGetInventoryItem(user_id, "diamond", amount, true) then
        vRP.giveBankMoney(user_id, amount * diamondcfg.sellprice)
        vRPclient.notify(source, {'~g~Sold ' .. amount .. ' Diamond for £' ..  GetMoneyString(amount * diamondcfg.sellprice)})
    else
        vRPclient.notify(source, {'~r~You dont have any Diamond to sell'})
    end
end)