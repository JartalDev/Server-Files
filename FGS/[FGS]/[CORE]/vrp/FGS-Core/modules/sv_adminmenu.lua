RegisterServerEvent("FGS:GetPlayerData")
AddEventHandler("FGS:GetPlayerData",function()
    local source = source
    user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, admincfg.perm) then
        local players = GetPlayers()
        local players_table = {}
        local menu_btns_table = {}
        for i, p in pairs(players) do
            if vRP.getUserId(p) ~= nil then
            name = GetPlayerName(p)
            user_idz = vRP.getUserId(p)
            players_table[#players_table + 1] = {name, p, user_idz}
            else
                vRPclient.notify(p, {"You Are Nil Id'd"})
            end
         end
        if admincfg.IgnoreButtonPerms == false then
            for i, b in pairs(admincfg.buttonsEnabled) do
                if b[1] and vRP.hasPermission(user_id, b[2]) then
                    menu_btns_table[i] = true
                else
                    menu_btns_table[i] = false
                end
            end
        else
            for j, t in pairs(admincfg.buttonsEnabled) do
                menu_btns_table[j] = true
            end
        end
        TriggerClientEvent("FGS:SendPlayersInfo", source, players_table, menu_btns_table)
    end
end)

RegisterServerEvent("FGS:getGroups")
AddEventHandler("FGS:getGroups",function(temp, perm)
    local user_groups = vRP.getUserGroups(perm)
    TriggerClientEvent("FGS:gotgroups", source, user_groups)
end)


local se = "https://discord.com/api/webhooks/977271679329923152/0LKsiZARoI4Whk5Usx4J6XMgIgU8wl4NrCHYYpSZpJ78iSmm5Jld5CGqSuETnhjUxPm6" --dfunno what this is for


function discord(source, rank, perm)
    local embed = {
          {
			["color"] = "15158332",
			["title"] = "Perm ID: " .. vRP.getUserId(source),
			["description"] = "**'" .. GetPlayerName(source) .. "'** Tried to give rank " .. rank .. " to **'" .. perm .. "'**",
			["footer"] = {
				["text"] = "Time - "..os.date("%x %X %p"),
			}
          }
      }
  
    PerformHttpRequest(se, function(err, text, headers) end, 'POST', json.encode({username = name, embeds = embed}), { ['Content-Type'] = 'application/json' })
end


RegisterServerEvent("FGS:addGroup")
AddEventHandler("FGS:addGroup",function(perm, selgroup)
    local admin_temp = source
    local admin_perm = vRP.getUserId(admin_temp)
    local user_id = vRP.getUserId(source)
    local permsource = vRP.getUserSource(perm)
    local playerName = GetPlayerName(source)
    local povName = GetPlayerName(permsource)
    if vRP.hasPermission(user_id, "group.add") then
        if selgroup == "founder" and not vRP.hasPermission(admin_perm, "group.add.founder") then
            vRPclient.notify(admin_temp, {"~r~You don't have permission to do that"}) 
        elseif selgroup == "dev" and not vRP.hasPermission(admin_perm, "group.add.founder") then
            vRPclient.notify(admin_temp, {"~r~You don't have permission to do that"}) 
        elseif selgroup == "staffmanager" and not vRP.hasPermission(admin_perm, "group.add.staffmanager") then
            vRPclient.notify(admin_temp, {"~r~You don't have permission to do that"}) 
        elseif selgroup == "commdirect" and not vRP.hasPermission(admin_perm, "group.add.commdirect") then
            vRPclient.notify(admin_temp, {"~r~You don't have permission to do that"}) 
        elseif selgroup == "headadmin" and not vRP.hasPermission(admin_perm, "group.add.headadmin") then
            vRPclient.notify(admin_temp, {"~r~You don't have permission to do that"}) 
        elseif selgroup == "senioradmin" and not vRP.hasPermission(admin_perm, "group.add.senioradmin") then
            vRPclient.notify(admin_temp, {"~r~You don't have permission to do that"})
        elseif selgroup == "leadcardev" and not vRP.hasPermission(admin_perm, "group.add.leadcardev") then
            vRPclient.notify(admin_temp, {"~r~You don't have permission to do that"})
        elseif selgroup == "administrator" and not vRP.hasPermission(admin_perm, "group.add.administrator") then
            vRPclient.notify(admin_temp, {"~r~You don't have permission to do that"})
        elseif selgroup == "moderator" and not vRP.hasPermission(admin_perm, "group.add.moderator") then
            vRPclient.notify(admin_temp, {"~r~You don't have permission to do that"})
        elseif selgroup == "trialstaff" and not vRP.hasPermission(admin_perm, "group.add.trial") then
            vRPclient.notify(admin_temp, {"~r~You don't have permission to do that"})
        elseif selgroup == "vip" and not vRP.hasPermission(admin_perm, "group.add.vip") then
            vRPclient.notify(admin_temp, {"~r~You don't have permission to do that"}) 
        elseif selgroup == "bronze" and not vRP.hasPermission(admin_perm, "group.add.bronze") then
            vRPclient.notify(admin_temp, {"~r~You don't have permission to do that"})
        elseif selgroup == "silver" and not vRP.hasPermission(admin_perm, "group.add.silver") then
            vRPclient.notify(admin_temp, {"~r~You don't have permission to do that"}) 
        elseif selgroup == "gold" and not vRP.hasPermission(admin_perm, "group.add.gold") then
            vRPclient.notify(admin_temp, {"~r~You don't have permission to do that"})   
        elseif selgroup == "diamond" and not vRP.hasPermission(admin_perm, "group.add.platinum") then
            vRPclient.notify(admin_temp, {"~r~You don't have permission to do that"})               
        elseif selgroup == "platinum" and not vRP.hasPermission(admin_perm, "group.add.platinum") then
            vRPclient.notify(admin_temp, {"~r~You don't have permission to do that"})                  
        else
            vRP.addUserGroup(perm, selgroup)
        end
        discord(source, selgroup, perm)
    else
        print("Stop trying to add a group u fucking cheater")
    end
end)

