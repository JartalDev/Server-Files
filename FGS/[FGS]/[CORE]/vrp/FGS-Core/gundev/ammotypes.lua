vRPAmmoTypes = {
    ["weapon_m870"] = "12 Gauge",
    ["weapon_mosin"] = "Sniper Bullets",
    ["weapon_russiansniper"] = "Sniper Bullets",
    ["weapon_r700"] = "Sniper Bullets",
    ["weapon_blackopssniper"] = "Sniper Bullets",
    ["weapon_luxeoperator"] = "Sniper Bullets",
    ["weapon_awphyperbeast"] = "Sniper Bullets",
    ["weapon_gdeagle"] = "Sniper Bullets",
    ["weapon_olympia"] = "12 Gauge",


    ["weapon_tx15"] = "7.62 BULLETS",
    ["weapon_hk870"] = "7.62 BULLETS",
    ["weapon_sigmpx"] = "7.62 BULLETS",
    ["weapon_scarl"] = "7.62 BULLETS",
    ["weapon_liquidcarbine"] = "7.62 BULLETS",
    ["weapon_militia"] = "7.62 BULLETS",
    ["weapon_redtiger"] = "7.62 BULLETS",
    ["weapon_nsr"] = "7.62 BULLETS",
    ["weapon_dubzyxlilli"] = "7.62 BULLETS",
    ["weapon_hk416a"] = "7.62 BULLETS",

  --vip--
    ["weapon_m4a1whitenoise"] = "5.56 NATO",
    ["weapon_reapervandal"] = "5.56 NATO",
    ["weapon_ffarautotoon"] = "5.56 NATO",
    ["weapon_m13redtiger"] = "5.56 NATO",
    ["weapon_graurainbow"] = "5.56 NATO",
    ["weapon_m4a4neva"] = "5.56 NATO",
    ["weapon_m13anime"] = "5.56 NATO",
    ["weapon_lr300"] = "5.56 NATO",
    ["weapon_m4sicario"] = "5.56 NATO",
--vip--

    ["weapon_vandal"] = "5.56 NATO",
    ["weapon_rustlr300"] = "5.56 NATO",
    ["weapon_m4a1spurple"] = "5.56 NATO",
    ["weapon_acr1"] = "5.56 NATO",
    ["weapon_g36c"] = "5.56 NATO",
    ["weapon_eldervandal"] = "5.56 NATO",
    ["weapon_grauar"] = "5.56 NATO",
    ["weapon_blackopsar"] = "5.56 NATO",
    ["weapon_nazarious"] = "5.56 NATO",

    ["weapon_m1911"] = "9mm BULLETS",
    ["weapon_glock"] = "9mm BULLETS",
    ["weapon_montana"] = "9mm BULLETS",
    ["weapon_nailgun"] = "9mm BULLETS",
    ["weapon_hushghost"] = "9mm BULLETS",
    ["weapon_p226"] = "9mm BULLETS",
    ["weapon_scouseglock"] = "9mm BULLETS",
    ["weapon_nikepistol"] = "9mm BULLETS",
    ["weapon_ethanglock"] = "9mm BULLETS",
    ["weapon_jokerexmmz"] = "9mm BULLETS",
    ["weapon_vesper"] = "9mm BULLETS",
    ["weapon_ump45"] = "9mm BULLETS",
    ["weapon_mp5x"] = "9mm BULLETS",
    ["weapon_haha74u"] = "9mm BULLETS",
    ["weapon_hushg"] = "9mm BULLETS",
    ["weapon_p90hyperbeast"] = "9mm BULLETS",
    ["weapon_waltherp99"] = "9mm BULLETS",
    ["weapon_7it2"] = "9mm BULLETS",
    ["weapon_blackopssmg"] = "9mm BULLETS",
    ["weapon_blackopspistol"] = "9mm BULLETS",
    ["weapon_mp5sdFGS"] = "9mm BULLETS",
    ["weapon_uwudubzylilli"] = "9mm BULLETS",
    ["weapon_uzi"] = "9mm BULLETS",
    ["weapon_thompson"] = "9mm BULLETS",
    ["weapon_killconfirmed"] = "9mm BULLETS",


    ["weapon_jerrycan"] = "Petrol",
}

vRPWeaponHash = {}

for k,v in pairs(vRPAmmoTypes) do 
    vRPWeaponHash[tonumber(GetHashKey(k))] = k
end