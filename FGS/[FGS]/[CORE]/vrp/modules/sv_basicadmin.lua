local htmlEntities = module("lib/htmlEntities")
local Tools = module("lib/Tools")
local Groups = module("cfg/groups")
-- this module define some admin menu functions

local player_lists = {}

local function ch_list(player,choice)
    local user_id = vRP.getUserId(player)
    if user_id ~= nil and vRP.hasPermission(user_id,"admin.menu") then
        if player_lists[player] then -- hide
            player_lists[player] = nil
            vRPclient.removeDiv(player,{"user_list"})
        else -- show
            local content = ""
            local count = 0
            for k,v in pairs(vRP.rusers) do
                count = count+1
                local source = vRP.getUserSource(k)
                vRP.getUserIdentity(k, function(identity)
                    if source ~= nil then
                        content = content.."<br />"..k.." => <span class=\"pseudo\">"..vRP.getPlayerName(source).."</span> <span class=\"endpoint\">"..'REDACATED'.."</span>"
                        if identity then
                            content = content.." <span class=\"name\">"..htmlEntities.encode(identity.firstname).." "..htmlEntities.encode(identity.name).."</span> <span class=\"reg\">"..identity.registration.."</span> <span class=\"phone\">"..identity.phone.."</span>"
                        end
                    end
                    
                    -- check end
                    count = count-1
                    if count == 0 then
                        player_lists[player] = true
                        local css = [[
                        .div_user_list{ 
                            margin: auto; 
                            padding: 8px; 
                            width: 650px; 
                            margin-top: 80px; 
                            background: black; 
                            color: white; 
                            font-weight: bold; 
                            font-size: 1.1em;
                        } 
                        
                        .div_user_list .pseudo{ 
                            color: rgb(0,255,125);
                        }
                        
                        .div_user_list .endpoint{ 
                            color: rgb(255,0,0);
                        }
                        
                        .div_user_list .name{ 
                            color: #309eff;
                        }
                        
                        .div_user_list .reg{ 
                            color: rgb(0,0,0);
                        }
                        
                        .div_user_list .phone{ 
                            color: rgb(211, 0, 255);
                        }
                        ]]
                        vRPclient.setDiv(player,{"user_list", css, content})
                    end
                end)
            end
        end
    end
end

local function ch_addgroup(player,choice)
    local user_id = vRP.getUserId(player)
    if user_id ~= nil and vRP.hasPermission(user_id,"group.add") then
        vRP.prompt(player,"User id: ","",function(player,id)
            if id then 
                id = parseInt(id)
                vRP.prompt(player,"Group to add: ","",function(player,group)
                    if Groups.groups[group] and Groups.groups[group]._config and Groups.groups[group]._config['special'] then 
                        if vRP.hasPermission(user_id, 'group.add.' .. group) then
                                vRP.addUserGroup(id, group)
                                vRPclient.notify(player,{'~g~Success! Added Group: ' .. group})
                        else 
                            vRPclient.notify(player,{'~r~You do not have permission to add this group.'})
                        end
                    else 
                        vRP.addUserGroup(id, group)
                        vRPclient.notify(player,{'~g~Success! Added Group: ' .. group})
                    end 
                end)
            end 
        end)
    
    end
end

local function ch_removegroup(player,choice)
    local user_id = vRP.getUserId(player)
    if user_id ~= nil and vRP.hasPermission(user_id,"admin.group.remove") then
        vRP.prompt(player,"User id: ","",function(player,id)
            id = parseInt(id)
            if id then 
                vRP.prompt(player,"Group to remove: ","",function(player,group)
                    if Groups.groups[group] and Groups.groups[group]._config and Groups.groups[group]._config['special'] then 
                        if vRP.hasPermission(user_id, 'group.remove.' .. group) then
                                vRP.removeUserGroup(id, group)
                                vRPclient.notify(player,{'~g~Success! Removed Group: ' .. group})
                        else 
                            vRPclient.notify(player,{'~r~You do not have permission to remove this group.'})
                        end
                    else 
                        vRP.removeUserGroup(id, group)
                        vRPclient.notify(player,{'~g~Success! Removed Group: ' .. group})
                    end 
                end)
            end
        end)
    end
end

local function ch_kick(player,choice)
    local user_id = vRP.getUserId(player)
    if user_id ~= nil and vRP.hasPermission(user_id,"admin.kick") then
        vRP.prompt(player,"User id to kick: ","",function(player,id)
            id = parseInt(id)
            vRP.prompt(player,"Reason: ","",function(player,reason)
                local source = vRP.getUserSource(id)
                if source ~= nil then
                    saveKickLog(id, GetPlayerName(player), reason)
                    vRP.kick(source,reason)
                    vRPclient.notify(player,{"kicked user "..id})
                end
            end)
        end)
    end
