RegisterNetEvent('FGS:cokecainTrader')
AddEventHandler('FGS:cokecainTrader', function(amount)
    local source = source
    local user_id = vRP.getUserId(source)
    local amount = tonumber(amount)
    if vRP.tryGetInventoryItem(user_id, "coke", amount, true) then
        vRP.giveBankMoney(user_id, amount * cokecaincfg.sellprice)
        vRPclient.notify(source, {'~g~Sold ' .. amount .. ' Cocaine for £' ..  GetMoneyString(amount * cokecaincfg.sellprice)})
    else
        vRPclient.notify(source, {'~r~You dont have any Cocaine to sell'})
    end
end)