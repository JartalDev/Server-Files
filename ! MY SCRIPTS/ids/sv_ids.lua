local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vrp")
local users = {}
RegisterNetEvent("PlayerJoined")
AddEventHandler(
    "PlayerJoined",
    function()
        local tempid = source
        local user_id = vRP.getUserId({source})
        if users[tempid] then
        else
            users[tempid] = user_id
        end
    end
)

--function Notify(msg)
--    SetNotificationTextEntry("STRING")
--    AddTextComponentString(msg)
--    DrawNotification(true,false)
--end

RegisterCommand("getmyid", function(source)
    Notify("~w~[~b~SERVER-NAME~w~] Your Perm ID is: ~g~" .. vRP.getUserId({source}))
    --('chatMessage', source, "^7[^SERVER-NAME^7]", {255, 255, 255}, " Perm ID: " .. vRP.getUserId({source}) , "alert")
end)

RegisterCommand("getmytempid", function(source)
	Notify("~w~[~b~SERVER-NAME~w~] Your Temp ID: ~g~" .. source)
end)
