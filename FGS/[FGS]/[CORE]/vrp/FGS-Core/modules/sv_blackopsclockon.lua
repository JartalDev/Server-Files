RegisterServerEvent("BlackOPSMenu:ClockOn")
AddEventHandler('BlackOPSMenu:ClockOn', function(blackopsrank)
    local user_id = vRP.getUserId(source)
    local coords = GetEntityCoords(GetPlayerPed(source))
    local comparison = vector3(123.62696075439,-751.81896972656,45.763095855713)

    if blackopsrank == "BlackOPS Clocked" then
        blackopsperm = "blackops.clockon"
        blackopsname = "BlackOPS"
    end

    if user_id ~= nil and vRP.hasPermission(user_id, blackopsperm) and not vRP.hasGroup(user_id,blackopsrank) then
        vRP.addUserGroup(user_id,blackopsrank)
        vRPclient.notify(source,{"~b~You have clocked on as a "..blackopsname})
    elseif user_id == nil then
        vRPclient.notify(source,{"~r~You are a nil User ID, please relog."})
    elseif not vRP.hasPermission(user_id, blackopsperm) then
        vRPclient.notify(source,{"~r~Hey! You aren't allowed to clock on as that rank."})
    elseif not vRP.hasPermission(user_id, "clockonblackops.menu") then
        vRPclient.notify(source,{"~r~You have been reported to admins since you are trying to clock on through a mod menu"})
    elseif vRP.hasGroup(user_id,blackopsrank) then
        vRPclient.notify(source,{"~r~You are already clocked on!"})
    end
    if #(coords - comparison) > 20 then
        print(GetPlayerName(source).." is a cheating scum, he's trying to clock on as blackops!")
        vRP.AnticheatBanVRP(user_id, 'Type: [1](Injecting Code)')
        return
    end
end)

RegisterServerEvent("BlackOPSMenu:CheckPermissions")
AddEventHandler('BlackOPSMenu:CheckPermissions', function()
    local user_id = vRP.getUserId(source)
    local coords = GetEntityCoords(GetPlayerPed(source))
    local comparison = vector3(123.62696075439,-751.81896972656,45.763095855713)
    if #(coords - comparison) > 20 then
        print(GetPlayerName(source).." is a cheating scum, he's trying to clock on as blackops!")
        vRP.AnticheatBanVRP(user_id, 'Type: [1](Injecting Code)')
        return
    end
    if vRP.hasPermission(user_id, "clockonblackops.menu") then
        TriggerClientEvent('BlackOPSDuty:Allowed', source, true)
    else
        TriggerClientEvent('BlackOPSDuty:Allowed', source, false)
    end
end)

RegisterServerEvent("BlackOPSMenu:ClockOff")
AddEventHandler('BlackOPSMenu:ClockOff', function()
    local user_id = vRP.getUserId(source)
    local coords = GetEntityCoords(GetPlayerPed(source))
    local comparison = vector3(123.62696075439,-751.81896972656,45.763095855713)

    if user_id == nil then
        vRPclient.notify(source,{"~r~You are a nil User ID, please relog."})
    elseif user_id ~= nil and vRP.hasGroup(user_id, "BlackOPS Clocked") then
        vRP.removeUserGroup(user_id,"BlackOPS Clocked")
        vRPclient.notify(source,{"You have clocked off"})
    end
    if #(coords - comparison) > 20 then
        print(GetPlayerName(source).." is a cheating scum, he's trying to clock off as blackops!")
        vRP.AnticheatBanVRP(user_id, 'Type: [1](Injecting Code)')
        return
    end
end)