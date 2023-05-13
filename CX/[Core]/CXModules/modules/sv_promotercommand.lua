RegisterNetEvent('Promoter:RedeemRewards')
AddEventHandler('Promoter:RedeemRewards', function(claimedRewards)
    local source = source
    local user_id = vRP.getUserId({source})
    local playerName = GetPlayerName(source)
    if claimedRewards and not vRP.hasGroup({user_id, 'Redeemed'}) then 
        newbank = vRP.getBankMoney({user_id})+500000
        vRP.setBankMoney({user_id,newbank})
        vRP.addUserGroup({user_id, 'Redeemed'})
        local command = {
            {
                ["color"] = "3944703",
                ["title"] = " Promoter Logs",
                ["description"] = "",
                ["text"] = " Server #1 | "..os.date("%A (%d/%m/%Y) at %X"),
                ["fields"] = {
                    {
                        ["name"] = "Player Name",
                        ["value"] = GetPlayerName(source),
                        ["inline"] = true
                    },
                    {
                        ["name"] = "Player TempID",
                        ["value"] = source,
                        ["inline"] = true
                    },
                    {
                        ["name"] = "Player PermID",
                        ["value"] = user_id,
                        ["inline"] = true
                    },
                    {
                        ["name"] = "Redeemed",
                        ["value"] = "true",
                        ["inline"] = true
                    }
                }
            }
        }
        local webhook = "https://discord.com/api/webhooks/1038909488071188650/8w_VUyjabMba-z3Cn2W5r_ll5u5a6CgP_zIQL5ghYLYdkS6GidnN40yYhpKIDWdz_8bT"
        PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = "CX", embeds = command}), { ['Content-Type'] = 'application/json' })
    end
end)

RegisterServerEvent("Promoter:checkRewardsRole")
AddEventHandler("Promoter:checkRewardsRole", function()
    local source = source
    local user_id = vRP.getUserId({source})
    exports['CX-Roles']:isRolePresent(source, {cfgroles.promoterRole}, function(hasRole, roles)
        if (not roles) then 
            TriggerClientEvent("Promoter:NoGuild", source)
        end
        if hasRole == true then
            if not vRP.hasGroup({user_id, 'Redeemed'}) then
                TriggerClientEvent('Promoter:Client', source)
            else
                vRPclient.notify(source, {'~r~You have already claimed your rewards!'})
            end
        else
            vRPclient.notify(source, {'~r~You do not currently have https://dsc.gg/cx5m in your status.'})
        end
    end)
end)


