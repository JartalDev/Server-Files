--[[
function giveChips(source,amount)
    local user_id = vRP.getUserId({source})
    local rows = exports['sql']:executeSync("SELECT chips FROM casino WHERE user_id = @user_id", {user_id = user_id})
    local chips = rows[1].chips
    exports['sql']:executeSync("UPDATE casino SET chips = @chips WHERE user_id = @user_id", {chips = chips + amount, user_id = user_id})
    return true
end

]]
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
local vRP = Proxy.getInterface("vRP")

function buyChips(amount)
    local source = source
    local user_id = vRP.getUserId({source})
    local rows = exports['sql']:executeSync("SELECT chips FROM casino WHERE user_id = @user_id", {user_id = user_id})
    local chips = rows[1].chips
    if vRP.tryPayment({user_id, tonumber(amount)}) then
        exports['sql']:executeSync("UPDATE casino SET chips = @chips WHERE user_id = @user_id", {chips = chips + tonumber(amount), user_id = user_id})
        return true
    else
        return false
    end
end

function sellChips(amount)
    local source = source
    local user_id = vRP.getUserId({source})
    local rows = exports['sql']:executeSync("SELECT chips FROM casino WHERE user_id = @user_id", {user_id = user_id})
    local chips = rows[1].chips
    if chips >= tonumber(amount) then
        exports['sql']:executeSync("UPDATE casino SET chips = @chips WHERE user_id = @user_id", {chips = chips - tonumber(amount), user_id = user_id})
        vRP.giveMoney({user_id, tonumber(amount)})
        return true
    else
        return false
    end
end

RegisterNetEvent("casino:buyChips", function(amount)
    local source = source
    if buyChips(amount) then
        TriggerClientEvent("blackjack:notify",source,"~g~You bought ~g~"..amount.." ~g~chips.")
    else
        TriggerClientEvent("blackjack:notify",source,"~r~You don't have enough money.")
    end
end)

RegisterNetEvent("casino:sellChips", function(amount)
    local source = source
    if sellChips(amount) then
        TriggerClientEvent("blackjack:notify",source,"~g~You sold ~g~"..amount.." ~g~chips.")
    else
        TriggerClientEvent("blackjack:notify",source,"~r~You don't have enough chips.")
    end
end)