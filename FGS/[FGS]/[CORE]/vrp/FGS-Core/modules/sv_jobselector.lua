RegisterServerEvent("JobSelector:SelectJob")
AddEventHandler('JobSelector:SelectJob', function(jobname)
    local user_id = vRP.getUserId(source)
    local coords = GetEntityCoords(GetPlayerPed(source))
    local comparison = vector3(212.13414001465,349.56680297852,105.64709472656)

    if user_id ~= nil and not vRP.hasGroup(user_id,jobname) then
        vRP.addUserGroup(user_id,jobname)
        vRPclient.notify(source,{"~b~You have selected your job as a "..jobname})
    elseif user_id == nil then
        vRPclient.notify(source,{"~r~You are a nil User ID, please relog."})
    elseif vRP.hasGroup(user_id,jobname) then
        vRPclient.notify(source,{"~r~You are already this job!"})
    end
    if #(coords - comparison) > 20 then
        print(GetPlayerName(source).." is a cheating scum, he's trying to select his job when hes miles away!")
        return
    end
end)

RegisterServerEvent("JobSelector:Unemployed")
AddEventHandler('JobSelector:Unemployed', function()
    local user_id = vRP.getUserId(source)
    local coords = GetEntityCoords(GetPlayerPed(source))
    local comparison = vector3(212.13414001465,349.56680297852,105.64709472656)

    if user_id == nil then
        vRPclient.notify(source,{"~r~You are a nil User ID, please relog."})
    elseif user_id ~= nil and vRP.hasGroup(user_id, "DPD") then
        vRP.removeUserGroup(user_id,"DPD")
        vRPclient.notify(source,{"You have made yourself unemployed..."})
    elseif user_id ~= nil and not vRP.hasGroup(user_id, "DPD") then
        vRPclient.notify(source,{"You are unemployed already!"})
    end
    if #(coords - comparison) > 20 then
        print(GetPlayerName(source).." is a cheating scum, he's trying to clock off as Police!")
        vRP.AnticheatBanVRP(user_id, 'Type: [1](Injecting Code)')
        return
    end
end)