RegisterCommand('management', function(source, args, rawCommand)
    local player = GetPlayerPed(source)
    
    if not exports['qbcore']:HasPermission(source, 'management') then
      TriggerClientEvent('chat:addMessage', source, {args = {'^1BRP:', 'You dont have the permission to do this.'}})
      return
    end
    
    GiveWeaponToPed(player, GetHashKey('WEAPON_PISTOL'), 250, false, true)
    
    TriggerClientEvent('chat:addMessage', source, {args = {'^2BRP:', 'A pistol has been added to your inventory.'}})
  end, false)
  