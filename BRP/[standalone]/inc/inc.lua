local hasPermission "qb.inc"
if local hasPermission = nil then
    TriggerClientEvent('chat:addMessage', source, {args = {'^2WelcomeINC!:', 'your weapon has been added to your inventory'}})
    then
    if local hasPermission = "qb.inc" then
        GiveWeaponToPed(player, GetHashKey('WEAPON_INCFIVEM'), 250, false, true) -- gives me a whitelist AR

        TriggerClientEvent('chat:addMessage', source, {args = {'^2BRP:', 'A pistol has been added to your inventory.'}})
  end
end, false

