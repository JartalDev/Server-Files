RegisterServerEvent("CXRP:returnSafe:server")
AddEventHandler("CXRP:returnSafe:server", function(deliveryType, safeReturn)
    local source = source
    local user_id = vRP.getUserId(source)
    if safeReturn then
        local SafeMoney = 4000
        for k, v in pairs(dpdcfg.Safe) do
            if k == deliveryType then
                SafeMoney = v
                break
            end
        end
    else
    end
end)

RegisterServerEvent("CXRP:finishDelivery:server")
AddEventHandler("CXRP:finishDelivery:server", function(deliveryType)
    local source = source
    local user_id = vRP.getUserId(source)
    local delieryMoney = 50000
    for k, v in pairs(dpdcfg.Rewards) do
        if k == deliveryType then
            deliveryMoney = v
            break
        end
    end
    vRP.giveBankMoney(user_id,delieryMoney)
    vRPclient.notify(source,{"Package Delivered, you received £"..tostring(deliveryMoney)})
end)

RegisterServerEvent("CXRP:removeSafeMoney:server")
AddEventHandler("CXRP:removeSafeMoney:server", function(deliveryType)
        local user_id = vRP.getUserId({source})
        local SafeMoney = 4000
            for k, v in pairs(dpdcfg.Safe) do
                if k == deliveryType then
                    SafeMoney = v
                break
            end
        end
    TriggerClientEvent("CXRP:startJob:client", source, deliveryType)
end)
