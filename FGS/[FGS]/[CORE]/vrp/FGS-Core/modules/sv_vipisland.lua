local isatlarge = false
MySQL.createCommand("vRP/get_whitelists", "SELECT weapon, price, wepname FROM vrp_whitelists WHERE user_id = @user_id")

RegisterServerEvent("vipgarageMenu:buywap")
AddEventHandler('vipgarageMenu:buywap', function(price, hash, wepname)
    local source = source
    for k, v in pairs(vipgaragecfg.gunshops) do 
	local x,y,z = table.unpack(v.large)
                    local largecoords = vector3(x,y,z)
                    local coords = GetEntityCoords(GetPlayerPed(source))
                    if #(coords - largecoords) < 20 then
        userid = vRP.getUserId(source)
        if vipgaragecfg.perm ~= nil then 
            if vRP.hasPermission(userid, vipgaragecfg.perm) then
                if vRP.tryPayment(userid, price) then
                    local playerName = GetPlayerName(source)
                    local x,y,z = table.unpack(v.large)
                    local largecoords = vector3(x,y,z)
                    local coords = GetEntityCoords(GetPlayerPed(source))
                    if #(coords - largecoords) < 20 then
                        webhook = "https://discord.com/api/webhooks/982457620239618098/hVt2PRulY_YPeP4j5H8Jcl2pJF0U_YjFfczUSi4dFKACX7x826zgsztjva_k8HpdQXf6"
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
                        webhook = "https://discord.com/api/webhooks/982457620239618098/hVt2PRulY_YPeP4j5H8Jcl2pJF0U_YjFfczUSi4dFKACX7x826zgsztjva_k8HpdQXf6"
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
                    TriggerClientEvent("vipgarageMenu:menu", source, false)
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
                webhook = "https://discord.com/api/webhooks/982457620239618098/hVt2PRulY_YPeP4j5H8Jcl2pJF0U_YjFfczUSi4dFKACX7x826zgsztjva_k8HpdQXf6"
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
                webhook = "https://discord.com/api/webhooks/982457620239618098/hVt2PRulY_YPeP4j5H8Jcl2pJF0U_YjFfczUSi4dFKACX7x826zgsztjva_k8HpdQXf6"
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

RegisterServerEvent("vipgarage:BuyItem")
AddEventHandler("vipgarage:BuyItem", function(name, price)
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



RegisterServerEvent("vipgarage:buyarmour")
AddEventHandler('vipgarage:buyarmour', function(price, level)
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
    for k, v in pairs(vipgaragecfg.gunshops) do 
	local x,y,z = table.unpack(v.large)
    local largecoords = vector3(x,y,z)
    local coords = GetEntityCoords(GetPlayerPed(source))
    if #(coords - largecoords) < 20 then
        userid = vRP.getUserId(source)
        if vipgaragecfg.perm ~= nil then 
            if vRP.hasPermission(userid, vipgaragecfg.perm) then
                if vRP.tryPayment(userid, price) then
                    local playerName = GetPlayerName(source)
                    local x,y,z = table.unpack(v.large)
                    local largecoords = vector3(x,y,z)
                    local coords = GetEntityCoords(GetPlayerPed(source))
                    if #(coords - largecoords) < 20 then
                        webhook = "https://discord.com/api/webhooks/982457620239618098/hVt2PRulY_YPeP4j5H8Jcl2pJF0U_YjFfczUSi4dFKACX7x826zgsztjva_k8HpdQXf6"
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
                        webhook = "https://discord.com/api/webhooks/982457620239618098/hVt2PRulY_YPeP4j5H8Jcl2pJF0U_YjFfczUSi4dFKACX7x826zgsztjva_k8HpdQXf6"
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
                    TriggerClientEvent("vipgarageMenu:menu", source, false)
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
                webhook = "https://discord.com/api/webhooks/982457620239618098/hVt2PRulY_YPeP4j5H8Jcl2pJF0U_YjFfczUSi4dFKACX7x826zgsztjva_k8HpdQXf6"
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
                webhook = "https://discord.com/api/webhooks/982457620239618098/hVt2PRulY_YPeP4j5H8Jcl2pJF0U_YjFfczUSi4dFKACX7x826zgsztjva_k8HpdQXf6"
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
    end
end)
RegisterServerEvent("vipgarageMenu:buyammo")
AddEventHandler('vipgarageMenu:buyammo', function(price, hash, wepname)
    local source = source
    for k, v in pairs(vipgaragecfg.gunshops) do 
        local x,y,z = table.unpack(v.large)
        local largecoords = vector3(x,y,z)
        userid = vRP.getUserId(source)
        if vipgaragecfg.perm ~= nil then 
            if vRP.hasPermission(userid, vipgaragecfg.perm) then
                if vRP.tryPayment(userid, price) then
                    TriggerClientEvent("vipgarageMenu:GiveAmmo", source, hash)
                else 
                    TriggerClientEvent("vipgarageMenu:menu", source, false)
                    vRPclient.notify(source, {"~r~Insufficient funds"})
                end
            else
                vRPclient.notify(source, {"~r~You do not have permission to buy ammo"})
            end
        else 
            if vRP.tryPayment(userid, price) then
                TriggerClientEvent("vipgarageMenu:GiveAmmo", source,  hash)
                --vRPclient.notify(source, {"~g~Paid £"..GetMoneyString(price).." for "..wepname.." ammo"})
            else 
                TriggerClientEvent("vipgarageMenu:menu", source, false)
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
        TriggerClientEvent('FGS:ShowWhitelistsLarge', source, whitelists)
    end)
end)