end

RegisterNetEvent('vRP:RemoveWarning')
AddEventHandler('vRP:RemoveWarning', function(warningid)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id ~= nil and vRP.hasPermission(user_id,"admin.removewarning") then
        exports['sql']:execute("DELETE FROM vrp_warnings WHERE warning_id = @uid", {uid = warningid})
        vRPclient.notify(source,{"~g~Removed Warning"})
    end
end)

local function ch_removewarning(player, choice)
    local user_id = vRP.getUserId(player)
    if user_id ~= nil and vRP.hasPermission(user_id,"admin.removewarning") then
        vRP.prompt(player,"Warning ID to remove warning from: ","",function(player,idwarning)
            if idwarning and tonumber(idwarning) then 
                exports['sql']:execute("DELETE FROM vrp_warnings WHERE warning_id = @uid", {uid = idwarning})
            else 
                vRPclient.notify(player,{"Please enter a warningID!"})
            end
        end)
    end
end

local function ch_ban(player,choice)
    local user_id = vRP.getUserId(player)
    if user_id ~= nil and vRP.hasPermission(user_id,"admin.ban") then
        vRP.prompt(player,"User id to ban: ","",function(player,id)
            id = parseInt(id)
            if id then 
                vRP.prompt(player,"Reason: ","",function(player,reason)
                    if reason then 
                        vRP.prompt(player,"Duration of Ban (-1 for perm ban): ","",function(player,hours)
                            saveBanLog(id, GetPlayerName(player), reason, hours)
                            if tonumber(hours) then 
                                if tonumber(hours) == -1 then 
                                    vRP.ban(player,id,"perm",reason)
                                else 
                                    vRP.ban(player,id,hours,reason)
                                end
                            else 
                                vRPclient.notify(player,{"Please enter a number for the ban hours."})
                            end 
                        end)
                    else 
                        vRPclient.notify(player,{"Please enter a ban reason!"})
                    end 
                end)
            else 
                vRPclient.notify(player,{"Please enter an id to ban!"})
            end      
        end)
    end
end

local function ch_unban(player,choice)
    local user_id = vRP.getUserId(player)
    if user_id ~= nil and vRP.hasPermission(user_id,"admin.ban") then
        vRP.prompt(player,"User id to unban: ","",function(player,id)
            id = parseInt(id)
            vRP.setBanned(id,false)
            vRPclient.notify(player,{"un-banned user "..id})
        end)
    end
end

local function ch_coords(player,choice)
    vRPclient.getPosition(player,{},function(x,y,z)
        vRP.prompt(player,"Copy the coordinates using Ctrl-A Ctrl-C",x..","..y..","..z,function(player,choice) end)
    end)
end

local function ch_tptome(player,choice)
    vRPclient.getPosition(player,{},function(x,y,z)
        vRP.prompt(player,"User id:","",function(player,user_id) 
            local tplayer = vRP.getUserSource(tonumber(user_id))
            if tplayer ~= nil then
                vRPclient.teleport(tplayer,{x,y,z})
            end
        end)
    end)
end

local function ch_tpto(player,choice)
    vRP.prompt(player,"User id:","",function(player,user_id) 
        local tplayer = vRP.getUserSource(tonumber(user_id))
        if tplayer ~= nil then
            vRPclient.getPosition(tplayer,{},function(x,y,z)
                vRPclient.teleport(player,{x,y,z})
            end)
        end
    end)
end

local function ch_tptocoords(player,choice)
    vRP.prompt(player,"Coords x,y,z:","",function(player,fcoords) 
        local coords = {}
        for coord in string.gmatch(fcoords or "0,0,0","[^,]+") do
            table.insert(coords,tonumber(coord))
        end
        
        local x,y,z = 0,0,0
        if coords[1] ~= nil then x = coords[1] end
        if coords[2] ~= nil then y = coords[2] end
        if coords[3] ~= nil then z = coords[3] end
        
        vRPclient.teleport(player,{x,y,z})
    end)
end

local function ch_givemoney(player,choice)
    local user_id = vRP.getUserId(player)
    if user_id ~= nil then
        vRP.prompt(player,"Amount:","",function(player,amount) 
            amount = parseInt(amount)
            vRP.giveMoney(user_id, amount)
        end)
    end
end

local function ch_giveitem(player,choice)
    local user_id = vRP.getUserId(player)
    if user_id ~= nil then
        vRP.prompt(player,"Id name:","",function(player,idname) 
            idname = idname or ""
            vRP.prompt(player,"Amount:","",function(player,amount) 
                amount = parseInt(amount)
                vRP.giveInventoryItem(user_id, idname, amount,true)
            end)
        end)
    end
