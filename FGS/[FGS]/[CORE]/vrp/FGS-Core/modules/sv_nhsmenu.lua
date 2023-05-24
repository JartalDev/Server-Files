local lang = vRP.lang

RegisterServerEvent('FGS:OpenNHSMenu')
AddEventHandler('FGS:OpenNHSMenu', function()
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id ~= nil and vRP.hasPermission(user_id, "nhs.menu") then
        TriggerClientEvent("FGS:NHSMenuOpened", source)
    elseif user_id ~= nil and vRP.hasPermission(user_id, "clockon.nhs") then
      vRPclient.notify(source,{"You are not on duty"})
    else
        print("You are not a part of the NHS")
    end
end)

local revive_seq = {
    {"mini@cpr@char_a@cpr_str@enter", "enter", 2},
    {"mini@cpr@char_a@cpr_str@exit", "exit", 1}
}

RegisterServerEvent('FGS:PerformCPR')
AddEventHandler('FGS:PerformCPR', function()
    local player = source
    local user_id = vRP.getUserId(player)
    if user_id ~= nil and vRP.hasPermission(user_id, "nhs.revive") then
        vRPclient.getNearestPlayer(player, {3}, function(nplayer)
            local nuser_id = vRP.getUserId(nplayer)
            if nuser_id ~= nil then
                vRPclient.isInComa(nplayer, {}, function(in_coma)
                    if in_coma then
                        vRPclient.playAnim(player, {false, revive_seq, false}) -- anim
                        SetTimeout(15000, function()
                          TriggerClientEvent('FGS:FixPlayer', nplayer)
                          vRPclient.varyHealth(nplayer, 50) -- heal 50
                          vRPclient.notify(nplayer,{"~g~You have been revived by an NHS Member, free of charge"})
                          vRPclient.notify(player,{"~g~You revived someone, as a reward, here is £4,000 into your bank"})
                          vRP.giveBankMoney(player, 4000)
                        end)
                    else
                        vRPclient.notify(player, {"~r~Player is alive and healthy"})
                    end
                end)
            else
                vRPclient.notify(player, {"~r~There is no player nearby"})
            end
        end)
    end
end)

RegisterServerEvent('FGS:HealPlayer')
AddEventHandler('FGS:HealPlayer', function()
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id ~= nil and vRP.hasPermission(user_id, "nhs.revive") then
        vRPclient.getNearestPlayer(source, {3}, function(nplayer)
            local nuser_id = vRP.getUserId(nplayer)
            if nuser_id ~= nil then
                vRPclient.playAnim(source, {false, revive_seq, false}) -- anim
                SetTimeout(10000, function()
                    TriggerClientEvent('FGS:FixPlayer', nplayer)
                    vRPclient.varyHealth(nplayer, 100) -- heal 100
                    vRPclient.notify(nplayer,{"~g~You have been healed by an NHS Member, free of charge"})
                    vRPclient.notify(source, {"~g~You healed " .. GetPlayerName(nplayer)})
                end)
            else
                vRPclient.notify(player, {"~r~There is no player nearby"})
            end
        end)
    end
end)