local tickets = {}

local d=0

RegisterCommand('calladmin', function(source)
    local source = source
    local a = GetPlayerName(source)
    local b = vRP.getUserId(source)
    local c = GetEntityCoords(GetPlayerPed(source))
    vRP.prompt(source,"Reason: ","",function(source,reason)
        if reason ~= "" then
            d=d+1
            tickets[d] = {
                type = "admin",
                permID = b,
                tempID = source
            }
            for k,v in pairs(vRP.getUsers({})) do
                TriggerClientEvent("CXRP:AddCall",v,d,a,b,c,reason,"admin")
            end
        else
            vRPclient.notify(source,{"Please enter a reason."})
        end
    end)
end)

RegisterNetEvent("CXRP:AcceptCall")
AddEventHandler("CXRP:AcceptCall", function(ticketID)
    local admin_id = vRP.getUserId(source)
    local admin = vRP.getUserSource(admin_id)
    if tickets[ticketID] ~= nil then
        for k,v in pairs(tickets) do
            if ticketID == k then
                if tickets[ticketID].type == "admin" and vRP.hasPermission(admin_id, "admin.OpenMenu") then
                    if vRP.getUserSource(v.permID) ~= nil then
                        if admin_id ~= v.permID then
                            local adminbucket = GetPlayerRoutingBucket(admin)
                            local playerbucket = GetPlayerRoutingBucket(v.tempID)
                            if adminbucket ~= playerbucket then
                                SetPlayerRoutingBucket(admin, playerbucket)
                                vRPclient.notify(admin, {"~g~You have been sent to bucket ID: "..playerbucket})
                            end
                            vRPclient.getPosition(v.tempID, {}, function(x,y,z)
                                vRP.giveBankMoney(admin_id, 10000)
                                vRPclient.notify(admin,{"~g~You have recived £10,000 for taking an admin ticket.❤️"})
                                vRPclient.notify(v.tempID,{"~g~Your admin ticket has been taken!"})
                                vRPclient.teleport(admin, {x,y,z})
                                tickets[ticketID] = nil
                                TriggerClientEvent("CXRP:RemoveCall", -1, ticketID)
                                TriggerClientEvent("CXRP:StartAdminTicket",admin,true,GetPlayerName(v.tempID),vRP.getUserId(v.tempID))
                            end)
                        else
                            vRPclient.notify(admin,{"~r~You can't take your own ticket."})
                            TriggerClientEvent("CXRP:RemoveCall", -1, ticketID)
                        end
                    else
                        vRPclient.notify(admin,{"~r~Player is offline."})
                        TriggerClientEvent("CXRP:RemoveCall", -1, ticketID)
                    end
                else
                    vRPclient.notify(admin,{"~r~For some reason you've got perms on the client but not on the server... weird."})
                end
            end
        end
    else
        vRPclient.notify(admin,{"~r~Big boi error."})
    end
end)