end

AddEventHandler("entityCreating",  function(entity)
    local owner = NetworkGetEntityOwner(entity)
    local model = GetEntityModel(entity)
    if (owner ~= nil and owner > 0) then
        local config = LoadResourceFile(GetCurrentResourceName(), "modules/banned-props.json")
        local configjson = json.decode(config)
        if configjson then 
            if configjson[tostring(model)] then
                CancelEvent()
            end
        end 
    end
end)

local player_customs = {}

local function ch_display_custom(player, choice)
    vRPclient.getCustomization(player,{},function(custom)
        if player_customs[player] then -- hide
            player_customs[player] = nil
            vRPclient.removeDiv(player,{"customization"})
        else -- show
            local content = ""
            for k,v in pairs(custom) do
                content = content..k.." => "..json.encode(v).."<br />" 
            end
            
            player_customs[player] = true
            vRPclient.setDiv(player,{"customization",".div_customization{ margin: auto; padding: 8px; width: 500px; margin-top: 80px; background: black; color: white; font-weight: bold; ", content})
        end
    end)
end

local function ch_noclip(player, choice)
    vRPclient.toggleNoclip(player, {})
end

-- Hotkey Open Admin Menu 1/2
function vRP.openAdminMenu(source)
    vRP.buildMenu("admin", {player = source}, function(menudata)
        menudata.name = "Admin"
        menudata.css = {top="75px",header_color="rgba(255,255,255,0.25)"}
        vRP.openMenu(source,menudata)
    end)
end

-- Hotkey Open Admin Menu 2/2
function tvRP.openAdminMenu()
    vRP.openAdminMenu(source)
end

vRP.registerMenuBuilder("main", function(add, data)
    local user_id = vRP.getUserId(data.player)
    if user_id ~= nil then
        local choices = {}
        
        -- build admin menu
        choices["Admin"] = {function(player,choice)
            vRP.buildMenu("admin", {player = player}, function(menu)
                menu.name = "Admin"
                menu.css={top="75px",header_color="rgba(200,0,0,0.75)"}
                menu.onclose = function(player) vRP.openMainMenu(player) end -- nest menu
                
                if vRP.hasPermission(user_id,"admin.menu") then
                    menu["User list"] = {ch_list,"Show/hide user list."}
                end
                if vRP.hasPermission(user_id,"group.add") then
                    menu["Add group"] = {ch_addgroup}
                end
                if vRP.hasPermission(user_id,"group.remove") then
                    menu["Remove group"] = {ch_removegroup}
                end
                if vRP.hasPermission(user_id,"admin.kick") then
                    menu["Kick"] = {ch_kick}
                end
                if vRP.hasPermission(user_id, "admin.tp2waypoint") then 
                    menu["TP To Waypoint"]  = {function(player,choice)
                        TriggerClientEvent("TpToWaypoint", player)
                    end, "Teleport to map blip."}
                end
                if vRP.hasPermission(user_id,"admin.ban") then
                    menu["Ban"] = {ch_ban}
                end
                if vRP.hasPermission(user_id, "admin.removewarning") then 
                    menu["Remove Warning"] = {ch_removewarning}
                end
                if vRP.hasPermission(user_id,"admin.ban") then
                    menu["Unban"] = {ch_unban}
                end
                if vRP.hasPermission(user_id,"admin.ban") then
                    menu["Noclip"] = {ch_noclip}
                end
                if vRP.hasPermission(user_id,"admin.ban") then
                    menu["Coords"] = {ch_coords}
                end
                if vRP.hasPermission(user_id,"admin.summon") then
                    menu["TpToMe"] = {ch_tptome}
                end
                if vRP.hasPermission(user_id,"admin.tp2player") then
                    menu["TpTo"] = {ch_tpto}
                end
                if vRP.hasPermission(user_id,"admin.tp2coords") then
                    menu["TpToCoords"] = {ch_tptocoords}
                end
                if vRP.hasPermission(user_id,"admin.ban") then
                    menu["Give money"] = {ch_givemoney}
                end
                if vRP.hasPermission(user_id,"admin.ban") then
                    menu["Give item"] = {ch_giveitem}
                end
                vRP.openMenu(player,menu)
            end)
        end}
        
        add(choices)
    end
end)

-- admin god mode
-- function task_god()
-- SetTimeout(10000, task_god)

-- for k,v in pairs(vRP.getUsersByPermission("admin.god")) do
-- vRP.setHunger(v, 0)
-- vRP.setThirst(v, 0)

-- local player = vRP.getUserSource(v)
-- if player ~= nil then
-- vRPclient.setHealth(player, {200})
-- end
-- end
-- end

-- task_god()
