RegisterServerEvent("TP:SANDY")
AddEventHandler("TP:SANDY",function()
       local coords = GetEntityCoords(GetPlayerPed(source))
       local comparison = vector3(340.05987548828,-1388.4616699219,32.509250640869)
       if #(coords - comparison) > 20 then 
              print(GetPlayerName(source).." is trying to cheat")
              return
       end
       vRPclient.teleport(source, {1841.5405273438,3668.8037109375,33.679920196533})
end)

RegisterServerEvent("TP:THOMAS")
AddEventHandler("TP:THOMAS",function()
       local coords = GetEntityCoords(GetPlayerPed(source))
       local comparison = vector3(340.05987548828,-1388.4616699219,32.509250640869)
       if #(coords - comparison) > 20 then 
       print(GetPlayerName(source).." is trying to cheat")
       return
       end
       vRPclient.teleport(source, {364.56402587891,-591.74749755859,28.686855316162})
end)

RegisterServerEvent("TP:PALETO")
AddEventHandler("TP:PALETO",function()
       local coords = GetEntityCoords(GetPlayerPed(source))
       local comparison = vector3(340.05987548828,-1388.4616699219,32.509250640869)
       if #(coords - comparison) > 20 then 
       print(GetPlayerName(source).." is trying to cheat")
       return
       end
       vRPclient.teleport(source, {-246.71606445313,6330.7153320313,32.426177978516})
end)

RegisterServerEvent("TP:MISSIONROW")
AddEventHandler("TP:MISSIONROW",function()
       local user_id = vRP.getUserId(source)
       local coords = GetEntityCoords(GetPlayerPed(source))
       local comparison = vector3(340.05987548828,-1388.4616699219,32.509250640869)
       if #(coords - comparison) > 20 then 
       print(GetPlayerName(source).." is trying to cheat")
       return
       end
       if vRP.hasPermission(user_id, "police.service") then
       vRPclient.teleport(source, {428.19479370117,-981.58215332031,30.710285186768})
       else
       TriggerClientEvent('showNotification', source,"~b~".. "~r~You don't have permission to do that or your not on duty")
       end
end)

RegisterServerEvent("TP:PaletoPD")
AddEventHandler("TP:PaletoPD",function()
       local user_id = vRP.getUserId(source)
       local coords = GetEntityCoords(GetPlayerPed(source))
       local comparison = vector3(340.05987548828,-1388.4616699219,32.509250640869)
       if #(coords - comparison) > 20 then 
       print(GetPlayerName(source).." is trying to cheat")
       return
       end
       if vRP.hasPermission(user_id, "police.service") then
       vRPclient.teleport(source, {-439.23,6020.6,31.49})
       else
       TriggerClientEvent('showNotification', source,"~b~".. "~r~You don't have permission to do that or your not on duty")
       end
end)

RegisterServerEvent("TP:Vespucci")
AddEventHandler("TP:Vespucci",function()
       local user_id = vRP.getUserId(source)
       local coords = GetEntityCoords(GetPlayerPed(source))
       local comparison = vector3(340.05987548828,-1388.4616699219,32.509250640869)
       if #(coords - comparison) > 20 then 
       print(GetPlayerName(source).." is trying to cheat")
       return
       end
       if vRP.hasPermission(user_id, "police.service") then
       vRPclient.teleport(source, {-1061.13,-827.26,19.21})
       else
       TriggerClientEvent('showNotification', source,"~b~".. "~r~You don't have permission to do that or your not on duty")
       end
end)


RegisterServerEvent("TP:Rebel")
AddEventHandler("TP:Rebel",function()
       local user_id = vRP.getUserId(source)
       local coords = GetEntityCoords(GetPlayerPed(source))
       local comparison = vector3(340.05987548828,-1388.4616699219,32.509250640869)
       if #(coords - comparison) > 20 then 
       print(GetPlayerName(source).." is trying to cheat")
       return
       end
       if vRP.hasPermission(user_id, "rebel.license") then
       vRPclient.teleport(source, {3312.1791992188,5175.7817382812,19.614547729492})
       else
       TriggerClientEvent('showNotification', source,"~b~".. "~r~You don't have permission to do")
       end
end)

RegisterServerEvent("FGS:RebelCheck")
AddEventHandler("FGS:RebelCheck",function()
       local user_id = vRP.getUserId(source)
       if vRP.hasPermission(user_id, "rebel.license") then
              TriggerClientEvent('FGS:RebelChecked', source, true)
       else
              TriggerClientEvent('FGS:RebelChecked', source, false)
       end
end)

RegisterServerEvent("FGS:PoliceCheck")
AddEventHandler("FGS:PoliceCheck",function()
       local user_id = vRP.getUserId(source)
       if vRP.hasPermission(user_id, "police.service") then
              TriggerClientEvent('FGS:PoliceChecked', source, true)
       else
              TriggerClientEvent('FGS:PoliceChecked', source, false)
       end
end)