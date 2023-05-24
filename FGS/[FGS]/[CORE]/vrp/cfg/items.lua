-- define items, see the Inventory API on github

local cfg = {}
-- see the manual to understand how to create parametric items
-- idname = {name or genfunc, description or genfunc, genfunc choices or nil, weight or genfunc}
-- a good practice is to create your own item pack file instead of adding items here
cfg.items = {
  -- WEED
  ["weed_seeds"] = {"Weed Seeds", "Weed Seeds", nil, 1.0},
  ["weed"] = {"Weed", "Weed", nil, 4.0},

  -- Ecstasy
  ["froglegs"] = {"Frog Legs", "Frog Legs", nil, 1.0},
  ["acid"] = {"Acid", "Acid", nil, 1.0},
  ["ecstasy"] = {"Ecstasy", "Ecstasy", nil, 4.0},

  -- Coke
  ["coke_seeds"] = {"Cocaine Seeds", "Cocaine Seeds", nil, 1.00},
  ["coke"] = {"Cocaine", "Cocaine", nil, 4.0},

  -- Meth
  ["meth_seeds"] = {"Meth Seeds", "Meth Seeds", nil, 1.00},
  ["meth"] = {"Meth", "Meth", nil, 4.0},

  -- Heroin
  ["heroin_seeds"] = {"Heroin Seeds", "Heroin Seeds", nil, 1.0},
  ["heroin"] = {"Heroin", "Heroin", nil, 4.0},

  -- Diamonds
  ["crystal"] = {"Diamond Crystal", "", nil, 1.0}, -- no choices
  ["diamond"] = {"Diamond", "", nil, 4.0}, -- no choices


  --bank rob


  ["laptop_h"] = {"Laptop", "", nil, 4.0}, -- no choices
  ["thermal_charge"] = {"Thermal Charge", "", nil, 4.0}, -- no choices 
  ["id_card"] = {"ID Card", "", nil, 4.0}, -- no choices

  -- Scrap
  ["scrap"] = {"Fixed Scrap", "", nil, 4.0}, -- no choices


  -- Others
  ["parachute"] = {"Parachute", "Parachute", nil, 5.0},
  ["keycard"] = {"Keycard", "Vangelico Store Keycard", nil, 5.0},
  ["drill"] = {"Drill", "Hilti Drill", nil, 5.0},

  ["L_HDD"] = {"Locked HDD", "Locked HDD", nil, 5.0},
  ["drill"] = {"drill", "", nil, 5.0},
  ["bag"] = {"bag", "", nil, 5.0},

  ["gold"] = {"gold", "", nil, 5.0},
  ["cash"] = {"cash", "", nil, 0.01},
  ["Jewelry"] = {"Jewelry", "", nil, 1.0},

    ["casino_token"] = {"casino_token", "", nil, 1.0},

}

-- load more items function
local function load_item_pack(name)
  local items = module("cfg/item/"..name)
  if items then
    for k,v in pairs(items) do
      cfg.items[k] = v
    end
  else
  end
end

-- PACKS
load_item_pack("required")
load_item_pack("food")
load_item_pack("drugs")

return cfg