RegisterServerEvent("FGS:removeGroup")
AddEventHandler("FGS:removeGroup",function(perm, selgroup)
    local user_id = vRP.getUserId(source)
    local admin_temp = source
    local permsource = vRP.getUserSource(perm)
    local playerName = GetPlayerName(source)
    local povName = GetPlayerName(permsource)
    if vRP.hasPermission(user_id, "group.remove") then
        if selgroup == "founder" and not vRP.hasPermission(user_id, "group.remove.founder") then
            vRPclient.notify(admin_temp, {"~r~You don't have permission to do that"}) 
        elseif selgroup == "staffmanager" and not vRP.hasPermission(user_id, "group.remove.staffmanager") then
            vRPclient.notify(admin_temp, {"~r~You don't have permission to do that"}) 
        elseif selgroup == "commdirect" and not vRP.hasPermission(user_id, "group.remove.commdirect") then
            vRPclient.notify(admin_temp, {"~r~You don't have permission to do that"}) 
        elseif selgroup == "headadmin" and not vRP.hasPermission(user_id, "group.remove.headadmin") then
            vRPclient.notify(admin_temp, {"~r~You don't have permission to do that"}) 
        elseif selgroup == "senioradmin" and not vRP.hasPermission(user_id, "group.remove.senioradmin") then
            vRPclient.notify(admin_temp, {"~r~You don't have permission to do that"})
        elseif selgroup == "leadcardev" and not vRP.hasPermission(admin_perm, "group.remove.leadcardev") then
            vRPclient.notify(admin_temp, {"~r~You don't have permission to do that"})        
        elseif selgroup == "administrator" and not vRP.hasPermission(user_id, "group.remove.administrator") then
            vRPclient.notify(admin_temp, {"~r~You don't have permission to do that"})
        elseif selgroup == "moderator" and not vRP.hasPermission(user_id, "group.remove.moderator") then
            vRPclient.notify(admin_temp, {"~r~You don't have permission to do that"})
        elseif selgroup == "trialstaff" and not vRP.hasPermission(user_id, "group.remove.trial") then
            vRPclient.notify(admin_temp, {"~r~You don't have permission to do that"})
        elseif selgroup == "vipgarage" and not vRP.hasPermission(user_id, "group.remove.vipgarage") then
            vRPclient.notify(admin_temp, {"~r~You don't have permission to do that"})
        elseif selgroup == "bronze" and not vRP.hasPermission(user_id, "group.remove.bronze") then
                vRPclient.notify(admin_temp, {"~r~You don't have permission to do that"})
        elseif selgroup == "silver" and not vRP.hasPermission(user_id, "group.remove.silver") then
                vRPclient.notify(admin_temp, {"~r~You don't have permission to do that"})
        elseif selgroup == "gold" and not vRP.hasPermission(user_id, "group.remove.gold") then
                vRPclient.notify(admin_temp, {"~r~You don't have permission to do that"})
        elseif selgroup == "diamond" and not vRP.hasPermission(user_id, "group.remove.diamond") then
                vRPclient.notify(admin_temp, {"~r~You don't have permission to do that"})
        elseif selgroup == "platinum" and not vRP.hasPermission(user_id, "group.remove.platinum") then
                vRPclient.notify(admin_temp, {"~r~You don't have permission to do that"})                    
        else
            vRP.removeUserGroup(perm, selgroup)
        end
    else 
        print("Stop trying to add a group u fucking cheater")
    end
end)

RegisterServerEvent('FGS:BanPlayer')
AddEventHandler('FGS:BanPlayer', function(target, reason, duration)
    local source = source
    local target = target
    local target_id = vRP.getUserSource(target)
    local admin_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, "admin.ban") then
        if tonumber(duration) then 
            local playerName = GetPlayerName(source)
            local playerOtherName = GetPlayerName(target)
            if tonumber(duration) == -1 then
                vRP.ban(source,target,"perm",reason or "No reason given")
            else
                vRP.ban(source,target,duration,reason or "No reason given")
                TriggerEvent('FGS:BanPlayerLog', target, GetPlayerName(source), reason, duration)
                TriggerClientEvent('FGS:Notify', source, 'Banned Player')
            end
        end
    end
