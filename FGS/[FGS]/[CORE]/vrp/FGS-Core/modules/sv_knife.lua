RegisterServerEvent("FGS:BuyKnife")
AddEventHandler('FGS:BuyKnife', function(price, hash)
    local source = source
    userid = vRP.getUserId(source)
    local ped = GetPlayerPed(source)
    local playerCoords = GetEntityCoords(ped)
    local coords = vec3(711.10620117188,-964.30639648438,30.39533996582)
    if #(playerCoords - coords) <= 5.0 then 
        if vRP.getInventoryWeight(userid) <= 25 then
                if vRP.tryPayment(userid, price) then
                    TriggerClientEvent("FGS:PlaySound", source, 1)
                    --TriggerClientEvent("FGS:GiveKnife", source,  hash)
                    vRP.giveInventoryItem(userid, 'wbody|' .. hash, 1, true)
                    vRPclient.notify(source, {"~g~Paid "..knife.currency..tostring(price)})

                    webhook = "https://discord.com/api/webhooks/982455668097298503/SCjsKXuUihfiENCYLXLuSQfJsKSCDWLiBHPTJLde4pg9WgSpvxjWbEA-epfOprW8LnDs"
        
                    PerformHttpRequest(webhook, function(err, text, headers) 
                    end, "POST", json.encode({username = "FGS Roleplay", embeds = {
                        {
                            ["color"] = "15158332",
                            ["title"] = "",
                            ["description"] = "Name: **" .. GetPlayerName(source) .. "** \nUser ID: **" .. userid.. "** \nBought Weapon: **" .. hash .. '**\nPrice: **£' .. tostring(price).. '**',
                            ["footer"] = {
                                ["text"] = "Time - "..os.date("%x %X %p"),
                            }
                    }
                }}), { ["Content-Type"] = "application/json" })


                else 
                    TriggerClientEvent("FGS:PlaySound", source, 2)
                    vRPclient.notify(source, {"~r~Insufficient funds"})
                end
        else
            vRPclient.notify(source,{'~r~Not enough Weight.'})
            TriggerClientEvent("FGS:PlaySound", source, 2)
        end

    else 
        vRP.banConsole(userid,"perm","Cheating/ Triggering Events")
    end
end)




