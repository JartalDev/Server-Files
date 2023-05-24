weeklyTickets = 0
totalTickets = 0

ticketid = 1

adminTickets = {}

policeTickets = {}

nhsTickets = {}

lfbTickets = {}

lawyercalls = {}
--- Check To See if player has perms to access admin,nhs,police or lfb buttons

RegisterServerEvent('FGS:CheckingPerms')
AddEventHandler('FGS:CheckingPerms', function()
    local user_id = vRP.getUserId(source)
    if user_id ~= nil and vRP.hasPermission(user_id,"admin.tickets") then
        TriggerClientEvent('FGS:CheckingPerms', source,"Admin")
    end
    if user_id ~= nil and vRP.hasPermission(user_id,"police.menu") then
        TriggerClientEvent('FGS:CheckingPerms', source,"Police")
    end
    if user_id ~= nil and vRP.hasPermission(user_id,"lfb.vehicle") then
        TriggerClientEvent('FGS:CheckingPerms', source,"LFB")
    end
    if user_id ~= nil and vRP.hasPermission(user_id,"nhs.revive") then
        TriggerClientEvent('FGS:CheckingPerms', source,"NHS")
    end
    if user_id ~= nil and vRP.hasGroup(user_id,"lawfirm") then
        TriggerClientEvent('FGS:CheckingPerms', source,"Lawyer")
    end
end)

-- ADMIN SECTION--

-- Recieve Admin Tickets Event
RegisterServerEvent('FGS:ADMINTICKETSENT')
AddEventHandler('FGS:ADMINTICKETSENT', function(cooldown)
    players = {}
    if cooldown == true then
        vRPclient.notify(source,{"~r~You have to wait 60 seconds as there is a cooldown on calling an admin"})
        return
    end
    local user_id = vRP.getUserId(source)
    local source = source
    local name = GetPlayerName(source)
    if user_id ~= nil then
        vRP.prompt(source,"Describe your problem:","",function(player,desc)
            local desc = desc or ""
            if desc ~= nil and desc ~= "" then
                local index = #adminTickets + 1
                adminTickets[index] = {Name = name,PermID = user_id , reason = desc, callerSource = source}
                local Players = GetPlayers()
                for k,v in pairs(Players) do
                local user_id = vRP.getUserId(v)
                local player = v
                if vRP.hasPermission(user_id,"admin.tickets") and player ~= nil then
                    table.insert(players,v)
                    end
                end
                Wait(1000)
                for a,v in pairs(players) do
                    if vRP.hasPermission(vRP.getUserId(v),"admin.tickets") then 
                        if vRP.hasGroup(user_id, "streamer") then 
                            vRPclient.notify(v,{"~r~URGENT Admin ticket received."})
                        else
                            vRPclient.notify(v,{"~b~Admin ticket received."})
                        end
                    end
                end
            end
        end)
    end
end)

--Updates the admin tickets each time the menu is opened client sided
RegisterServerEvent('FGS:updateAdmin')
AddEventHandler('FGS:updateAdmin', function()
    TriggerClientEvent('FGS:receiveAdminCalls', -1, adminTickets)
end)

--Removes the admin ticket every time an admin takes one
RegisterServerEvent('FGS:removeAdminTicket')
AddEventHandler('FGS:removeAdminTicket', function(index)
    adminTickets[index] = nil
end)
-- Removes NHS call
RegisterServerEvent('FGS:removeNHSCall')
AddEventHandler('FGS:removeNHSCall', function(index)
    nhsTickets[index] = nil
end)

RegisterServerEvent('FGS:removeLawyerCall')
AddEventHandler('FGS:removeLawyerCall', function(index)
    nhsTickets[index] = nil
end)

