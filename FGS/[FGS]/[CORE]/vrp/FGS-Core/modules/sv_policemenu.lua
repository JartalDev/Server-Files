local lang = vRP.lang
local cfg = module("cfg/police")

RegisterServerEvent('FGS:OpenPoliceMenu')
AddEventHandler('FGS:OpenPoliceMenu', function()
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id ~= nil and vRP.hasPermission(user_id, "police.menu") then
        TriggerClientEvent("FGS:PoliceMenuOpened", source)
    elseif user_id ~= nil and vRP.hasPermission(user_id, "clockon.menu") then
      vRPclient.notify(source,{"You are not on duty"})
    else
      print("You are not a part of the MET Police")
    end
end)

RegisterServerEvent('FGS:ActivateZone')
AddEventHandler('FGS:ActivateZone', function(message, speed, radius, x, y, z)
    TriggerClientEvent('chat:addMessage', -1, {
        template = '<div style="padding: 0.5vw; margin: 0.4vw; background-color: rgba(171, 7, 7, 0.6); border-radius: 7px;"><i class="fas fa-exclamation-triangle"></i> MET Police: {0}</div>',
        args = { message }
    })
    TriggerClientEvent('FGS:ZoneCreated', -1, speed, radius, x, y, z)
end)

RegisterServerEvent('FGS:RemoveZone')
AddEventHandler('FGS:RemoveZone', function(blip)
    TriggerClientEvent('FGS:RemovedBlip', -1)
end)

RegisterServerEvent('FGS:Drag')
AddEventHandler('FGS:Drag', function()
    player = source
    local user_id = vRP.getUserId(player)
    if user_id ~= nil and vRP.hasPermission(user_id, "police.menu") then
        vRPclient.getNearestPlayer(player,{2},function(nplayer)
        if nplayer ~= nil then
            local nuser_id = vRP.getUserId(nplayer)
            if nuser_id ~= nil then
            vRPclient.isHandcuffed(nplayer,{},function(handcuffed)
                if handcuffed then
                    TriggerClientEvent("FGS:DragPlayer", nplayer, player)
                else
                    vRPclient.notify(player,{"~r~Player is not handcuffed."})
                end
            end)
            else
                vRPclient.notify(player,{"~r~There is no player nearby"})
            end
            else
                vRPclient.notify(player,{"~r~There is no player nearby"})
            end
        end)
    end
end)

RegisterServerEvent('FGS:Handcuff')
AddEventHandler('FGS:Handcuff', function()
    player = source
    local user_id = vRP.getUserId(player)
    if user_id ~= nil and vRP.hasPermission(user_id, "police.menu") then
        vRPclient.getNearestPlayer(player,{2},function(nplayer)
            local nuser_id = vRP.getUserId(nplayer)
            if nuser_id ~= nil then
              TriggerClientEvent('mita:arrestonway', nplayer, source) 
              TriggerClientEvent('radu:arrest', source)  
                --TriggerClientEvent("esx_cuffanimation:arrest", source)
                vRPclient.toggleHandcuff(nplayer, {}, source)
                vRP.closeMenu(nplayer)
            else
                vRPclient.notify(player,{"~r~There is no player nearby"})
            end
        end)
    end
end)


