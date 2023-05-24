admincfg = {}

admincfg.perm = "admin.menu"
admincfg.IgnoreButtonPerms = false
admincfg.admins_cant_ban_admins = false


admincfg.placestosendpeople = {
    ['Legion'] = {x = 145.66088867188, y = -1073.5251464844, z = 29.192356109619},
    ['Rebel Diner'] = {x = 1594.365234375,y = 6447.1357421875,z = 25.317134857178},
    ['Mission Row'] = {x = 441.37979125977,y = -991.95989990234,z = 30.723760604858},
    ['Vinewood PD'] = {x = 525.29876708984,y = 11.267486572266,z = 70.628921508789}

} 

--[[ {enabled -- true or false}, permission required ]]
admincfg.buttonsEnabled = {

    --[[ admin Menu ]]
    ["adminMenu"] = {true, "admin.menu"},
    ["warn"] = {true, "admin.warn"},      
    ["showwarn"] = {true, "admin.showwarn"},
    ["ban"] = {true, "admin.ban"},
    ["kick"] = {true, "admin.kick"},
    ["nof10kick"] = {true, "admin.nof10kick"},
    ["revive"] = {true, "admin.revive"},
    ["TP2"] = {true, "admin.tp2player"},
    ["TP2ME"] = {true, "admin.summon"},
    ["FREEZE"] = {true, "admin.freeze"},
    ["spectate"] = {true, "admin.spectate"}, 
    ["SS"] = {true, "admin.screenshot"},
    ["slap"] = {true, "admin.slap"},
    ["giveMoney"] = {true, "admin.givemoney"},
    ["addcar"] = {true, "admin.addcar"},

    --[[ Functions ]]
    ["tp2waypoint"] = {true, "admin.tp2waypoint"},
    ["tp2coords"] = {true, "admin.tp2coords"},
    ["removewarn"] = {true, "admin.removewarn"},
    ["spawnBmx"] = {true, "admin.spawnBmx"},
    ["EntityShit"] = {true, "admin.entityshit"},
    ["spawnGun"] = {true, "admin.spawnGun"},

    --[[ Add Groups ]]
    ["getgroups"] = {true, "group.add"},
    ["staffGroups"] = {true, "admin.staffAddGroups"},
    ["mpdGroups"] = {true, "admin.mpdAddGroups"},
    ["licenseGroups"] = {true, "admin.licenseAddGroups"},
    ["GangGroups"] = {true, "admin.gangAddGroups"},
    ["donoGroups"] = {true, "admin.donoAddGroups"},
    ["nhsGroups"] = {true, "admin.nhsAddGroups"},

    --[[ Vehicle Functions ]]
    ["vehFunctions"] = {true, "admin.vehmenu"},
    ["noClip"] = {true, "admin.noclip"},

    -- [[ Developer Functions ]]
    ["devMenu"] = {true, "dev.menu"},
}

return admincfg
