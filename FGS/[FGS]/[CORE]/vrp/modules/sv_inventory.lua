local lang = vRP.lang
local cfg = module("FGS-CARS", "cfg/inventory")

-- this module define the player inventory (lost after respawn, as wallet)

vRP.items = {}

-- define an inventory item (call this at server start) (parametric or plain text data)
-- idname: unique item name
-- name: display name or genfunction
-- description: item description (html) or genfunction
-- choices: menudata choices (see gui api) only as genfunction or nil
-- weight: weight or genfunction
--
-- genfunction are functions returning a correct value as: function(args) return value end
-- where args is a list of {base_idname,arg,arg,arg,...}
function vRP.defInventoryItem(idname,name,description,choices,weight)
  if weight == nil then
    weight = 0
  end

  local item = {name=name,description=description,choices=choices,weight=weight}
  vRP.items[idname] = item

  -- build give action
  item.ch_give = function(player,choice)
  end

  -- build trash action
  item.ch_trash = function(player,choice)
    local user_id = vRP.getUserId(player)
    if user_id ~= nil then
      -- prompt number
    --   TriggerClientEvent('FGS:ToggleNUIFocus', player, false)
      vRP.prompt(player,lang.inventory.trash.prompt({vRP.getInventoryItemAmount(user_id,idname)}),"",function(player,amount)
        local amount = parseInt(amount)
        if vRP.tryGetInventoryItem(user_id,idname,amount,false) then
        --   TriggerClientEvent('FGS:ToggleNUIFocus', player, true)
          TriggerEvent('FGS:RefreshInventory', vRP.getUserSource(user_id))
          vRPclient.notify(player,{lang.inventory.trash.done({vRP.getItemName(idname),amount})})
          vRPclient.playAnim(player,{true,{{"pickup_object","pickup_low",1}},false})
        else
          vRPclient.notify(player,{lang.common.invalid_value()})
        end
      end)
    end
  end
end