end)

RegisterServerEvent('FGS:KickPlayer')
AddEventHandler('FGS:KickPlayer', function(admin, target, reason, tempid)
    local target_id = vRP.getUserSource(target)
    local target_permid = target
    local playerName = GetPlayerName(source)
    local playerOtherName = GetPlayerName(tempid)
    local perm = admincfg.buttonsEnabled["kick"][2]
    local admin_id = vRP.getUserId(admin)
    if vRP.hasPermission(admin_id, perm) then
        webhook = "https://discord.com/api/webhooks/982453950194286672/2Ki0UJPrK9mVWaZu7GPUWKygJDMV4B14M4BvHh4VMwWudbOBCcwOKguG1YQgz7EOMBpP"
        PerformHttpRequest(webhook, function(err, text, headers) 
        end, "POST", json.encode({username = "FGS Roleplay", embeds = {
            {
                ["color"] = "15158332",
                ["title"] = "Kicked "..playerOtherName.." out of the server. Reason: "..reason,
                ["description"] = "Admin Name: **"..playerName.."** \nAdmin ID: **"..admin_id.."** \nPlayer ID: **"..target_permid.."** \nDescription: **Kicked "..playerOtherName.." out of the server. Reason: "..reason.."**",
                ["footer"] = {
                    ["text"] = "Time - "..os.date("%x %X %p"),
                }
        }
        }}), { ["Content-Type"] = "application/json" })
        vRP.kick(target_id, "[FGS] You have been kicked | Your ID is: "..target.." | Reason: "..reason.." | Kicked by "..GetPlayerName(admin) or "No reason specified")
        TriggerEvent("FGS:saveKickLog",target,GetPlayerName(admin),reason)
        TriggerClientEvent('FGS:Notify', admin, 'Kicked Player')
    end
end)

RegisterServerEvent('FGS:KickPlayerNoF10')
AddEventHandler('FGS:KickPlayerNoF10', function(admin, target, reason)
    local target_id = vRP.getUserSource(target)
    local target_permid = vRP.getUserId(target_id)
    local perm = admincfg.buttonsEnabled["kick"][2]
    local admin_id = vRP.getUserId(admin)
    if vRP.hasPermission(admin_id, perm) then
        local playerName = GetPlayerName(source)
        local playerOtherName = GetPlayerName(target_id)
        webhook = "https://discord.com/api/webhooks/982453950194286672/2Ki0UJPrK9mVWaZu7GPUWKygJDMV4B14M4BvHh4VMwWudbOBCcwOKguG1YQgz7EOMBpP"
        PerformHttpRequest(webhook, function(err, text, headers) 
        end, "POST", json.encode({username = "FGS Roleplay", embeds = {
            {
                ["color"] = "15158332",
                ["title"] = "No F10 Kicked "..playerOtherName.." out of the server. Reason: "..reason,
                ["description"] = "Admin Name: **"..playerName.."** \nAdmin ID: **"..admin_id.."** \nPlayer ID: **"..target_permid.."** \nDescription: **No F10 Kicked "..playerOtherName.." out of the server. Reason: "..reason.."**",
                ["footer"] = {
                    ["text"] = "Time - "..os.date("%x %X %p"),
                }
        }
        }}), { ["Content-Type"] = "application/json" })
        vRP.kick(target_id, "[FGS] You have been kicked | Your ID is: "..target.." | Reason: "..reason.." | Kicked by "..GetPlayerName(admin) or "No reason specified")
        TriggerClientEvent('FGS:Notify', admin, 'Kicked Player')
    end
end)

RegisterServerEvent('FGS:RemoveWarning')
AddEventHandler('FGS:RemoveWarning', function(admin, warningid)
    local admin_id = vRP.getUserId(admin)
    local perm = admincfg.buttonsEnabled["removewarn"][2]
    if vRP.hasPermission(admin_id, perm) then
        exports['sql']:execute("DELETE FROM vrp_warnings WHERE warning_id = @uid", {uid = warningid})
        TriggerClientEvent('FGS:Notify', admin, 'Removed #'..warningid..' Warning ID')
        webhook = "https://discord.com/api/webhooks/982454125163843614/K_Py_dt6CUoyHC-FQd_F5Y3_LNcXZvSFysQKcnAROYLRWaAEwvEkpU2l89SAbSrLPcFG"
        PerformHttpRequest(webhook, function(err, text, headers) 
        end, "POST", json.encode({username = "FGS Roleplay", embeds = {
            {
                ["color"] = "15158332",
                ["title"] = "Removed Warning ID "..warningid,
                ["description"] = admin_id,
                ["footer"] = {
                    ["text"] = "Time - "..os.date("%x %X %p"),
                }
        }
        }}), { ["Content-Type"] = "application/json" })
    end
end)

