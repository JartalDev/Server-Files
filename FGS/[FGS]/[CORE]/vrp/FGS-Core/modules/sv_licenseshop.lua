RegisterServerEvent("LicenseCentre:BuyGroup")
AddEventHandler('LicenseCentre:BuyGroup', function(price, job)
    local source = source
    local user_id = vRP.getUserId(source)
    local group = licensecfg.licenses.drugs[job]
    if group then 
        if group.price == price then 
            if vRP.hasGroup(user_id, job) then 
                vRPclient.notify(source, {"~r~You have already purchased this license!"})
            else
                if vRP.tryPayment(user_id, price) then
                    vRP.addUserGroup(user_id,job)
                    vRPclient.notify(source, {"~g~Purchased " .. group.name .. " for "..licensecfg.currency..tostring(group.shownprice)})
                else 
                    vRPclient.notify(source, {"~r~Insufficient funds"})
                end
            end
        else
            -- oh no cheater insert ban logic here.
        end
    end
end)

RegisterServerEvent("LicenseCentre:BuyGunGroup")
AddEventHandler('LicenseCentre:BuyGunGroup', function(price, job)
    local source = source
    local user_id = vRP.getUserId(source)
    local group = licensecfg.licenses.guns[job]
    if group then 
        if group.price == price then 
            if vRP.hasGroup(user_id, job) then 
                vRPclient.notify(source, {"~r~You have already purchased this license!"})
            else
                if vRP.tryPayment(user_id, price) then
                    vRP.addUserGroup(user_id,job)
                    vRPclient.notify(source, {"~g~Purchased " .. group.name .. " License for "..licensecfg.currency..tostring(group.shownprice)})
                else 
                    vRPclient.notify(source, {"~r~Insufficient funds"})
                end
            end
        else
            -- oh no cheater insert ban logic here.
        end
    end
end)