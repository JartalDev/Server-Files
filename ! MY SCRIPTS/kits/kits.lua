RegisterCommand('kit1', function()
    GiveWeaponToPed(PlayerPedId(), GetHashKey("WEAPON_MOSIN"), 250, false, true)
    GiveWeaponToPed(PlayerPedId(), GetHashKey("FNTACSHOTGUN"), 250, false, true)
    SetEntityHealth(GetPlayerPed(-1), 200)
    SetPedArmour(PlayerPedId(), 100)
    Notify("~p~[~w~SERVER-NAME~p~]~w~ Kit Given: ~g~Fragging Kit!")
end)