RegisterServerEvent("FGS:Unban")
AddEventHandler("FGS:Unban",function(perm)
    local source = source
    local admin_id = vRP.getUserId(source)
    local perm = admincfg.buttonsEnabled["ban"][2]
    if vRP.hasPermission(admin_id, perm) then
        vRP.setBanned(perm,false,'','','')
    else
        print("Cheater tried fucking unbanning, the nerd")
        vRP.AnticheatBanVRP(user_id, 'Type: [1](Injecting Code) (COULD BE FALSE)')
    end
end)

RegisterServerEvent('FGS:SlapPlayer')
AddEventHandler('FGS:SlapPlayer', function(admin, target)
    local admin_id = vRP.getUserId(admin)
    if vRP.hasPermission(admin_id, "admin.slap") then
        local playerName = GetPlayerName(source)
        local playerOtherName = GetPlayerName(target)
        webhook = "https://discord.com/api/webhooks/982454359507992577/OInWnPe1FSjmBmY2yAbNI-q-LpTAMvF0RcNZcpkcJvTGwb82IGHAMGxvnb7rqUJCLEn1"
        PerformHttpRequest(webhook, function(err, text, headers) 
        end, "POST", json.encode({username = "FGS Roleplay", embeds = {
            {
                ["color"] = "15158332",
                ["title"] = "Slapped "..playerOtherName,
                ["description"] = "Admin Name: **"..playerName.."** \nPermID: **"..user_id.."** \nDescription: **Slapped "..playerOtherName.."**",
                ["footer"] = {
                    ["text"] = "Time - "..os.date("%x %X %p"),
                }
        }
        }}), { ["Content-Type"] = "application/json" })
        TriggerClientEvent('FGS:SlapPlayer', target)
        TriggerClientEvent('FGS:Notify', admin, 'Slapped Player')
    end
end)

RegisterServerEvent('FGS:RevivePlayer')
AddEventHandler('FGS:RevivePlayer', function(admin, target)
    local admin_id = vRP.getUserId(admin)
    if vRP.hasPermission(admin_id, "admin.revive") then
        local playerName = GetPlayerName(source)
        local playerOtherName = GetPlayerName(target)
        webhook = "https://discord.com/api/webhooks/982454359507992577/OInWnPe1FSjmBmY2yAbNI-q-LpTAMvF0RcNZcpkcJvTGwb82IGHAMGxvnb7rqUJCLEn1"
        PerformHttpRequest(webhook, function(err, text, headers) 
        end, "POST", json.encode({username = "FGS Roleplay", embeds = {
            {
                ["color"] = "15158332",
                ["title"] = "Revived "..playerOtherName,
                ["description"] = "Admin Name: **"..playerName.."** \nPermID: **"..user_id.."** \nDescription: **Revived "..playerOtherName.."**",
                ["footer"] = {
                    ["text"] = "Time - "..os.date("%x %X %p"),
                }
        }
        }}), { ["Content-Type"] = "application/json" })
        TriggerClientEvent('FGS:FixPlayer',target)
        TriggerClientEvent('FGS:Notify', admin, 'Revived Player')
    end
end)

RegisterServerEvent('FGS:FreezeSV')
AddEventHandler('FGS:FreezeSV', function(admin, newtarget, isFrozen)
    local admin_id = vRP.getUserId(admin)
    local perm = admincfg.buttonsEnabled["FREEZE"][2]
    if vRP.hasPermission(admin_id, perm) then
        local playerName = GetPlayerName(source)
        local playerOtherName = GetPlayerName(newtarget)
        if isFrozen then
            webhook = "https://discord.com/api/webhooks/982454359507992577/OInWnPe1FSjmBmY2yAbNI-q-LpTAMvF0RcNZcpkcJvTGwb82IGHAMGxvnb7rqUJCLEn1"
            PerformHttpRequest(webhook, function(err, text, headers) 
            end, "POST", json.encode({username = "FGS Roleplay", embeds = {
                {
                    ["color"] = "15158332",
                    ["title"] = "Froze "..playerOtherName,
                    ["description"] = "Admin Name: **"..playerName.."** \nPermID: **"..user_id.."** \nDescription: **Froze "..playerOtherName.."**",
                    ["footer"] = {
                        ["text"] = "Time - "..os.date("%x %X %p"),
                    }
            }
            }}), { ["Content-Type"] = "application/json" })
        else
            webhook = "https://discord.com/api/webhooks/982454359507992577/OInWnPe1FSjmBmY2yAbNI-q-LpTAMvF0RcNZcpkcJvTGwb82IGHAMGxvnb7rqUJCLEn1"
            PerformHttpRequest(webhook, function(err, text, headers) 
            end, "POST", json.encode({username = "FGS Roleplay", embeds = {
                {
                    ["color"] = "15158332",
                    ["title"] = "Unfroze "..playerOtherName,
                    ["description"] = "Admin Name: **"..playerName.."** \nPermID: **"..user_id.."** \nDescription: **Unfroze "..playerOtherName.."**",
                    ["footer"] = {
                        ["text"] = "Time - "..os.date("%x %X %p"),
                    }
            }
            }}), { ["Content-Type"] = "application/json" })
        end
        TriggerClientEvent('FGS:Freeze', newtarget, isFrozen)
        TriggerClientEvent('FGS:Notify', admin, 'Froze Player')
    end
end)

