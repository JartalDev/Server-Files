 RegisterServerEvent('FGS:tryTackle')
AddEventHandler('FGS:tryTackle', function(target)
  local target = target
  local source = source
  local user_id = vRP.getUserId(source)
  print(user_id)
  print(tostring(vRP.hasPermission(user_id, "police.menu")))
  if vRP.hasPermission(user_id, "police.menu") then
	  TriggerClientEvent('FGS:getTackled', target, source)
    TriggerClientEvent('FGS:playTackle', source)
  end
end)