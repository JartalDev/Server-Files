local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
local vRP = Proxy.getInterface("vRP")


function buyHighrollers()
    local source = source
    local user_id = vRP.getUserId({source})
    local rows = exports['sql']:executeSync("SELECT highrollers FROM casino WHERE user_id = @user_id", {user_id = user_id})
    local highrollers = rows[1].highrollers
    local highrollers = tonumber(highrollers)
    --if high rollers = 1 then
    if highrollers == 0 then
        if vRP.tryPayment({user_id, 10000000}) then
            exports['sql']:executeSync("UPDATE casino SET highrollers = @highrollers WHERE user_id = @user_id", {highrollers = 1, user_id = user_id})
            TriggerClientEvent("blackjack:notify",source,"~g~You bought ~g~Highrollers.")
        else
            TriggerClientEvent("blackjack:notify",source,"~r~You don't have enough money.")
        end
    else
        TriggerClientEvent("blackjack:notify",source,"~r~You already have highrollers.")
    end

end


RegisterNetEvent('casino:buyHighrollers', function()
    local source = source
    buyHighrollers()
end)