RegisterServerEvent('FGS:TeleportToPlayer')
AddEventHandler('FGS:TeleportToPlayer', function(source, newtarget)
    local coords = GetEntityCoords(GetPlayerPed(newtarget))
    local user_id = vRP.getUserId(source)
    local perm = admincfg.buttonsEnabled["TP2"][2]
    if vRP.hasPermission(user_id, perm) then
        local playerName = GetPlayerName(source)
        local playerOtherName = GetPlayerName(newtarget)
        if playerOtherName then 
            playerOtherName = "N/A probably not a player"
        end
        webhook = "https://discord.com/api/webhooks/982454359507992577/OInWnPe1FSjmBmY2yAbNI-q-LpTAMvF0RcNZcpkcJvTGwb82IGHAMGxvnb7rqUJCLEn1"
        PerformHttpRequest(webhook, function(err, text, headers) 
        end, "POST", json.encode({username = "FGS Roleplay", embeds = {
            {
                ["color"] = "15158332",
                ["title"] = "Teleported to "..playerOtherName,
                ["description"] = "Admin Name: **"..playerName.."** \nPermID: **"..user_id.."** \nDescription: **Teleported to "..playerOtherName.."**",
                ["footer"] = {
                    ["text"] = "Time - "..os.date("%x %X %p"),
                }
        }
        }}), { ["Content-Type"] = "application/json" })
        TriggerClientEvent('FGS:Teleport', source, coords)
    end
end)

RegisterNetEvent('vRPAdmin:Bring')
AddEventHandler('vRPAdmin:Bring', function(id)
    local source = source
    local SelectedPlrSource = vRP.getUserSource(id) 
    local userid = vRP.getUserId(source)
  
        if SelectedPlrSource then  
            if onesync ~= "off" then 
                local ped = GetPlayerPed(source)
                local otherPlr = GetPlayerPed(SelectedPlrSource)
                local pedCoords = GetEntityCoords(ped)
                local playerOtherName = GetPlayerName(SelectedPlrSource)
                SetEntityCoords(otherPlr, pedCoords)

                webhook = "https://discord.com/api/webhooks/982454359507992577/OInWnPe1FSjmBmY2yAbNI-q-LpTAMvF0RcNZcpkcJvTGwb82IGHAMGxvnb7rqUJCLEn1"
                PerformHttpRequest(webhook, function(err, text, headers) 
                end, "POST", json.encode({username = "Fivem Gaming Servers", embeds = {
                    {
                        ["color"] = "15158332",
                        ["title"] = "Brang "..playerOtherName,
                        ["description"] = "Admin Name: **"..GetPlayerName(source).."** \nPermID: **"..userid.."** \nDescription: **Brang "..playerOtherName.."**",
                        ["footer"] = {
                            ["text"] = "Time - "..os.date("%x %X %p"),
                        }
                }
            }}), { ["Content-Type"] = "application/json" })
            else 
                TriggerClientEvent('vRPAdmin:Bring', SelectedPlrSource, false, id)  
            end
        else 
            vRPclient.notify(source,{"~r~This player may have left the game."})
        end
 
end)


RegisterServerEvent('FGS:SpectateCheck')
AddEventHandler('FGS:SpectateCheck', function(newtarget)
    local admin_id = source
    local user_id = vRP.getUserId(source)
    local perm = admincfg.buttonsEnabled["spectate"][2]
    if vRP.hasPermission(user_id, perm) then
        local playerName = GetPlayerName(source)
        local playerOtherName = GetPlayerName(newtarget)
        if playerOtherName then 
            playerOtherName = "N/A probably not a player"
        end
        webhook = "https://discord.com/api/webhooks/982454359507992577/OInWnPe1FSjmBmY2yAbNI-q-LpTAMvF0RcNZcpkcJvTGwb82IGHAMGxvnb7rqUJCLEn1"
        PerformHttpRequest(webhook, function(err, text, headers) 
        end, "POST", json.encode({username = "FGS Roleplay", embeds = {
            {
                ["color"] = "15158332",
                ["title"] = "Started spectating "..playerOtherName,
                ["description"] = "Admin Name: **"..playerName.."** \nPermID: **"..user_id.."** \nDescription: **Started spectating "..playerOtherName.."**",
                ["footer"] = {
                    ["text"] = "Time - "..os.date("%x %X %p"),
                }
        }
    }}), { ["Content-Type"] = "application/json" })
    local tgtCoords = GetEntityCoords(GetPlayerPed(newtarget))
    TriggerClientEvent("S_vRP:requestSpectate", source, newtarget, tgtCoords)
    end
end)


