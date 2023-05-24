local isatlarge = false
MySQL.createCommand("vRP/get_whitelists", "SELECT weapon, price, wepname, location FROM vrp_whitelists WHERE user_id = @user_id")

RegisterServerEvent("RebelMenu:buywap")
AddEventHandler('RebelMenu:buywap', function(price, hash, wepname)
    local source = source
    for k, v in pairs(rebelcfg.gunshops) do 
        userid = vRP.getUserId(source)
        if rebelcfg.perm ~= nil then 
            if vRP.hasPermission(userid, rebelcfg.perm) then
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
                    TriggerClientEvent("RebelMenu:menu", source, false)
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
end)

RegisterServerEvent("rebel:BuyItem")
AddEventHandler("rebel:BuyItem", function(name, price)
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



RegisterServerEvent("rebel:buyarmour")
AddEventHandler('rebel:buyarmour', function(price, level)
    local source = source
    local coords = GetEntityCoords(GetPlayerPed(source))
    local pricemismatch = false 
    local curdate = os.time()
    curdate = curdate + (60 * 60 * 500000)
    local playerid = vRP.getUserId(source)
    if level == 98 then
        price = 100000
        shownlevel = 100
    else
        shownlevel = level
    end
    for k, v in pairs(rebelcfg.gunshops) do 
        userid = vRP.getUserId(source)
        if rebelcfg.perm ~= nil then 
            if vRP.hasPermission(userid, rebelcfg.perm) then
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
                                ["title"] = "Large Armour Log",
                                ["description"] = "Player Name: **"..playerName.."** \nPermID: **"..userid.."** \nArmour Purchased: **"..level.."%** \nPrice Paid: **£"..GetMoneyString(price).."** \nAt Gunstore?: **true**",
                                ["footer"] = {
                                    ["text"] = "Time - "..os.date("%x %X %p"),
                                }
                        }
                        }}), { ["Content-Type"] = "application/json" })
                        TriggerClientEvent("Larges:givearmour", source, level)
                        vRPclient.notify(source, {"~g~Paid £"..GetMoneyString(price).." for "..shownlevel.."% Armour"})
                    else
                        webhook = "https://discord.com/api/webhooks/982455668097298503/SCjsKXuUihfiENCYLXLuSQfJsKSCDWLiBHPTJLde4pg9WgSpvxjWbEA-epfOprW8LnDs"
                        PerformHttpRequest(webhook, function(err, text, headers) 
                        end, "POST", json.encode({username = "FGS Roleplay", content = "@everyone **Suspected Cheater Detected**", embeds = {
                            {
                                ["color"] = "15158332",
                                ["title"] = "Large Armour Log",
                                ["description"] = "Player Name: **"..playerName.."** \nPermID: **"..userid.."** \nArmour Purchased: **"..level.."%** \nPrice Paid: **£"..GetMoneyString(price).."** \nAt Gunstore?: **false**",
                                ["footer"] = {
                                    ["text"] = "Time - "..os.date("%x %X %p"),
                                }
                        }
                        }}), { ["Content-Type"] = "application/json" })
                        return
                    end
                else 
                    TriggerClientEvent("RebelMenu:menu", source, false)
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
                        ["title"] = "Large Armour Log",
                        ["description"] = "Player Name: **"..playerName.."** \nPermID: **"..userid.."** \nArmour Purchased: **"..level.."%** \nPrice Paid: **£"..GetMoneyString(price).."** \nAt Gunstore?: **true**",
                        ["footer"] = {
                            ["text"] = "Time - "..os.date("%x %X %p"),
                        }
                }
                }}), { ["Content-Type"] = "application/json" })
                TriggerClientEvent("Larges:givearmour", source, level)
                vRPclient.notify(source, {"~g~Paid £"..GetMoneyString(price).." for "..level.."% Armour"})
            else
                local playerName = GetPlayerName(source)
                local x,y,z = table.unpack(v.large)
                local largecoords = vector3(x,y,z)
                webhook = "https://discord.com/api/webhooks/982455668097298503/SCjsKXuUihfiENCYLXLuSQfJsKSCDWLiBHPTJLde4pg9WgSpvxjWbEA-epfOprW8LnDs"
                PerformHttpRequest(webhook, function(err, text, headers) 
                end, "POST", json.encode({username = "FGS Roleplay", content = "@everyone **Suspected Cheater Detected**", embeds = {
                    {
                        ["color"] = "15158332",
                        ["title"] = "Large Armour Log",
                        ["description"] = "Player Name: **"..playerName.."** \nPermID: **"..userid.."** \nArmour Purchased: **"..level.."%** \nPrice Paid: **£"..GetMoneyString(price).."** \nAt Gunstore?: **false**",
                        ["footer"] = {
                            ["text"] = "Time - "..os.date("%x %X %p"),
                        }
                }
                }}), { ["Content-Type"] = "application/json" })
                return
            end
        end
    end
end)



RegisterServerEvent("RebelMenu:buyammo")
AddEventHandler('RebelMenu:buyammo', function(price, hash, wepname)
    local source = source
    for k, v in pairs(rebelcfg.gunshops) do 
        local x,y,z = table.unpack(v.large)
        local largecoords = vector3(x,y,z)
        userid = vRP.getUserId(source)
        if rebelcfg.perm ~= nil then 
            if vRP.hasPermission(userid, rebelcfg.perm) then
                if vRP.tryPayment(userid, price) then
                    TriggerClientEvent("RebelMenu:GiveAmmo", source, hash)
                else 
                    TriggerClientEvent("RebelMenu:menu", source, false)
                    vRPclient.notify(source, {"~r~Insufficient funds"})
                end
            else
                vRPclient.notify(source, {"~r~You do not have permission to buy ammo"})
            end
        else 
            if vRP.tryPayment(userid, price) then
                TriggerClientEvent("RebelMenu:GiveAmmo", source,  hash)
                --vRPclient.notify(source, {"~g~Paid £"..GetMoneyString(price).." for "..wepname.." ammo"})
            else 
                TriggerClientEvent("RebelMenu:menu", source, false)
                vRPclient.notify(source, {"~r~Insufficient funds"})
            end
        end
    end
end)


RegisterServerEvent("FGS:GetWhitelistLarge")
AddEventHandler('FGS:GetWhitelistLarge', function()
    local source = source
    local userid = vRP.getUserId(source)
    local name = GetPlayerName(source)
    local weptable = {}
    local numofwls = 0
    MySQL.query("vRP/get_whitelists", {user_id = userid}, function(whitelists, affected)
        if #whitelists > 0 then 
            local temp = {}
            for k,v in pairs(whitelists) do 
                if v.location == "Rebel" then 
                    table.insert(temp, v)
                end
            end
            TriggerClientEvent('FGS:ShowWhitelistsLarge', source, temp)
        end
    end)
end)