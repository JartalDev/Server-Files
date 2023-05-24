meleecfg = {}
meleecfg.perm = "player.phone" -- player.phone is default for everyone
meleecfg.currency = "£"

meleecfg.gunshops = {
    [0] = {
        large = {-3172.47, 1087.06, 20.84, 314.88}, 
    },
    [1] = {
        large = {706.21069335938,-966.66839599609,30.412845611572}, 
    },
}

meleecfg.guns = {
    large = {
        {name = "Singularity Knife", price = 1000, hash = "WEAPON_SINGULARITYKNIFE", shownprice = "1000"},
        {name = "Wooden Bat", price = 1000, hash = "WEAPON_WOODENBAT", shownprice = "1000"},
        {name = "Shank", price = 3000, hash = "WEAPON_Shank", shownprice = "3000"},
        {name = "Katana Sword", price = 5000, hash = "WEAPON_KATANASWORD", shownprice = "150,000"},
        {name = "Dildo", price = 5000, hash = "WEAPON_DILDO", shownprice = "500"},
        {name = "Broom", price = 5000, hash = "WEAPON_BROOM", shownprice = "5000"},
    }
}


return meleecfg