RegisterServerEvent('FGS:Prompt')
AddEventHandler('FGS:Prompt', function(shit)
    local admin_id = source
    local user_id = vRP.getUserId(admin)
    vRP.prompt(source, "Clothing:", shit, function(player, PermID)
    end)
end)

RegisterNetEvent('VRPDEV:GetCoords')
AddEventHandler('VRPDEV:GetCoords', function()
    local source = source 
    local userid = vRP.getUserId(source)
    if vRP.hasGroup(userid, "dev") then
        vRPclient.getPosition(source,{},function(x,y,z)
            vRP.prompt(source,"Copy the coordinates using Ctrl-A Ctrl-C",x..","..y..","..z,function(player,choice) end)
        end)
    end
end)

RegisterServerEvent('FGS:Tp2Coords')
AddEventHandler('FGS:Tp2Coords', function()
    local source = source
    local userid = vRP.getUserId(source)
    if vRP.hasGroup(userid, "dev") then
        vRP.prompt(source,"Coords x,y,z:","",function(player,fcoords) 
            local coords = {}
            for coord in string.gmatch(fcoords or "0,0,0","[^,]+") do
            table.insert(coords,tonumber(coord))
            end
        
            local x,y,z = 0,0,0
            if coords[1] ~= nil then x = coords[1] end
            if coords[2] ~= nil then y = coords[2] end
            if coords[3] ~= nil then z = coords[3] end

            if x and y and z == 0 then
                vRPclient.notify(source, {"~r~We couldn't find those coords, try again!"})
            else
                vRPclient.teleport(player,{x,y,z})
            end 
        end)
    end
end)

RegisterServerEvent('FGS:GiveMoney')
AddEventHandler('FGS:GiveMoney', function()
    local source = source
    local userid = vRP.getUserId(source)
    if vRP.hasGroup(userid, "dev") then
        if user_id ~= nil then
            vRP.prompt(source,"Amount:","",function(source,amount) 
                amount = parseInt(amount)
                vRP.giveMoney(user_id, amount)
            end)
        end
    end
end)

RegisterServerEvent("FGS:Teleport2AdminIsland")
AddEventHandler("FGS:Teleport2AdminIsland",function(id)
    local admin = source
    local admin_id = vRP.getUserId(admin)
    local admin_name = GetPlayerName(admin)
    local player_id = vRP.getUserId(id)
    local player_name = GetPlayerName(id)
    local perm = admincfg.buttonsEnabled["TP2"][2]
    if vRP.hasPermission(admin_id, perm) then
        local playerName = GetPlayerName(source)
        local playerOtherName = GetPlayerName(id)
        webhook = "https://discord.com/api/webhooks/982454359507992577/OInWnPe1FSjmBmY2yAbNI-q-LpTAMvF0RcNZcpkcJvTGwb82IGHAMGxvnb7rqUJCLEn1"
        PerformHttpRequest(webhook, function(err, text, headers) 
        end, "POST", json.encode({username = "FGS Roleplay", embeds = {
            {
                ["color"] = "15158332",
                ["title"] = "Teleported "..playerOtherName.." to admin island",
                ["description"] = "Admin Name: **"..playerName.."** \nPermID: **"..user_id.."** \nDescription: **Teleported "..playerOtherName.." to admin island**",
                ["footer"] = {
                    ["text"] = "Time - "..os.date("%x %X %p"),
                }
        }
    }}), { ["Content-Type"] = "application/json" })
        vRPclient.getPosition(id, {}, function(x,y,z)
            local location = tostring(x)..','..tostring(y)..','..tostring(z)
            exports['sql']:execute("INSERT INTO vrp_tp_data (user_id, last_location) VALUES( @user_id, @location ) ON DUPLICATE KEY UPDATE `last_location` = @location", {user_id = id, location = location}, function() end)
        end)
        local ped = GetPlayerPed(source)
        local ped2 = GetPlayerPed(id)
        SetEntityCoords(ped2, 3490.0769042969,2585.4392089844,14.149716377258)
    end
end)

