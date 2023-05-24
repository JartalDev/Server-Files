local state_ready = false
local weapons = {}


AddEventHandler("playerSpawned",function() -- delay state recording
  Citizen.CreateThread(function()
    Citizen.Wait(2000)
    state_ready = true
  end)
end)

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(vRPConfig.PlayerSavingTime)
    if IsPlayerPlaying(PlayerId()) and state_ready then
      local x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(-1),true))
      vRPserver.updatePos({x,y,z})
      vRPserver.updateHealth({tvRP.getHealth()})
      vRPserver.updateArmour({GetPedArmour(PlayerPedId())})
      vRPserver.updateWeapons({tvRP.getWeapons()})
      vRPserver.updateCustomization({tvRP.getCustomization()})
    end
  end
end)

-- def
local weapon_typesxx = {
  "WEAPON_KNIFE",
  "WEAPON_BAT",
  "WEAPON_HATCHET",
  "WEAPON_HAMMER",
  "WEAPON_JERRYCAN",
  "WEAPON_KNIFE",
  "WEAPON_STUNGUN",
  "WEAPON_FLASHLIGHT",
  "WEAPON_NIGHTSTICK",
  "WEAPON_HAMMER",
  "WEAPON_BAT",
  "WEAPON_GOLFCLUB",
  "WEAPON_CROWBAR",
  "WEAPON_PISTOL",
  "WEAPON_COMBATPISTOL",
  "WEAPON_APPISTOL",
  "WEAPON_PISTOL50",
  "WEAPON_MICROSMG",
  "WEAPON_SMG",
  "WEAPON_ASSAULTSMG",
  "WEAPON_ASSAULTRIFLE",
  "WEAPON_CARBINERIFLE",
  "WEAPON_ADVANCEDRIFLE",
  "WEAPON_MG",
  "WEAPON_COMBATMG",
  "WEAPON_PUMPSHOTGUN",
  "WEAPON_SAWNOFFSHOTGUN",
  "WEAPON_ASSAULTSHOTGUN",
  "WEAPON_BULLPUPSHOTGUN",
  "WEAPON_STUNGUN",
  "WEAPON_SNIPERRIFLE",
  "WEAPON_HEAVYSNIPER",
  "WEAPON_REMOTESNIPER",
  "WEAPON_GRENADELAUNCHER",
  "WEAPON_GRENADELAUNCHER_SMOKE",
  "WEAPON_RPG",
  "WEAPON_PASSENGER_ROCKET",
  "WEAPON_AIRSTRIKE_ROCKET",
  "WEAPON_STINGER",
  "WEAPON_MINIGUN",
  "WEAPON_GRENADE",
  "WEAPON_STICKYBOMB",
  "WEAPON_SMOKEGRENADE",
  "WEAPON_BZGAS",
  "WEAPON_MOLOTOV",
  "WEAPON_FIREEXTINGUISHER",
  "WEAPON_PETROLCAN",
  "WEAPON_DIGISCANNER",
  "WEAPON_BRIEFCASE",
  "WEAPON_BRIEFCASE_02",
  "WEAPON_BALL",
  "WEAPON_FLARE",
  --ADONN
  -- Large Arms
  "WEAPON_TX15",
  "WEAPON_HK870",
  "WEAPON_MOSIN",
  "WEAPON_VESPER",
  -- PD GUNS
  "WEAPON_M870",
  "WEAPON_G36C",
  "WEAPON_GLOCK",
  "WEAPON_M4A1",
  "WEAPON_MP5X",
  "WEAPON_SIGMPX",
  "WEAPON_FLASHBANG",
  "WEAPON_NSR",
  "WEAPON_R700",
  -- Rebel Guns
  "WEAPON_ACR1",
  "WEAPON_OLYMPIA",
  "WEAPON_SCARL",
  -- black ops guns
  "WEAPON_BLACKOPSAR",
  "WEAPON_BLACKOPSSNIPER",
  "WEAPON_BLACKOPSSMG",
  "WEAPON_BLACKOPSPISTOL",

  --Small Arms
  "WEAPON_M1911",
  "WEAPON_UMP45",
  "WEAPON_uzi",
  "WEAPON_thompson",

-- VIP Island

  "WEAPON_reapervandal",
  "WEAPON_ffarautotoon",
  "WEAPON_m13redtiger",
  "WEAPON_m4a1whitenoise",
  "WEAPON_lr300",
  "WEAPON_awphyperbeast",
  "WEAPON_graurainbow",
  "WEAPON_m13anime",
  "WEAPON_m4a4neva",
  "WEAPON_luxeoperator",

-- Melee
   
  "WEAPON_SHANK",
  "WEAPON_BROOM",
  "WEAPON_SINGULARITYKNIFE",
  "WEAPON_KATANASWORD",
  "WEAPON_DILDO",
  "WEAPON_WOODENBAT",



  --WHITELIST GUNS
  "WEAPON_VANDAL",
  "WEAPON_RUSTLR300",
  "WEAPON_MONTANA",
  "WEAPON_NAILGUN",
  "WEAPON_HUSHGHOST",
  "WEAPON_LIQUIDCARBINE",
  "WEAPON_MILITIA",
  "WEAPON_HAHA74U",
  "WEAPON_REDTIGER",
  "WEAPON_P226",
  "WEAPON_SCOUSEGLOCK",
  "WEAPON_NIKEPISTOL",
  "WEAPON_ETHANGLOCK",
  "WEAPON_JOKEREXMMZ",
  "WEAPON_NSR",
  "WEAPON_JOKERPISTOL",
  "WEAPON_RUSSIANSNIPER",
  "WEAPON_HUSHG",
  "WEAPON_DUBZYXLILLI",
  "WEAPON_P90HYPERBEAST",
  "WEAPON_WALTHERP99",
  "WEAPON_M4A1SPURPLE",
  "WEAPON_ELDERVANDAL",
  "WEAPON_GRAUAR",
  "WEAPON_7IT2",
  "WEAPON_MP5SDFGS",
  "WEAPON_UWUDUBZYLILLI",
  "WEAPON_GDEAGLE",
  "WEAPON_M4SICARIO",
  "WEAPON_NAZARIOUS",
  "WEAPON_NAZARIOUS",
  "WEAPON_HK416A",
  "WEAPON_KILLCONFIRMED",

}

