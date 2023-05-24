local Tunnel = module('vRP', 'lib/Tunnel')
local Proxy = module('vRP', 'lib/Proxy')
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "vRP")

function vRP.addChips(source, value)

end

RegisterServerEvent("buychips:GetAmountofchips")
AddEventHandler(
    "buychips:GetAmountofchips",
    function()
        local player = source
        local user_id = vRP.getUserId({player})
        local amt = 0
        exports['ghmattimysql']:execute("SELECT * FROM btf_casino_tokens WHERE userid = @uid", {uid = user_id}, function(callback) 
            if #callback > 0 then 
                for i = 1, #callback do 
                    amt = callback[1].token
                    TriggerClientEvent("buychips:GotAmountOfChips", player, amt)
                end
            else
                exports["ghmattimysql"]:executeSync("INSERT INTO btf_casino_tokens(userid,token) VALUES(@userid, @token)", {userid = user_id, token = 0})
            end
        end)
    end
)
RegisterServerEvent("buychips:TryChipPayment")
AddEventHandler(
    "buychips:TryChipPayment",
    function(amount)
        local player = source
        local user_id = vRP.getUserId({player}) 
        local amt = 0

        exports['ghmattimysql']:execute("SELECT * FROM btf_casino_tokens WHERE userid = @uid", {uid = user_id}, function(callback) 
            if #callback > 0 then 
                for i = 1, #callback do 
                    print("USER: " ..user_id) 
                    print("CHIPS: " ..callback[i].token)
                    print("NEW CHIPS: " ..callback[i].token + amount)
                    amt = callback[i].token

                    if tonumber(amount) > 0 then
                        if vRP.tryPayment({user_id, tonumber(amount)}) then 
                            exports['ghmattimysql']:execute("UPDATE btf_casino_tokens SET token = @balance WHERE userid = @owner", {balance = amt + tonumber(amount) , owner = user_id }, function() end)
                            vRPclient.notify(player, {"~g~Bought " .. amount .. " chips"})
                            TriggerClientEvent("buychips:updatehud+", player, amount)
                        else
                            vRPclient.notify(player, {"~r~Not enough cash"})
                        end
                    else
                        vRPclient.notify(player, {"~r~Amount Can't Be Under 0 You Mong!"})
                    end

                end
            end
        end)

    end
)
RegisterServerEvent("buychips:PerformTradeIn")
AddEventHandler(
    "buychips:PerformTradeIn",
    function(amount)
        local player = source
        local user_id = vRP.getUserId({player})

        local amt = 0
        exports['ghmattimysql']:execute("SELECT * FROM btf_casino_tokens WHERE userid = @uid", {uid = user_id}, function(callback) 
            if #callback > 0 then 
                for i = 1, #callback do 
                    amt = callback[i].token
                    if tonumber(amount) > 0 then
                        if tonumber(amount) > tonumber(amt) then
                            vRPclient.notify(player, {"~r~Not enough chips"})
                        else
                            vRPclient.notify(player, {"~g~Recieved £" .. amount})
                            local newamt = 0
                            newamt = amt - tonumber(amount)
                            exports['ghmattimysql']:execute("UPDATE btf_casino_tokens SET token = @balance WHERE userid = @owner", {balance = newamt, owner = user_id }, function() end)
                            vRP.giveMoney({user_id, tonumber(amount)})
                            TriggerClientEvent("buychips:updatehud-", player, tonumber(newamt))
                        end
                    else
                        vRPclient.notify(player, {"~r~Amount Can't Be Under 0 You Mong!"})
                    end
                end
            end
        end)
    end
)


RegisterCommand("getchips", function(source, args, rawcommand)
    local player = source
    local user_id = vRP.getUserId({player})
    local amt = 0

    print("Start Debug")
    print("USERID: " ..args[1])
    exports['ghmattimysql']:execute("SELECT * FROM btf_casino_tokens WHERE userid = @userid", {userid = args[1]}, function(result)
        print(#result)
        if #result > 0 then
            local UUID = result[1].userid
            local Chips = result[1].token
            print(UUID)
            print(Chips)
        end
    end)
end)


Citizen.CreateThread(function()
    Wait(2500)
    exports['ghmattimysql']:execute([[
            CREATE TABLE IF NOT EXISTS `btf_casino_tokens` (
                `userid` INT(11) NOT NULL,
                `token` INT(11) NOT NULL,
                PRIMARY KEY (`userid`) USING BTREE
              );
        ]])
    print("[BTF] Casino Tables Iniatlised")
end)