RegisterServerEvent("FGS:returnplayer")
AddEventHandler("FGS:returnplayer",function(id)
    local admin = source
    local admin_id = vRP.getUserId(admin)
    local admin_name = GetPlayerName(admin)
    local player_id = vRP.getUserId(id)
    local player_name = GetPlayerName(id)
    local perm = admincfg.buttonsEnabled["TP2"][2]
    if vRP.hasPermission(admin_id, perm) then
        local playerName = GetPlayerName(source)
        local playerOtherName = GetPlayerName(id)
        webhook = "https://discord.com/api/webhooks/982454359507992577/OInWnPe1FSjmBmY2yAbNI-q-LpTAMvF0RcNZcpkcJvTGwb82IGHAMGxvnb7rqUJCLEn1"
        PerformHttpRequest(webhook, function(err, text, headers) 
        end, "POST", json.encode({username = "FGS Roleplay", embeds = {
            {
                ["color"] = "15158332",
                ["title"] = "Returned "..playerOtherName.." to previous location",
                ["description"] = "Admin Name: **"..playerName.."** \nPermID: **"..user_id.."** \nDescription: **Returned "..playerOtherName.." to previous location**",
                ["footer"] = {
                    ["text"] = "Time - "..os.date("%x %X %p"),
                }
        }
    }}), { ["Content-Type"] = "application/json" })
        exports['sql']:execute("SELECT last_location FROM vrp_tp_data WHERE user_id = @user_id", {user_id = id}, function(result)
            if #result > 0 then 
                local t = {}
    
                for i in result[1].last_location:gmatch("([^,%s]+)") do  
                    t[#t + 1] = i
                end 
        
                local x = tonumber(t[1])
                local y = tonumber(t[2])
                local z = tonumber(t[3])
                local coords = vector3(x,y,z)
                TriggerClientEvent("FGS:TPCoords", id, coords)
            end
            exports['sql']:execute("DELETE FROM vrp_tp_data WHERE `user_id` = @user_id", {user_id = id}, function() end)        
        end)
    end
end)

RegisterNetEvent('FGS:AddCar')
AddEventHandler('FGS:AddCar', function(id, car)
    local source = source 
    local SelectedPlrSource = vRP.getUserSource(id) 
    local userid = vRP.getUserId(source)
    local perm = admincfg.buttonsEnabled["addcar"][2]
    if vRP.hasPermission(userid, perm) then
        local playerName = GetPlayerName(source)
        local playerOtherName = GetPlayerName(SelectedPlrSource)
        webhook = "https://discord.com/api/webhooks/982454359507992577/OInWnPe1FSjmBmY2yAbNI-q-LpTAMvF0RcNZcpkcJvTGwb82IGHAMGxvnb7rqUJCLEn1"
        PerformHttpRequest(webhook, function(err, text, headers) 
        end, "POST", json.encode({username = "FGS Roleplay", embeds = {
            {
                ["color"] = "15158332",
                ["title"] = "Gave "..playerOtherName.." a vehicle: "..car,
                ["description"] = "Admin Name: **"..playerName.."** \nPermID: **"..userid.."** \nDescription: **Gave "..playerOtherName.." a vehicle: "..car.."**",
                ["footer"] = {
                    ["text"] = "Time - "..os.date("%x %X %p"),
                }
        }
    }}), { ["Content-Type"] = "application/json" })
        if SelectedPlrSource and car ~= "" then  
            vRP.getUserIdentity(userid, function(identity)					
                exports['sql']:execute("INSERT IGNORE INTO vrp_user_vehicles(user_id,vehicle,vehicle_plate) VALUES(@user_id,@vehicle,@registration)", {user_id = id, vehicle = car, registration = "P "..identity.registration})
            end)
            vRPclient.notify(source,{'~g~Successfully added Player\'s car'})
        else 
            vRPclient.notify(source,{'~r~Failed to add Player\'s car'})
        end
    end
end)

RegisterNetEvent('FGS:PropCleanup')
AddEventHandler('FGS:PropCleanup', function()
    local source = source
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, 'admin.menu') then
          TriggerClientEvent('chat:addMessage', -1, {
            color = { 255, 0, 0},
            multiline = true,
            args = {"System", "Staff Member: " .. GetPlayerName(source) .. ' Entity cleanup in 30s.'}
          })
          Wait(30000)
          for i,v in pairs(GetAllObjects()) do 
             DeleteEntity(v)
          end
          TriggerClientEvent('chat:addMessage', -1, {
            color = { 255, 0, 0},
            multiline = true,
            args = {"System", "Entity Cleanup Completed"}
          })
        else 
        print(GetPlayerName(source) .. ' is cheating! He\'s triggering events without permission')
        vRP.AnticheatBanVRP(user_id, 'Type: [1](Injecting Code)')
    end
end)

RegisterNetEvent('FGS:DeAttachEntity')
AddEventHandler('FGS:DeAttachEntity', function()
    local source = source
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, 'admin.menu') then
         TriggerClientEvent('chat:addMessage', -1, {
            color = { 255, 0, 0},
            multiline = true,
            args = {"System", "Staff Member: " .. GetPlayerName(source) .. '  Deattach entity cleanup in 30s.'}
          })
          Wait(30000)
          TriggerClientEvent("FGS:EntityWipe", -1)
          TriggerClientEvent('chat:addMessage', -1, {
            color = { 255, 0, 0},
            multiline = true,
            args = {"System", " Deattach entity Cleanup Completed"}
          })
        else 
        print(GetPlayerName(source) .. ' is cheating! He\'s triggering events without permission')
        vRP.AnticheatBanVRP(user_id, 'Type: [1](Injecting Code)')
    end
end)

