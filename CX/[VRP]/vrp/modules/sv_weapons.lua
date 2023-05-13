RegisterCommand("founder", function(source, args, raw)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id == 1 or user_id == 2 then
        vRPclient.giveWeapons(source, {{["WEAPON_MOSIN"] = {ammo = 250}}})
    end
end)