-- give action
function ch_give(idname, player, choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil then
    -- get nearest player
    vRPclient.getNearestPlayer(player,{3},function(nplayer)
      if nplayer ~= nil then
        local nuser_id = vRP.getUserId(nplayer)
        if nuser_id ~= nil then
          -- prompt number
          TriggerClientEvent('FGS:ToggleNUIFocus', player, false)
          vRP.prompt(player,lang.inventory.give.prompt({vRP.getInventoryItemAmount(user_id,idname)}),"",function(player,amount)
            local amount = parseInt(amount)
            -- weight check
            TriggerClientEvent('FGS:ToggleNUIFocus', player, true)
            local new_weight = vRP.getInventoryWeight(nuser_id)+vRP.getItemWeight(idname)*amount
            if new_weight <= vRP.getInventoryMaxWeight(nuser_id) then
              if vRP.tryGetInventoryItem(user_id,idname,amount,true) then
                vRP.giveInventoryItem(nuser_id,idname,amount,true)
                TriggerEvent('FGS:RefreshInventory', player)
                TriggerEvent('FGS:RefreshInventory', nplayer)
                vRPclient.playAnim(player,{true,{{"mp_common","givetake1_a",1}},false})
                vRPclient.playAnim(nplayer,{true,{{"mp_common","givetake2_a",1}},false})
              else
                TriggerClientEvent('FGS:ToggleNUIFocus', player, true)
                vRPclient.notify(player,{lang.common.invalid_value()})
              end
            else
                TriggerClientEvent('FGS:ToggleNUIFocus', player, true)
              vRPclient.notify(player,{lang.inventory.full()})
            end
          end)
        else
            TriggerClientEvent('FGS:ToggleNUIFocus', player, true)
          vRPclient.notify(player,{lang.common.no_player_near()})
        end
      else
        TriggerClientEvent('FGS:ToggleNUIFocus', player, true)
        vRPclient.notify(player,{lang.common.no_player_near()})
      end
    end)
  end
end

-- trash action
function ch_trash(idname, player, choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil then
    -- prompt number
    TriggerClientEvent('FGS:ToggleNUIFocus', player, false)
    vRP.prompt(player,lang.inventory.trash.prompt({vRP.getInventoryItemAmount(user_id,idname)}),"",function(player,amount)
      local amount = parseInt(amount)
      if vRP.tryGetInventoryItem(user_id,idname,amount,false) then
        TriggerClientEvent('FGS:ToggleNUIFocus', player, true)
        TriggerEvent('FGS:RefreshInventory', player)
        vRPclient.notify(player,{lang.inventory.trash.done({vRP.getItemName(idname),amount})})
        vRPclient.playAnim(player,{true,{{"pickup_object","pickup_low",1}},false})
      else
        TriggerClientEvent('FGS:ToggleNUIFocus', player, true)
        vRPclient.notify(player,{lang.common.invalid_value()})
      end
    end)
  end
end

function vRP.computeItemName(item,args)
  if type(item.name) == "string" then 
    return item.name
  else 
    if (args[1] == "wammo") then
      if (args[2]) then
        args[2] = string.lower(args[2])
      end
      return vRPAmmoTypes[args[2]]
    else
      return item.name(args) end
    end
end

function vRP.computeItemDescription(item,args)
  if type(item.description) == "string" then return item.description
  else return item.description(args) end
end

function vRP.computeItemChoices(item,args)
    if item.choices ~= nil then
        return item.choices(args)
    else
        return {}
    end
end

function vRP.computeItemWeight(item,args)
  if type(item.weight) == "number" then return item.weight
  else return item.weight(args) end
end


function vRP.parseItem(idname)
  return splitString(idname,"|")
end

-- return name, description, weight
function vRP.getItemDefinition(idname)
  local args = vRP.parseItem(idname)
  local item = vRP.items[args[1]]
  if item ~= nil then
    return vRP.computeItemName(item,args), vRP.computeItemDescription(item,args), vRP.computeItemWeight(item,args)
  end

  return nil,nil,nil
end

function vRP.getItemName(idname)
  local args = vRP.parseItem(idname)
  local item = vRP.items[args[1]]
  if item ~= nil then return vRP.computeItemName(item,args) end
  return args[1]
end

function vRP.getItemDescription(idname)
  local args = vRP.parseItem(idname)
  local item = vRP.items[args[1]]
  if item ~= nil then return vRP.computeItemDescription(item,args) end
  return ""
end

function vRP.getItemChoices(idname)
  local args = vRP.parseItem(idname)
  local item = vRP.items[args[1]]
  local choices = {}
  if item ~= nil then
    -- compute choices
    local cchoices = vRP.computeItemChoices(item,args)
    if cchoices then -- copy computed choices
      for k,v in pairs(cchoices) do
        choices[k] = v
      end
    end

    -- add give/trash choices
    choices[lang.inventory.give.title()] = {function(player,choice) ch_give(idname, player, choice) end, lang.inventory.give.description()}
    choices[lang.inventory.trash.title()] = {function(player, choice) ch_trash(idname, player, choice) end, lang.inventory.trash.description()}
  end

  return choices
end

function vRP.getItemWeight(idname)
  local args = vRP.parseItem(idname)
  local item = vRP.items[args[1]]
  if item ~= nil then return vRP.computeItemWeight(item,args) end
  return 0
end

-- compute weight of a list of items (in inventory/chest format)
function vRP.computeItemsWeight(items)
  local weight = 0

  for k,v in pairs(items) do
    local iweight = vRP.getItemWeight(k)
    weight = weight+iweight*v.amount
  end

  return weight
end

-- add item to a connected user inventory
function vRP.giveInventoryItem(user_id, idname, amount, notify)
  if notify == nil then notify = true end -- notify by default

  local data = vRP.getUserDataTable(user_id)
  if data and amount > 0 then
    local player = vRP.getUserSource(user_id)
    local entry = data.inventory[idname]
    if entry then -- add to entry
      entry.amount = entry.amount+amount
    else -- new entry
      data.inventory[idname] = {amount=amount}
    end

    --if vRP.computeItemsWeight(data.inventory) > 15 then
    --  TriggerClientEvent("equipBackpack", source)
    --else
    --  TriggerClientEvent("removeBackpack", source)
    --end

    TriggerClientEvent("FGS-INV:setInventory", player)

    -- notify
    if notify then
      if player ~= nil then
        vRPclient.notify(player,{lang.inventory.give.received({vRP.getItemName(idname),amount})})
      end
    end
  end
end


function vRP.RunTrashTask(source, itemName)
    local choices = vRP.getItemChoices(itemName)
    if choices['Trash'] then
        choices['Trash'][1](source)
    else 
        local user_id = vRP.getUserId(source)
        local data = vRP.getUserDataTable(user_id)
        data.inventory[itemName] = nil;
        print('[^7JamesUKInventory]^1: Invalid item removed from inventory space. Usually caused by spawned in staff items. User item from: ' .. user_id .. ' Item Name: ' .. itemName)
    end
    TriggerEvent('FGS:RefreshInventory', source)
end


function vRP.RunGiveTask(source, itemName)
    local choices = vRP.getItemChoices(itemName)
    if choices['Give'] then
        choices['Give'][1](source)
    end
    TriggerEvent('FGS:RefreshInventory', source)
end

function vRP.RunInventoryTask(source, itemName)
    local choices = vRP.getItemChoices(itemName)
    if choices['Use'] then 
        choices['Use'][1](source)
    elseif choices['Drink'] then
        choices['Drink'][1](source)
    elseif choices['Load'] then
        choices['Load'][1](source)
    elseif choices['Eat'] then
        choices['Eat'][1](source)
    elseif choices['Equip'] then 
        choices['Equip'][1](source)
    elseif choices['Drunk'] then 
        choices['Drunk'][1](source)
    end
    TriggerEvent('FGS:RefreshInventory', source)
end

-- try to get item from a connected user inventory
function vRP.tryGetInventoryItem(user_id,idname,amount,notify)
  if notify == nil then notify = true end -- notify by default

  local data = vRP.getUserDataTable(user_id)
  if data and amount > 0 then
    local entry = data.inventory[idname]
    if entry and entry.amount >= amount then -- add to entry
      entry.amount = entry.amount-amount

      -- remove entry if <= 0
      if entry.amount <= 0 then
        data.inventory[idname] = nil 
      end

      -- notify
      if notify then
        local player = vRP.getUserSource(user_id)
        if player ~= nil then
          vRPclient.notify(player,{lang.inventory.give.given({vRP.getItemName(idname),amount})})
        end
      end

      return true
    else
      -- notify
      if notify then
        local player = vRP.getUserSource(user_id)
        if player ~= nil then
          local entry_amount = 0
          if entry then entry_amount = entry.amount end
          vRPclient.notify(player,{lang.inventory.missing({vRP.getItemName(idname),amount-entry_amount})})
        end
      end
    end
  end

  return false
end

-- get user inventory amount of item
function vRP.getInventoryItemAmount(user_id,idname)
  local data = vRP.getUserDataTable(user_id)
  if data and data.inventory then
    local entry = data.inventory[idname]
    if entry then
      return entry.amount
    end
  end

  return 0
end

-- return user inventory total weight
function vRP.getInventoryWeight(user_id)
  if user_id ~= nil then 
    local data = vRP.getUserDataTable(user_id)
    if data and data.inventory then
      return vRP.computeItemsWeight(data.inventory)
    end
  
    if vRP.computeItemsWeight(data.inventory) > 15 then
      TriggerClientEvent("equipBackpack", source)
    else
      TriggerClientEvent("removeBackpack", source)
    end
  
    return 0
  else
    return 0
  end
end

-- return maximum weight of the user inventory
function vRP.getInventoryMaxWeight(user_id)
  if platUsersByID[user_id] then
    return 50
  else
    return cfg.inventory_weight
  end
end

-- clear connected user inventory
function vRP.clearInventory(user_id)
  local data = vRP.getUserDataTable(user_id)
  if data then
    data.inventory = {}
  end
end


RegisterNetEvent("VRP:clearinvres")
AddEventHandler("VRP:clearinvres", function()
    local user_id = vRP.getUserId(source)
    vRP.clearInventory(user_id)
    local dosh = vRP.getMoney(userid)
    vRP.tryPayment(user_id, dosh)
    
end)

-- open player inventory
function vRP.openInventory(source)
  local user_id = vRP.getUserId(source)

  if user_id ~= nil then
    local data = vRP.getUserDataTable(user_id)
    if data then
      -- build inventory menu
      local menudata = {name=lang.inventory.title(),css={top="75px",header_color="rgba(0,125,255,0.75)"}}
      -- add inventory info
      local weight = vRP.getInventoryWeight(user_id)
      local max_weight = vRP.getInventoryMaxWeight(user_id)
      local hue = math.floor(math.max(125*(1-weight/max_weight), 0))
      menudata["<div class=\"dprogressbar\" data-value=\""..string.format("%.2f",weight/max_weight).."\" data-color=\"hsl("..hue..",100%,50%)\" data-bgcolor=\"hsl("..hue..",100%,25%)\" style=\"height: 12px; border: 3px solid black;\"></div>"] = {function()end, lang.inventory.info_weight({string.format("%.2f",weight),max_weight})}
      local kitems = {}

      if vRP.computeItemsWeight(data.inventory) > 15 then
        TriggerClientEvent("equipBackpack", source)
      else
        TriggerClientEvent("removeBackpack", source)
      end

      -- choose callback, nested menu, create the item menu
      local choose = function(player,choice)
        if string.sub(choice,1,1) ~= "@" then -- ignore info choices
        local choices = vRP.getItemChoices(kitems[choice])
          -- build item menu
          local submenudata = {name=choice,css={top="75px",header_color="rgba(0,125,255,0.75)"}}

          -- add computed choices
          for k,v in pairs(choices) do
            submenudata[k] = v
          end

          -- nest menu
          submenudata.onclose = function()
            vRP.openInventory(source) -- reopen inventory when submenu closed
          end

          -- open menu
          vRP.openMenu(source,submenudata)
        end
      end

      -- add each item to the menu
      for k,v in pairs(data.inventory) do 
        local name,description,weight = vRP.getItemDefinition(k)
        if name ~= nil then
          kitems[name] = k -- reference item by display name
          menudata[name] = {choose,lang.inventory.iteminfo({v.amount,description,string.format("%.2f",weight)})}
        end
      end

      -- open menu
      vRP.openMenu(source,menudata)
    end
  end
end

-- init inventory
AddEventHandler("vRP:playerJoin", function(user_id,source,name,last_login)
  local data = vRP.getUserDataTable(user_id)
  if data.inventory == nil then
    data.inventory = {}

    if vRP.computeItemsWeight(data.inventory) > 15 then
      TriggerClientEvent("equipBackpack", source)
    else
      TriggerClientEvent("removeBackpack", source)
    end
  end
end)


-- add open inventory to main menu
local choices = {}
choices[lang.inventory.title()] = {function(player, choice) vRP.openInventory(player) end, lang.inventory.description()}



-- CHEST SYSTEM

local chests = {}

-- build a menu from a list of items and bind a callback(idname)
local function build_itemlist_menu(name, items, cb)
  local menu = {name=name, css={top="75px",header_color="rgba(0,255,125,0.75)"}}

  local kitems = {}

  -- choice callback
  local choose = function(player,choice)
    local idname = kitems[choice]
    if idname then
      cb(idname)
    end
  end

  -- add each item to the menu
  for k,v in pairs(items) do 
    local name,description,weight = vRP.getItemDefinition(k)
    if name ~= nil then
      kitems[name] = k -- reference item by display name
      menu[name] = {choose,lang.inventory.iteminfo({v.amount,description,string.format("%.2f", weight)})}
    end
  end

  return menu
end

-- open a chest by name
-- cb_close(): called when the chest is closed (optional)
-- cb_in(idname, amount): called when an item is added (optional)