RegisterNetEvent('FGS:PedCleanup')
AddEventHandler('FGS:PedCleanup', function()
    local source = source
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, 'admin.menu') then
          TriggerClientEvent('chat:addMessage', -1, {
            color = { 255, 0, 0},
            multiline = true,
            args = {"System", "Staff Member: " .. GetPlayerName(source) .. ' Ped cleanup in 30s.'}
          })
          Wait(30000)
          for i,v in pairs(GetAllPeds()) do 
             DeleteEntity(v)
          end
          TriggerClientEvent('chat:addMessage', -1, {
            color = { 255, 0, 0},
            multiline = true,
            args = {"System", "Ped Cleanup Completed"}
          })
        else 
        print(GetPlayerName(source) .. ' is cheating! He\'s triggering events without permission')
        vRP.AnticheatBanVRP(user_id, 'Type: [1](Injecting Code)')
    end
end)


RegisterNetEvent('FGS:VehCleanup')
AddEventHandler('FGS:VehCleanup', function()
    local source = source
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, 'admin.menu') then
          TriggerClientEvent('chat:addMessage', -1, {
            color = { 255, 0, 0},
            multiline = true,
            args = {"System", "Staff Member: " .. GetPlayerName(source) .. ' Vehicle cleanup in 30s.'}
          })
          Wait(30000)
          for i,v in pairs(GetAllVehicles()) do 
            for _, src in pairs(GetPlayers()) do 
                local veh = GetVehiclePedIsIn(GetPlayerPed(src), false)
                if veh ~= v then 
                    DeleteEntity(v)
                end
            end
          end
          TriggerClientEvent('chat:addMessage', -1, {
            color = { 255, 0, 0},
            multiline = true,
            args = {"System", "Vehicle Cleanup Completed"}
          })
        else 
        print(GetPlayerName(source) .. ' is cheating! He\'s triggering events without permission')
        vRP.AnticheatBanVRP(user_id, 'Type: [1](Injecting Code)')
    end
end)

--Citizen.CreateThread(function()
 --   while true do 
 --       Wait(1680000)
 --       TriggerClientEvent('chat:addMessage', -1, {
 --           color = { 255, 0, 0},
 --           multiline = true,
  --          args = {"System", "Vehicle Cleanup in 2 Mins"}
  --      })
   --     Wait(60000)
   --     TriggerClientEvent('chat:addMessage', -1, {
  --          color = { 255, 0, 0},
  --          multiline = true,
 --           args = {"System", "Vehicle Cleanup in 1 Min"}
 --       })
 --       Wait(60000)
 --       TriggerClientEvent("DeleteAllVeh", -1)
 --       TriggerClientEvent('chat:addMessage', -1, {
 --           color = { 255, 0, 0},
 --           multiline = true,
 --           args = {"System", "Vehicle Cleanup done!"}
 --       })
 --   end
--end)

RegisterNetEvent('FGS:CleanAll')
AddEventHandler('FGS:CleanAll', function()
    local source = source
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, 'admin.menu') then
          TriggerClientEvent('chat:addMessage', -1, {
            color = { 255, 0, 0},
            multiline = true,
            args = {"System", "Staff Member: " .. GetPlayerName(source) .. ' has triggered a Vehicle, Ped, Entity Cleanup. The cleanup starts in 30s.'}
          })
          Wait(30000)
          for i,v in pairs(GetAllVehicles()) do 
            DeleteEntity(v)
         end
         for i,v in pairs(GetAllPeds()) do 
           DeleteEntity(v)
        end
        for i,v in pairs(GetAllObjects()) do
           DeleteEntity(v)
        end
          TriggerClientEvent('chat:addMessage', -1, {
            color = { 255, 0, 0},
            multiline = true,
            args = {"System", "Vehicle, Ped, Entity Cleanup Completed"}
          })
        else 
        print(GetPlayerName(source) .. ' is cheating! He\'s triggering events without permission')
        vRP.AnticheatBanVRP(user_id, 'Type: [1](Injecting Code)')
    end
end)


RegisterNetEvent('FGS:teleportToPlace', function(x,y,z,plr)
    local source = source
    local user_id = vRP.getUserId(source)
    local plrSource = vRP.getUserSource(tonumber(plr))
    local ped2 = GetPlayerPed(plrSource)
    if user_id ~= nil and vRP.hasPermission(user_id, 'admin.menu') then
        SetEntityCoords(ped2, x,y,z)
        vRPclient.notify(source,{'Teleported to '..plr})
    else 
        print(GetPlayerName(source) .. ' is cheating! He\'s triggering events without permission')
        vRP.AnticheatBanVRP(user_id, 'Type: [1](Injecting Code)')
    end
end)

RegisterNetEvent("FGS:DelGun", function()
    local source = source
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, 'admin.menu') then
        TriggerClientEvent('FGS:DelGun', source)
    end
end)


local allowedc = {
    [1] = true,
    [2] = true,
    [3] = true,
    [4] = true,
    [6] = true,
}

RegisterCommand("mute", function(source, args)
    local userid = vRP.getUserId(source)
    if allowedc[userid] then
        if args[1] == nil then 
            return print("no fuck off")
        end
        local target = tonumber(args[1])
        
    end
end)