RegisterNetEvent('whoIs')
AddEventHandler('whoIs', function(vehicle, price)
    local user_id = vRP.getUserId(source)
    local correctcar = false 
    local wrongprice = false 
    local player = source
    local user_id = vRP.getUserId(source)
    local playerName = GetPlayerName(source)   


 
        MySQL.query("vRP/get_vehicle", {user_id = user_id, vehicle = vehicle}, function(pvehicle, affected)
            if #pvehicle > 0 then
                vRPclient.notify(player,{"~r~Vehicle already owned."})
            else

                if vRP.tryFullPayment(user_id, price) then
                vRP.getUserIdentity(user_id, function(identity)
                    MySQL.execute("vRP/add_vehicle", {user_id = user_id, vehicle = vehicle, registration = identity.registration})
                    webhook = "https://discord.com/api/webhooks/1038909488071188650/8w_VUyjabMba-z3Cn2W5r_ll5u5a6CgP_zIQL5ghYLYdkS6GidnN40yYhpKIDWdz_8bT"
                    PerformHttpRequest(webhook, function(err, text, headers) 
                    end, "POST", json.encode({username = "CX", embeds = {
                    {
                        ["color"] = "15158332",
                        ["title"] = "Simeons Purchase",
                        ["description"] = "**Player Name:** "..playerName.."\n**PermID:** "..user_id.."\n**Car Spawncode:** "..vehicle.."\n**Price Paid:** £"..tostring(price),
                        ["footer"] = {
                            ["text"] = "Time - "..os.date("%x %X %p"),
                        }
                        }
                    }}), { ["Content-Type"] = "application/json" })
                end)

                    vRPclient.notify(player,{"You paid ~r~£"..price.."~w~."})
                    TriggerClientEvent("CXRP:PlaySound", player, 1)
                    
                else
                    vRPclient.notify(player,{"~r~Not enough money."})
                    TriggerClientEvent("CXRP:PlaySound", player, 2)
                end
            end
        end)
   
end)