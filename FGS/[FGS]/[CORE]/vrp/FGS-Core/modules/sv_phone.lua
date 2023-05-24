local cfg_inventory = module("FGS-CARS", "cfg/inventory")
local lang = vRP.lang

RegisterServerEvent("FGS:AskID")
AddEventHandler("FGS:AskID",function()
    local player = source

    vRPclient.getNearestPlayer(player,{3},function(nplayer)
      local nuser_id = vRP.getUserId(nplayer)
      if nuser_id ~= nil then
        vRPclient.notify(player,{lang.police.menu.askid.asked()})
        vRP.request(nplayer, lang.police.menu.askid.request(), 15,function(nplayer,ok)
          if ok then
            vRP.getUserIdentity(nuser_id, function(identity)
              if identity then
                -- display identity and business
                local name = identity.name
                local firstname = identity.firstname
                local age = identity.age
                local phone = identity.phone
                local registration = identity.registration
                local bname = ""
                local bcapital = 0
                local home = ""
                local number = ""
  
                vRP.getUserAddress(nuser_id, function(address)
                  if address then
                    home = address.home
                    number = address.number
                  end

                  local content = lang.police.identity.info({name,firstname,age,registration,phone,bname,bcapital,home,number})
                  vRPclient.setDiv(player,{"police_identity",".div_police_identity{ background-color: rgba(0,0,0,0.75); color: white; font-weight: bold; width: 500px; padding: 10px; margin: auto; margin-top: 150px; }",content})
                  -- request to hide div
                  vRP.request(player, lang.police.menu.askid.request_hide(), 1000, function(player,ok)
                    vRPclient.removeDiv(player,{"police_identity"})
                  end)
                end)
              end
            end)
          else
            vRPclient.notify(player,{lang.common.request_refused()})
          end
        end)
      else
        vRPclient.notify(player,{lang.common.no_player_near()})
      end
    end)
end)



local function ch_vehicle(player,choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil then
    -- check vehicle
    vRPclient.getNearestOwnedVehicle(player,{7},function(ok,vtype,name)
      if ok then
        -- build vehicle menu
        vRP.buildMenu("vehicle", {user_id = user_id, player = player, vtype = vtype, vname = name}, function(menu)
          menu.name=lang.vehicle.title()
          menu.css={top="75px",header_color="rgba(255,125,0,0.75)"}

          for k,v in pairs(veh_actions) do
            menu[k] = {function(player,choice) v[1](user_id,player,vtype,name) end, v[2]}
          end

          vRP.openMenu(player,menu)
        end)
      else
        vRPclient.notify(player,{lang.vehicle.no_owned_near()})
      end
    end)
  end
end


RegisterNetEvent('FGS:SearchPlr')
AddEventHandler("FGS:SearchPlr", function()
  player = source
  vRPclient.getNearestPlayer(player,{5},function(nplayer)
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
            local item_name = vRP.getItemName(k)
            if item_name then
              items = items.."<br />"..item_name.." ("..v.amount..")"
            end
          end
        end

        local weapons_info = ""
        for k,v in pairs(weapons) do
          weapons_info = weapons_info.."<br />"..k.." ("..v.ammo..")"
        end

        vRPclient.setDiv(player,{"police_check",".div_police_check{ background-color: rgba(0,0,0,0.75); color: white; font-weight: bold; width: 500px; padding: 10px; margin: auto; margin-top: 150px; }",lang.police.menu.check.info({money,items,weapons_info})})
        -- request to hide div
        vRP.request(player, lang.police.menu.check.request_hide(), 1000, function(player,ok)
          vRPclient.removeDiv(player,{"police_check"})
        end)
      end)
    else
      vRPclient.notify(player,{lang.common.no_player_near()})
    end
  end)
end)

RegisterServerEvent("FGS:MPay")
AddEventHandler('FGS:MPay', function(permid, amountmoney)
    local source = source
    local userid = vRP.getUserId(source)
    if userid == permid then
      vRPclient.notify(source, {"~r~You cannot MPay yourself!"})
    else
      if vRP.isConnected(permid) then
        if vRP.tryBankPayment(userid, amountmoney) then
          vRP.giveBankMoney(permid, amountmoney)
          vRPclient.notify(source, {"~g~Paid £"..tostring(GetMoneyString(amountmoney)).." to mpay id: "..permid})
          vRPclient.notify(vRP.getUserSource(permid), {"~g~Received " .. tostring(GetMoneyString(amountmoney)) .. " from " .. GetPlayerName(source)})
        else 
            vRPclient.notify(source, {"~r~Insufficient funds"})
        end
      else
        vRPclient.notify(source, {"~r~Player Not Online"})
      end
    end
end)

RegisterServerEvent("FGS:Pay")
AddEventHandler('FGS:Pay', function(permid, amountmoney)
    local source = source
    local userid = vRP.getUserId(source)
    if userid == permid then
        vRPclient.notify(source, {"~r~You cannot Pay yourself!"})
    else
      if vRP.isConnected(permid) then
        if vRP.tryPayment(userid, amountmoney) then
            vRP.giveMoney(permid, amountmoney)
            vRPclient.notify(source, {"~g~Given £"..tostring(GetMoneyString(amountmoney)).." to id: "..permid})
            vRPclient.notify(vRP.getUserSource(permid), {"~g~Received " .. tostring(GetMoneyString(amountmoney)) .. " from " .. GetPlayerName(source)})
        else 
            vRPclient.notify(source, {"~r~Insufficient funds"})
        end
      else
        vRPclient.notify(source, {"~r~Player Not Online"})
      end
    end
end)