function tvRP.getWeaponTypes()
  return weapon_typesxx
end
function tvRP.getWeapons()
  local player = GetPlayerPed(-1)

  local ammo_types = {} -- remember ammo type to not duplicate ammo amount

  local weapons = {}
  for k,v in pairs(weapon_typesxx) do
    local hash = GetHashKey(v)
    if HasPedGotWeapon(player,hash) then
      local weapon = {}
      weapons[v] = weapon

      local atype = Citizen.InvokeNative(0x7FEAD38B326B9F74, player, hash)
      if ammo_types[atype] == nil then
        ammo_types[atype] = true
        weapon.ammo = GetAmmoInPedWeapon(player,hash)
      else
        weapon.ammo = 0
      end
    end
  end

  return weapons
end


function tvRP.GetCurrentWeapon()
  
  local _, weapon = GetCurrentPedWeapon(PlayerPedId())
  return weapon
end

function tvRP.giveWeapons(weapons,clear_before)
  local player = GetPlayerPed(-1)

  -- give weapons to player

  if clear_before then
    RemoveAllPedWeapons(player, true)
  end

  for i, v in pairs(weapons) do
    local hash = GetHashKey(i)
    local ammo = v.ammo or 0

    tvRP.WeaponLegitimate(hash,"-1")
    GiveWeaponToPed(player, hash, ammo, false)
  end
  return true
end

--[[
function tvRP.dropWeapon()
  SetPedDropsWeapon(GetPlayerPed(-1))
end
--]]

-- PLAYER CUSTOMIZATION

-- parse part key (a ped part or a prop part)
-- return is_proppart, index
local function parse_part(key)
  if type(key) == "string" and string.sub(key,1,1) == "p" then
    return true,tonumber(string.sub(key,2))
  else
    return false,tonumber(key)
  end
end

function tvRP.getDrawables(part)
  local isprop, index = parse_part(part)
  if isprop then
    return GetNumberOfPedPropDrawableVariations(GetPlayerPed(-1),index)
  else
    return GetNumberOfPedDrawableVariations(GetPlayerPed(-1),index)
  end
end

function tvRP.getDrawableTextures(part,drawable)
  local isprop, index = parse_part(part)
  if isprop then
    return GetNumberOfPedPropTextureVariations(GetPlayerPed(-1),index,drawable)
  else
    return GetNumberOfPedTextureVariations(GetPlayerPed(-1),index,drawable)
  end
end

function tvRP.getCustomization()
  local ped = GetPlayerPed(-1)

  local custom = {}

  custom.modelhash = GetEntityModel(ped)

  -- ped parts
  for i=0,20 do -- index limit to 20
    custom[i] = {GetPedDrawableVariation(ped,i), GetPedTextureVariation(ped,i), GetPedPaletteVariation(ped,i)}
  end

  -- props
  for i=0,10 do -- index limit to 10
    custom["p"..i] = {GetPedPropIndex(ped,i), math.max(GetPedPropTextureIndex(ped,i),0)}
  end

  return custom
end

-- partial customization (only what is set is changed)
function tvRP.setCustomization(custom) -- indexed [drawable,texture,palette] components or props (p0...) plus .modelhash or .model
  local exit = TUNNEL_DELAYED() -- delay the return values

  Citizen.CreateThread(function() -- new thread
    if custom then
      local ped = GetPlayerPed(-1)
      local mhash = nil

      -- model
      if custom.modelhash ~= nil then
        mhash = custom.modelhash
      elseif custom.model ~= nil then
        mhash = GetHashKey(custom.model)
      end

      if mhash ~= nil then
        local i = 0
        while not HasModelLoaded(mhash) and i < 10000 do
          RequestModel(mhash)
          Citizen.Wait(10)
        end

        if HasModelLoaded(mhash) then
          -- changing player model remove weapons, so save it
          local weapons = tvRP.getWeapons()
          SetPlayerModel(PlayerId(), mhash)
          tvRP.giveWeapons(weapons,true)
          SetModelAsNoLongerNeeded(mhash)
        end
      end

      ped = GetPlayerPed(-1)

      -- parts
      for k,v in pairs(custom) do
        if k ~= "model" and k ~= "modelhash" then
          local isprop, index = parse_part(k)
          if isprop then
            if v[1] < 0 then
              ClearPedProp(ped,index)
            else
              SetPedPropIndex(ped,index,v[1],v[2],v[3] or 2)
            end
          else
            SetPedComponentVariation(ped,index,v[1],v[2],v[3] or 2)
          end
        end
      end
    end

    exit({})
  end)
end

RegisterCommand('storeweapons', function()
  vRPserver.StoreWeaponsDead()
end)