local unjailed = {}
function jail_clock(target_id,timer)
    local target = vRP.getUserSource(tonumber(target_id))
    local users = vRP.getUsers()
    local online = false
    local triedtoescape = false 
    for k,v in pairs(users) do
    	if tonumber(k) == tonumber(target_id) then
    	    online = true
    	end
    end
    if online then
        if timer>0 then
            vRPclient.notify(target, {"~r~Remaining time: " .. timer .. " minute(s)."})
            if timer > 1 then 
                if #(GetEntityCoords(GetPlayerPed(target)) - vec3(1779.5057373047,2583.791015625,45.7978515625)) > 700 then
                    print("#(GetEntityCoords(GetPlayerPed(target)) - vec3(1779.5057373047,2583.791015625,45.7978515625))", #(GetEntityCoords(GetPlayerPed(target)) - vec3(1779.5057373047,2583.791015625,45.7978515625)))
                    Wait(2500)
                    SetEntityCoords(GetPlayerPed(target), vec3(1779.5474853516,2573.4880371094,48.579395294189)) 
                    vRPclient.notify(target, {"~r~ Why you escaping?\nAdded 2 minute."})
                    vRP.setUData(tonumber(target_id),"vRP:jail:time",json.encode(timer + 2))
                    triedtoescape = true
                end
            end

            if not triedtoescape then 
                vRP.setUData(tonumber(target_id),"vRP:jail:time",json.encode(timer))
            end

            SetTimeout(60*1000, function()
            	for k,v in pairs(unjailed) do -- check if player has been unjailed by cop or admin
            	    if v == tonumber(target_id) then
                    unjailed[v] = nil
            	        timer = 0
            	    end
            	end
                jail_clock(tonumber(target_id),timer-1)
            end) 
        else 
            vRPclient.loadFreeze(target,{false,true,true})
            SetTimeout(15000,function()
            	vRPclient.loadFreeze(target,{false,false,false})
            end)
            vRPclient.teleport(target,{1839.8804931641,2591.2065429688,45.952293395996}) -- teleport to outside jail
            vRPclient.setHandcuffed(target,{false})
            vRPclient.notify(target,{"~b~You have been set free Good Luck."})
            vRP.setUData(tonumber(target_id),"vRP:jail:time",json.encode(-1))
        end
    end
end
local cells = {
    {1785.4562988281,2568.3791503906,50.549686431885},
    {1781.8703613281,2568.80859375,50.549671173096},
    {1777.7906494141,2568.4133300781,50.54963684082},
    {1789.8583984375,2582.5827636719,45.797832489014},
    {1789.5959472656,2586.1040039063,45.797840118408},
}

RegisterServerEvent('FGS:JailPlayer')
AddEventHandler('FGS:JailPlayer', function()
    player = source
    local user_id = vRP.getUserId(player)
    if user_id ~= nil and vRP.hasPermission(user_id, "police.menu") then
    vRPclient.getNearestPlayers(player,{5},function(nplayers) 
      local user_list = "a"
      for k,v in pairs(nplayers) do
        user_list = user_list .. "[" .. vRP.getUserId(k) .. "]" .. GetPlayerName(k) .. " | "
      end 
      if user_list ~= "" then
        vRP.prompt(player,"Players Nearby:" .. user_list,"",function(player,target_id) 
          if target_id ~= nil and target_id ~= "" then 
            vRP.prompt(player,"Jail Time in minutes:","1",function(player,jail_time)
              if jail_time ~= nil and jail_time ~= "" then 
                local target = vRP.getUserSource(tonumber(target_id))
                if target ~= nil then
                  if tonumber(jail_time) > 60 then
                      jail_time = 60
                  end
                  if tonumber(jail_time) < 1 then
                    jail_time = 1
                  end
            
                  vRPclient.isHandcuffed(target,{}, function(handcuffed)  
                    if true then 
                        vRPclient.loadFreeze(target,{false,true,true})
                      SetTimeout(15000,function()
                        vRPclient.loadFreeze(target,{false,false,false})
                      end)
                      local location = cells[math.random(1, #cells)]
                      vRPclient.teleport(target,{location[1], location[2], location[3]}) -- teleport to inside jail
                      vRPclient.notify(target,{"~r~You have been sent to jail."})
                      vRPclient.notify(player,{"~b~You sent a player to jail."})
                      PDLog("Jail", "```Police ID: " .. user_id .. "\n\nTarget ID: " .. target_id .. "\n\nAmount: " .. jail_time .. "Mins```")
                      jail_clock(tonumber(target_id),tonumber(jail_time))
                    else
                      vRPclient.notify(player,{"~r~That player is not handcuffed."})
                    end
                  end)
                else
                  vRPclient.notify(player,{"~r~That ID seems invalid."})
                end
              else
                vRPclient.notify(player,{"~r~The jail time can't be empty."})
              end
            end)
          else
            vRPclient.notify(player,{"~r~No player ID selected."})
          end 
        end)
      else
        vRPclient.notify(player,{"~r~No player nearby."})
      end 
    end)
    else
        print(user_id.." could be modding")
    end
end)

RegisterServerEvent('FGS:UnJailPlayer')
AddEventHandler('FGS:UnJailPlayer', function()
    player = source
    local user_id = vRP.getUserId(player)
    if user_id ~= nil and vRP.hasPermission(user_id, "police.menu") then
	vRP.prompt(player,"Player ID:","",function(player,target_id) 
	  if target_id ~= nil and target_id ~= "" then 
		vRP.getUData(tonumber(target_id),"vRP:jail:time",function(value)
		  if value ~= nil then
		  custom = json.decode(value)
			if custom ~= nil then
			  local user_id = vRP.getUserId(player)
			  if tonumber(custom) > 0 or vRP.hasPermission(user_id,"admin.easy_unjail") then
	            local target = vRP.getUserSource(tonumber(target_id))
				if target ~= nil then
	              unjailed[target] = tonumber(target_id)
                  PDLog("UnJail", "```Police ID: " .. user_id .. "\n\nTarget ID: " .. target_id .. "```")
				  vRPclient.notify(player,{"~g~Target will be released soon."})
				  vRPclient.notify(target,{"~g~Someone lowered your sentence."})
				else
				  vRPclient.notify(player,{"~r~That ID seems invalid."})
				end
			  else
				vRPclient.notify(player,{"~r~Target is not jailed."})
			  end
			end
		  end
		end)
      else
        vRPclient.notify(player,{"~r~No player ID selected."})
      end 
  end)
  else
    print(user_id.." Could be modder")
  end
end)

RegisterServerEvent('FGS:Fine')
AddEventHandler('FGS:Fine', function()
    player = source
    local user_id = vRP.getUserId(player)
    if user_id ~= nil and vRP.hasPermission(user_id, "police.menu") then
    vRPclient.getNearestPlayers(player,{5},function(nplayers) 
      local user_list = ""
      for k,v in pairs(nplayers) do
        user_list = user_list .. "[" .. vRP.getUserId(k) .. "]" .. GetPlayerName(k) .. " | "
      end 
      if user_list ~= "" then
        vRP.prompt(player,"Players Nearby:" .. user_list,"",function(player,target_id) 
          if target_id ~= nil and target_id ~= "" then 
            vRP.prompt(player,"Fine amount:","100",function(player,fine)
              if fine ~= nil and fine ~= "" then 
                vRP.prompt(player,"Fine reason:","",function(player,reason)
                  if reason ~= nil and reason ~= "" then 
                    local target = vRP.getUserSource(tonumber(target_id))
                    if target ~= nil then
                      if tonumber(fine) > 100000 then
                          fine = 100000
                      end
                      if tonumber(fine) < 100 then
                        fine = 100
                      end
                
                      if vRP.tryFullPayment(tonumber(target_id), tonumber(fine)) then
                        PDLog("Fine", "```Police ID: " .. user_id .. "\n\nTarget ID: " .. target_id .. "\n\nAmount: " .. fine .. "\n\nReason: ".. reason .. "```")
                        vRPclient.notify(player,{lang.police.menu.fine.fined({reason,fine})})
                        vRPclient.notify(target,{lang.police.menu.fine.notify_fined({reason,fine})})
                        local user_id = vRP.getUserId(player)
                        vRP.closeMenu(player)
                      else
                        vRPclient.notify(player,{lang.money.not_enough()})
                      end
                    else
                      vRPclient.notify(player,{"~r~That ID seems invalid."})
                    end
                  else
                    vRPclient.notify(player,{"~r~You can't fine for no reason."})
                  end
                end)
              else
                vRPclient.notify(player,{"~r~Your fine has to have a value."})
              end
            end)
          else
            vRPclient.notify(player,{"~r~No player ID selected."})
          end 
        end)
      else
        vRPclient.notify(player,{"~r~No player nearby."})
      end 
    end)
  else
    print(user_id.." Could be modder")
  end
end)

RegisterNetEvent("FGS:PutPlrInVeh")
AddEventHandler("FGS:PutPlrInVeh", function()
    player = source
    local user_id = vRP.getUserId(player)
    if user_id ~= nil and vRP.hasPermission(user_id, "police.menu") then
    vRPclient.getNearestPlayer(player,{2},function(nplayer)
      local nuser_id = vRP.getUserId(nplayer)
      if nuser_id ~= nil then
        vRPclient.isHandcuffed(nplayer,{}, function(handcuffed)  -- check handcuffed
          if handcuffed then
            vRPclient.putInNearestVehicleAsPassenger(nplayer, {5})
          else
            vRPclient.notify(player,{"person not cuffed"})
          end
        end)
      else
        vRPclient.notify(player,{"no one near"})
      end
    end)
  else
    print(user_id.." Could be modder")
  end
end)

RegisterNetEvent("FGS:TakeOutOfVehicle")
AddEventHandler("FGS:TakeOutOfVehicle", function()
    player = source
    local user_id = vRP.getUserId(player)
    if user_id ~= nil and vRP.hasPermission(user_id, "police.menu") then
    vRPclient.getNearestPlayer(player,{5},function(nplayer)
        local nuser_id = vRP.getUserId(nplayer)
        if nuser_id ~= nil then
        vRPclient.isHandcuffed(nplayer,{}, function(handcuffed)  -- check handcuffed
            if handcuffed then
            vRPclient.ejectVehicle(nplayer, {})
            else
            vRPclient.notify(player,{"person not cuffed"})
            end
        end)
        else
        vRPclient.notify(player,{"no one near"})
        end
    end)
    else
        print(user_id.." Could be modder")
    end
end)

RegisterNetEvent("FGS:SearchPlayer")
AddEventHandler("FGS:SearchPlayer", function()
    player = source
    local user_id = vRP.getUserId(player)
    if user_id ~= nil and vRP.hasPermission(user_id, "police.menu") then
      vRPclient.getNearestPlayer(player,{3},function(nplayer)
          local nuser_id = vRP.getUserId(nplayer)
          if nuser_id ~= nil then
            vRPclient.notify(nplayer,{lang.police.menu.check.checked()})
            vRPclient.getWeapons(nplayer,{},function(weapons)
              -- prepare display data (money, items, weapons)
              local money = vRP.getMoney(nuser_id)
              local items = ""
              local data = vRP.getUserDataTable(nuser_id)
              if data and data.inventory then
                for k,v in pairs(data.inventory) do
                  local item = vRP.items[k]
                  if item then
                    items = items.."<br />"..item.name.." ("..v.amount..")"
                  end
                end
              end
    
              vRPclient.giveWeapons(nplayer,{{},true})
            end)
          else
            vRPclient.notify(player,{lang.common.no_player_near()})
          end
      end)
    end
end)


RegisterNetEvent("FGS:Search")
AddEventHandler("FGS:Search", function()
    local source = source 
    vRPclient.getNearestPlayer(source, {5}, function(nplayer)
        local nuser_id = vRP.getUserId(nplayer)
        if nuser_id ~= nil then
            vRPclient.notify(nplayer,{lang.police.menu.check.checked()})
                vRPclient.getWeapons(nplayer,{},function(weapons)
                -- prepare display data (money, items, weapons)
                local money = vRP.getMoney(nuser_id)
                local items = ""
                local data = vRP.getUserDataTable(nuser_id)
                if data and data.inventory then
                    for k,v in pairs(data.inventory) do
                        local item = vRP.items[k]
                        if item then
                            items = items.."<br />"..item.name.." ("..v.amount..")"
                        end
                    end
                end

                local weapons_info = ""
                for k,v in pairs(weapons) do
                    weapons_info = weapons_info.."<br />"..k.." ("..v.ammo..")"
                end
              
                vRPclient.setDiv(source, {"police_check",".div_police_check{ background-color: rgba(0,0,0,0.75); color: white; font-weight: bold; width: 500px; padding: 10px; margin: auto; margin-top: 150px; }",lang.police.menu.check.info({money, items, weapons_info})})
                 -- request to hide div
                vRP.request(source, lang.police.menu.check.request_hide(), 1000, function(source, ok)
                    vRPclient.removeDiv(source,{"police_check"})
                end)
            end)
        else
            vRPclient.notify(source,{lang.common.no_player_near()})
        end
    end)
end)



AddEventHandler("vRP:playerSpawn", function(user_id, source, first_spawn) 
    local target = vRP.getUserSource(user_id)
    SetTimeout(35000,function()
        local custom = {}
        vRP.getUData(user_id,"vRP:jail:time",function(value)
            if value ~= nil then
                custom = json.decode(value)
                if custom ~= nil then
                  if tonumber(custom) then 
                    if tonumber(custom) > 0 then
                      vRPclient.loadFreeze(target,{false,true,true})
                      SetTimeout(15000,function()
                          vRPclient.loadFreeze(target,{false,false,false})
                      end)
                      local location = cells[math.random(1, #cells)]
                      vRPclient.teleport(target,{location[1], location[2], location[3]}) -- teleport to inside jail                        vRPclient.notify(target,{"~r~Finish your sentence."})
                      jail_clock(tonumber(user_id),tonumber(custom))
                    end
                  end
                end
            end
        end)
    end)
end)


--blips


local dutyTable = {}

Citizen.CreateThread(function()
    while true do
        local sendTable = {}
        for k, v in pairs(dutyTable) do
            local coords = GetEntityCoords(GetPlayerPed(k))
            local userid = vRP.getUserId(k)
            local tempVar = v
            tempVar.playerId = k
            tempVar.coords = coords
            table.insert(sendTable, tempVar)
        end

        for player, kekw in pairs(dutyTable) do
            TriggerClientEvent('District_blips:receiveData', player, sendTable)
        end
        Citizen.Wait(1000)
    end
end)

RegisterNetEvent('District_blips:setDuty')
AddEventHandler('District_blips:setDuty', function(onDuty)
    local src = source

    if onDuty then
        local user_id = vRP.getUserId(src)

        if vRP.hasPermission(user_id, "police.menu") then
            dutyTable[src] = {
                name = GetPlayerName(src),
                blipcolour = 29
            }
            
            log('Setting on duty '..GetPlayerName(src))

        elseif vRP.hasPermission(user_id, "emergency.service") then
            dutyTable[src] = {
                name = GetPlayerName(src),
                blipcolour = 2
            }
        end
    else
        if dutyTable[src] then
            log(src..' Setting off-duty2')
            dutyTable[src] = nil
            for k, v in pairs(dutyTable) do
                TriggerClientEvent('District_blips:removeUser', k, src)
            end
        else
            log(src..' Tried to set off duty when off duty, wth')
        end
    end
end)


AddEventHandler('playerDropped', function(reason)
    local src = source
    if dutyTable[src] then
        dutyTable[src] = nil
        for k, v in pairs(dutyTable) do
            TriggerClientEvent('District_blips:removeUser', k, src)
        end
    end
end)

AddEventHandler('vRP:playerLeaveGroup', function(user_id, group, gtype)
    local src = vRP.getUserSource(user_id)

    if dutyTable[src] then
        dutyTable[src] = nil
        for k, v in pairs(dutyTable) do
            TriggerClientEvent('District_blips:removeUser', k, src)
        end
    end
end)

function log(...)
    if false then
        print('^3[District_blips]^0', ...)
    end
end


Citizen.CreateThread(function()
    while true do
        local sendTable = {}
        for k, v in pairs(GetPlayers()) do
            local coords = GetEntityCoords(GetPlayerPed(v))
            local userid = vRP.getUserId(v)
            local tempVar = {}
            tempVar.playerId = v
            tempVar.name = GetPlayerName(v)
            tempVar.blipcolour = 0
            tempVar.coords = coords
            table.insert(sendTable, tempVar)
        end
        Citizen.Wait(1000)
    end
end)


function tvRP.GetWhitelistJob()
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, "police.menu") or vRP.hasPermission(user_id, "emergency.service") then
        return true 
    else
        return false 
    end
end


local webhooks = {
    ["Fine"] = "https://discord.com/api/webhooks/982456321267867678/8qmrHsrn55D5aZr0sAKPjFI5bFooaUIpyTwgbSwBwvYEUpWDZnakNI5znqX9YIg7_a_9",
    ["Jail"] = "https://discord.com/api/webhooks/982456321267867678/8qmrHsrn55D5aZr0sAKPjFI5bFooaUIpyTwgbSwBwvYEUpWDZnakNI5znqX9YIg7_a_9",
    ["UnJail"] = "https://discord.com/api/webhooks/982456321267867678/8qmrHsrn55D5aZr0sAKPjFI5bFooaUIpyTwgbSwBwvYEUpWDZnakNI5znqX9YIg7_a_9"
}

function PDLog(type, message)
    local webhook = webhooks[type]
    PerformHttpRequest(webhook, function(err, text, headers) 
    end, "POST", json.encode({username = "FGS Roleplay", embeds = {
        {
            ["color"] = "15158332",
            ["title"] = type .. " Logs",
            ["description"] = message,
            ["footer"] = {
                ["text"] = "Time - "..os.date("%x %X %p"),
            }
    }
    }}), { ["Content-Type"] = "application/json" })
end