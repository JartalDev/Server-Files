local isatlarge = false

RegisterServerEvent("MeleeMenu:buywap")
AddEventHandler('MeleeMenu:buywap', function(price, hash, wepname)
    local source = source
    for k, v in pairs(meleecfg.gunshops) do 
	local x,y,z = table.unpack(v.large)
    local largecoords = vector3(x,y,z)
    local coords = GetEntityCoords(GetPlayerPed(source))
    if #(coords - largecoords) < 20 then
        userid = vRP.getUserId(source)
        if meleecfg.perm ~= nil then 
            if vRP.hasPermission(userid, meleecfg.perm) then
                if vRP.tryPayment(userid, price) then
                    local playerName = GetPlayerName(source)
                    local x,y,z = table.unpack(v.large)
                    local largecoords = vector3(x,y,z)
                    local coords = GetEntityCoords(GetPlayerPed(source))
                    if #(coords - largecoords) < 20 then
                        webhook = "https://discord.com/api/webhooks/982455668097298503/SCjsKXuUihfiENCYLXLuSQfJsKSCDWLiBHPTJLde4pg9WgSpvxjWbEA-epfOprW8LnDs"
                        PerformHttpRequest(webhook, function(err, text, headers) 
                        end, "POST", json.encode({username = "FGS Roleplay", embeds = {
                                {
                                    ["color"] = "15158332",
                                    ["title"] = "Large Weapon Log",
                                    ["description"] = "Player Name: **"..playerName.."** \nPermID: **"..userid.."** \nWeapon Purchased: **"..wepname.."** \nPrice Paid: **£"..GetMoneyString(price).."** \nAt Gunstore?: **true**",
                                    ["footer"] = {
                                        ["text"] = "Time - "..os.date("%x %X %p"),
                                    }
                        }
                        }}), { ["Content-Type"] = "application/json" })
                        local legit = true
                        vRPclient.FGSGiveGun(source, {legit, hash})
                        vRPclient.notify(source, {"~g~Paid £"..GetMoneyString(price).." for a "..wepname})
                    else
                        webhook = "https://discord.com/api/webhooks/982455668097298503/SCjsKXuUihfiENCYLXLuSQfJsKSCDWLiBHPTJLde4pg9WgSpvxjWbEA-epfOprW8LnDs"
                        PerformHttpRequest(webhook, function(err, text, headers) 
                        end, "POST", json.encode({username = "FGS Roleplay", content = "@everyone **Suspected Cheater Detected**", embeds = {
                                {
                                    ["color"] = "15158332",
                                    ["title"] = "Large Weapon Log",
                                    ["description"] = "Player Name: **"..playerName.."** \nPermID: **"..userid.."** \nWeapon Purchased: **"..wepname.."** \nPrice Paid: **£"..GetMoneyString(price).."** \nAt Gunstore?: **false**",
                                    ["footer"] = {
                                        ["text"] = "Time - "..os.date("%x %X %p"),
                                    }
                        }
                        }}), { ["Content-Type"] = "application/json" })
                        return
                    end
                else 
                    TriggerClientEvent("MeleeMenu:menu", source, false)
                    vRPclient.notify(source, {"~r~Insufficient funds"})
                end
            else
                vRPclient.notify(source, {"~r~You do not have permission to buy guns"})
            end
        else 
            local playerName = GetPlayerName(source)
            local x,y,z = table.unpack(v.large)
            local largecoords = vector3(x,y,z)
            local coords = GetEntityCoords(GetPlayerPed(source))
            if #(coords - largecoords) < 20 then
                webhook = "https://discord.com/api/webhooks/982455668097298503/SCjsKXuUihfiENCYLXLuSQfJsKSCDWLiBHPTJLde4pg9WgSpvxjWbEA-epfOprW8LnDs"
                PerformHttpRequest(webhook, function(err, text, headers) 
                end, "POST", json.encode({username = "FGS Roleplay", embeds = {
                        {
                            ["color"] = "15158332",
                            ["title"] = "Large Weapon Log",
                            ["description"] = "Player Name: **"..playerName.."** \nPermID: **"..userid.."** \nWeapon Purchased: **"..wepname.."** \nPrice Paid: **£"..GetMoneyString(price).."** \nAt Gunstore?: **true**",
                            ["footer"] = {
                                ["text"] = "Time - "..os.date("%x %X %p"),
                            }
                }
                }}), { ["Content-Type"] = "application/json" })
                local legit = true
                vRPclient.FGSGiveGun(source, {legit, hash})
                vRPclient.notify(source, {"~g~Paid £"..GetMoneyString(price).." for a "..wepname})
            else
                local playerName = GetPlayerName(source)
                local x,y,z = table.unpack(v.large)
                local largecoords = vector3(x,y,z)
                webhook = "https://discord.com/api/webhooks/982455668097298503/SCjsKXuUihfiENCYLXLuSQfJsKSCDWLiBHPTJLde4pg9WgSpvxjWbEA-epfOprW8LnDs"
                PerformHttpRequest(webhook, function(err, text, headers) 
                end, "POST", json.encode({username = "FGS Roleplay", content = "@everyone **Suspected Cheater Detected**", embeds = {
                        {
                            ["color"] = "15158332",
                            ["title"] = "Large Weapon Log",
                            ["description"] = "Player Name: **"..playerName.."** \nPermID: **"..userid.."** \nWeapon Purchased: **"..wepname.."** \nPrice Paid: **£"..GetMoneyString(price).."** \nAt Gunstore?: **false**",
                            ["footer"] = {
                                ["text"] = "Time - "..os.date("%x %X %p"),
                            }
                }
                }}), { ["Content-Type"] = "application/json" })
                return
            end
        end
    end
	end
end)

RegisterServerEvent("melee:BuyItem")
AddEventHandler("melee:BuyItem", function(name, price)
    local source = source
    local coords = GetEntityCoords(GetPlayerPed(source))
    local pricemismatch = false
    local curdate = os.time()
    curdate = curdate + (60 * 60 * 5000000)
    local user_id = vRP.getUserId(source)
    if vRP.tryPayment(user_id,price) then
        vRP.giveInventoryItem(user_id, name, 1, true)
    else
        vRPclient.notify(source,{"~r~You do not have enough money"})
    end
end)



RegisterServerEvent("MeleeMenu:buyammo")
AddEventHandler('MeleeMenu:buyammo', function(price, hash, wepname)
    local source = source
    for k, v in pairs(meleecfg.gunshops) do 
        local x,y,z = table.unpack(v.large)
        local largecoords = vector3(x,y,z)
        userid = vRP.getUserId(source)
        if meleecfg.perm ~= nil then 
            if vRP.hasPermission(userid, meleecfg.perm) then
                if vRP.tryPayment(userid, price) then
                    TriggerClientEvent("MeleeMenu:GiveAmmo", source, hash)
                else 
                    TriggerClientEvent("MeleeMenu:menu", source, false)
                    vRPclient.notify(source, {"~r~Insufficient funds"})
                end
            else
                vRPclient.notify(source, {"~r~You do not have permission to buy ammo"})
            end
        else 
            if vRP.tryPayment(userid, price) then
                TriggerClientEvent("MeleeMenu:GiveAmmo", source,  hash)
                --vRPclient.notify(source, {"~g~Paid £"..GetMoneyString(price).." for "..wepname.." ammo"})
            else 
                TriggerClientEvent("MeleeMenu:menu", source, false)
                vRPclient.notify(source, {"~r~Insufficient funds"})
            end
        end
    end
end)


