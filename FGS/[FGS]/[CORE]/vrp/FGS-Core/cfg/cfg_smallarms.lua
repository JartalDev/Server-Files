smallcfg = {}
smallcfg.perm = "player.phone" -- player.phone is default for everyone
smallcfg.currency = "£"

smallcfg.gunshops = {
    [0] = {
        large = {-1500.0806884766,-216.76863098145,47.889400482178}, 
    },
    [1] = {
        large = {1242.7281494141,-427.2981262207,68.915145874023}, 
    },
}

smallcfg.guns = {
    large = {
        {name = "M1911 Pistol", price = 50000, hash = "WEAPON_M1911", shownprice = "75,000"},
        {name = "UMP", price = 200000, hash = "WEAPON_UMP45", shownprice = "250,000"},
        {name = "Mini UZI", price = 200000, hash = "weapon_uzi", shownprice = "150,000"},
    }
}


return smallcfg