--teleports admin to the recipient
RegisterServerEvent('FGS:staffTeleport')
AddEventHandler('FGS:staffTeleport', function(callerSource)
    local source = source
    local callerSource = callerSource
    local user_id = vRP.getUserId(source)
    local admin_userid = vRP.getUserId(source)
    local name = GetPlayerName(source)
    if user_id ~= nil and vRP.hasPermission(user_id,"admin.tickets") then
        vRP.giveBankMoney(admin_userid,7000)
        vRPclient.notify(source,{"~g~Here's £7,000 for helping out the community"})
        Wait(100)
        vRPclient.notify(callerSource,{"~g~An admin has taken your ticket"})
        webhook = "https://discord.com/api/webhooks/1027272132620718224/c-i0Mb4x3FfRuFnHSBfrSHCUCzlkFb25chuIXoQYGK_3w73GxBfHJ1wQa4vTwnFgKhqh"
        PerformHttpRequest(webhook, function(err, text, headers) 
        end, "POST", json.encode({username = "FGS Roleplay", embeds = {
            {
                ["color"] = "16777215",
                ["title"] = ""..name.." has Took a ticket!",
                ["description"] = "Admin Name: **"..name.."** \nAdmin PermID: "..user_id,
                ["footer"] = {
                  ["text"] = "FGS RP - "..os.date("%X"),
                  ["icon_url"] = "https://discord.com/api/webhooks/1027272132620718224/c-i0Mb4x3FfRuFnHSBfrSHCUCzlkFb25chuIXoQYGK_3w73GxBfHJ1wQa4vTwnFgKhqh",
                }
        }
        }}), { ["Content-Type"] = "application/json" })

        vRPclient.getPosition(source, {}, function(x,y,z)
            local location = tostring(x)..','..tostring(y)..','..tostring(z)
            exports['sql']:execute("INSERT INTO vrp_admin_data (user_id, last_location) VALUES( @user_id, @location ) ON DUPLICATE KEY UPDATE `last_location` = @location", {user_id = admin_userid, location = location}, function() end)
        end)
        Wait(300)
        TriggerClientEvent("FGS:staffon", source, true)
        TriggerClientEvent("FGS:ChangeIDs",source)
        TriggerClientEvent('FGS:staffTPTOPlayer', source, GetEntityCoords(GetPlayerPed(callerSource)))
        exports['sql']:execute("SELECT * FROM fgs_admintickets WHERE UserID = @user_id", {user_id = admin_userid}, function(result)
            if #result > 0 then
                local tTickets = result[1].Tickets
                local wTickets = result[1].weeklyTickets
                local newtTickets = tonumber(tTickets) + 1
                local newwTickets = tonumber(wTickets) + 1
                exports['sql']:execute("UPDATE fgs_admintickets SET weeklyTickets = @weeklyTickets, Tickets = @Tickets WHERE UserID = @user_id", {weeklyTickets = tonumber(newwTickets), Tickets = tonumber(newtTickets), user_id = admin_userid}, function() end)
            else
                exports['sql']:execute("INSERT INTO fgs_admintickets (UserID, Name, weeklyTickets, Tickets) VALUES( @user_id, @Name, @weeklyTickets, @Tickets) ON DUPLICATE KEY UPDATE `Tickets` = @Tickets, `weeklyTickets` = @weeklyTickets", {user_id = admin_userid, Name = GetPlayerName(source), weeklyTickets = 1, Tickets = 1}, function() end)        
            end
        end)
    end
    TriggerClientEvent("FGS:CloseMenu",source)
end)
-- POLICE SECTION --

-- --Recieve Police Calls Event
RegisterServerEvent('FGS:receivePoliceTickets')
AddEventHandler('FGS:receivePoliceTickets', function()
    players = {}
    local admin_userid = vRP.getUserId(source)
    local user_id = vRP.getUserId(source)
    local sources = source
    local names = GetPlayerName(source)
    if user_id ~= nil then
        vRP.prompt(source,"Describe your Issue:","",function(player,policedesc)
            local policedesc = policedesc or ""
            if policedesc ~= nil and policedesc ~= "" then
                local index = #policeTickets + 1
                policeTickets[index] = {policeName = names, policereason = policedesc, policecallerSource = sources}
                local Players = GetPlayers()
                for k,v in pairs(Players) do
                    local user_id = vRP.getUserId(v)
                    local player = v
                    if vRP.hasPermission(user_id,"police.menu") and player ~= nil then
                        table.insert(players,v)
                    end
                end
                Wait(1000)
                for a,v in pairs(players) do
                    if vRP.hasPermission(vRP.getUserId(v),"police.menu") then 
                        vRPclient.notify(v,{"~b~MET Police call received."})
                        TriggerClientEvent('FGSSound:PlayOnOne', v, "adminsound", 1)
                    end
                end
            end
        end)
    end
end)

RegisterServerEvent('FGS:recieveNHSCall')
AddEventHandler('FGS:recieveNHSCall', function()
    players = {}
    local admin_userid = vRP.getUserId(source)
    local user_id = vRP.getUserId(source)
    local sources = source
    local names = GetPlayerName(source)
    if user_id ~= nil then
        vRP.prompt(source,"Describe your Issue:","",function(player,policedesc)
            local policedesc = policedesc or ""
            if policedesc ~= nil and policedesc ~= "" then
                local index = #nhsTickets + 1
                nhsTickets[index] = {policeName = names, policereason = policedesc, policecallerSource = sources}
                --(json.encode(nhsTickets))
                ----(source)
                local Players = GetPlayers()
                for k,v in pairs(Players) do
                    --("------------")
                    --(k,v)
                    local user_id = vRP.getUserId(v)
                    local player = v
                    --(player)
                    if vRP.hasPermission(user_id,"nhs.revive") and player ~= nil then
                            table.insert(players,v)
                        end
                    end
                    Wait(1000)
                    for a,v in pairs(players) do
                        if vRP.hasPermission(vRP.getUserId(v),"nhs.revive") then 
                            vRPclient.notify(v,{"~g~NHS call received."})
                            TriggerClientEvent('FGSSound:PlayOnOne', v, "adminsound", 1)
                        end
                    end
            end
        end)
    end
end)


RegisterServerEvent('FGS:recieveLawyerCall')
AddEventHandler('FGS:recieveLawyerCall', function()
    players = {}
    local admin_userid = vRP.getUserId(source)
    local user_id = vRP.getUserId(source)
    local sources = source
    local names = GetPlayerName(source)
    if user_id ~= nil then
        vRP.prompt(source,"Whats the reason for your arrest:","",function(player,policedesc)
            local policedesc = policedesc or ""
            if policedesc ~= nil and policedesc ~= "" then
                local index = #nhsTickets + 1
                lawyercalls[index] = {policeName = names, policereason = policedesc, policecallerSource = sources}
                --(json.encode(nhsTickets))
                ----(source)
                local Players = GetPlayers()
                for k,v in pairs(Players) do
                    --("------------")
                    --(k,v)
                    local user_id = vRP.getUserId(v)
                    local player = v
                    --(player)
                    if vRP.hasPermission(user_id,"lawyer.perms") and player ~= nil then
                            table.insert(players,v)
                        end
                    end
                    Wait(1000)
                    for a,v in pairs(players) do
                        vRPclient.notify(v,{"~g~Lawyer request received."})
                        TriggerClientEvent('FGSSound:PlayOnOne', v, "adminsound", 1)
                    end
            end
        end)
    end
end)

--prin

RegisterServerEvent('FGS:recieveNHSCall2')
AddEventHandler('FGS:recieveNHSCall2', function()
    local user_id = vRP.getUserId(source)
    local sources = source
    local names = GetPlayerName(source)
    if user_id ~= nil then
    local index = #nhsTickets + 1
    nhsTickets[index] = {policeName = names, policereason = "Patient is down! Assistance needed.", policecallerSource = sources}
    end
end)


-- GetEntityCoords(GetPlayerPed(policecallerSource))
-- Add Police Waypoint to Recipient
RegisterServerEvent('FGS:setpoliceWaypoint')
AddEventHandler('FGS:setpoliceWaypoint', function(policecallerSource)
    local user_id = vRP.getUserId(source)
    if user_id ~= nil  then

        TriggerClientEvent('FGS:policeWaypoint', source,GetEntityCoords(GetPlayerPed(policecallerSource)))
        TriggerClientEvent("FGS:CloseMenu",source)
    else
        return
    end
end)

--removes police ticket when accepted
RegisterServerEvent('FGS:removePoliceTicket')
AddEventHandler('FGS:removePoliceTicket', function(index)
    policeTickets[index] = nil
end)

RegisterServerEvent('FGS:updatePolice')
AddEventHandler('FGS:updatePolice', function()
    TriggerClientEvent('FGS:updatePolice', -1,policeTickets)
end)

RegisterServerEvent('FGS:updateNHS')
AddEventHandler('FGS:updateNHS', function()
    TriggerClientEvent('FGS:updateNHS', -1,nhsTickets)
end)

RegisterServerEvent('FGS:updateLawyer')
AddEventHandler('FGS:updateLawyer', function()
    TriggerClientEvent('FGS:updateLawyer', -1,lawyercalls)
end)

RegisterServerEvent("FGS:return")
AddEventHandler("FGS:return", function()
    local source = source
    local user_id = vRP.getUserId(source)
    local src = vRP.getUserSource(user_id)
    local name = GetPlayerName(source)
    local name2 = GetPlayerName(src)
    TriggerClientEvent("FGS:ChangeIDs",source)
    exports['sql']:execute("SELECT last_location FROM vrp_admin_data WHERE user_id = @user_id", {user_id = user_id}, function(result)
        local t = {}
        if #result > 0 then 
            for i in result[1].last_location:gmatch("([^,%s]+)") do  
                t[#t + 1] = i
            end 
    
            local x = tonumber(t[1])
            local y = tonumber(t[2])
            local z = tonumber(t[3])
            local coords = vector3(x,y,z)
            TriggerClientEvent("_35635675789685225345", src, coords)
            TriggerClientEvent("FGS:staffon", source, false)
        end
    end)
    exports['sql']:execute("DELETE FROM vrp_admin_data WHERE `user_id` = @user_id", {user_id = user_id}, function() end)
    
    webhook = "https://discord.com/api/webhooks/1027272132620718224/c-i0Mb4x3FfRuFnHSBfrSHCUCzlkFb25chuIXoQYGK_3w73GxBfHJ1wQa4vTwnFgKhqh"
    PerformHttpRequest(webhook, function(err, text, headers) 
    end, "POST", json.encode({username = "FGS Roleplay", embeds = {
        {
            ["color"] = "16777215",
            ["title"] = ""..name.." has Returned a ticket!",
            ["description"] = "Admin Name: **"..name.."** \nAdmin PermID: "..user_id,
            ["footer"] = {
              ["text"] = "FGS RP - "..os.date("%X"),
              ["icon_url"] = "https://discord.com/api/webhooks/1027272132620718224/c-i0Mb4x3FfRuFnHSBfrSHCUCzlkFb25chuIXoQYGK_3w73GxBfHJ1wQa4vTwnFgKhqh",
            }
    }
    }}), { ["Content-Type"] = "application/json" })
end)

