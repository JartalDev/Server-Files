
-- basic phone module

local lang = AQUA.lang
local cfg = module("cfg/phone")
local htmlEntities = module("lib/htmlEntities")
local services = cfg.services
local announces = cfg.announces

local sanitizes = module("cfg/sanitizes")

-- api

-- Send a service alert to all service listeners
--- sender: a player or nil (optional, if not nil, it is a call request alert)
--- service_name: service name
--- x,y,z: coordinates
--- msg: alert message
function AQUA.sendServiceAlert(sender, service_name,x,y,z,msg)
  local service = services[service_name]
  local answered = false
  if service then
    local players = {}
    for k,v in pairs(AQUA.rusers) do
      local player = AQUA.getUserSource(tonumber(k))
      -- check user
      if AQUA.hasPermission(k,service.alert_permission) and player ~= nil then
        table.insert(players,player)
      end
    end

    -- send notify and alert to all listening players
    for k,v in pairs(players) do
      AQUAclient.notify(v,{service.alert_notify..msg})
      -- add position for service.time seconds
      AQUAclient.addBlip(v,{x,y,z,service.blipid,service.blipcolor,"("..service_name..") "..msg}, function(bid)
        SetTimeout(service.alert_time*1000,function()
          AQUAclient.removeBlip(v,{bid})
        end)
      end)

      -- call request
      if sender ~= nil then
        AQUA.request(v,lang.phone.service.ask_call({service_name, htmlEntities.encode(msg)}), 30, function(v,ok)
          if ok then -- take the call
            if not answered then
              -- answer the call
              AQUAclient.notify(sender,{service.answer_notify})
              AQUAclient.setGPS(v,{x,y})
              answered = true
            else
              AQUAclient.notify(v,{lang.phone.service.taken()})
            end
          end
        end)
      end
    end
  end
end

-- send an sms from an user to a phone number
-- cbreturn true on success
function AQUA.sendSMS(user_id, phone, msg, cbr)
  local task = Task(cbr)

  if string.len(msg) > cfg.sms_size then -- clamp sms
    sms = string.sub(msg,1,cfg.sms_size)
  end

  AQUA.getUserIdentity(user_id, function(identity)
    AQUA.getUserByPhone(phone, function(dest_id)
      if identity and dest_id then
        local dest_src = AQUA.getUserSource(dest_id)
        if dest_src then
          local phone_sms = AQUA.getPhoneSMS(dest_id)

          if #phone_sms >= cfg.sms_history then -- remove last sms of the table
            table.remove(phone_sms)
          end

          local from = AQUA.getPhoneDirectoryName(dest_id, identity.phone).." ("..identity.phone..")"

          AQUAclient.notify(dest_src,{lang.phone.sms.notify({from, msg})})
          table.insert(phone_sms,1,{identity.phone,msg}) -- insert new sms at first position {phone,message}
          task({true})
        else
          task()
        end
      else
        task()
      end
    end)
  end)
end

-- send an smspos from an user to a phone number
-- cbreturn true on success
function AQUA.sendSMSPos(user_id, phone, x,y,z, cbr)
  local task = Task(cbr)

  AQUA.getUserIdentity(user_id, function(identity)
    AQUA.getUserByPhone(phone, function(dest_id)
      if identity and dest_id then
        local dest_src = AQUA.getUserSource(dest_id)
        if dest_src then
          local from = AQUA.getPhoneDirectoryName(dest_id, identity.phone).." ("..identity.phone..")"
          AQUAclient.notify(dest_src,{lang.phone.smspos.notify({from})}) -- notify
          -- add position for 5 minutes
          AQUAclient.addBlip(dest_src,{x,y,z,162,37,from}, function(bid)
            SetTimeout(cfg.smspos_duration*1000,function()
              AQUAclient.removeBlip(dest_src,{bid})
            end)
          end)

          task({true})
        else
          task()
        end
      else
        task()
      end
    end)
  end)
end

-- get phone directory data table
function AQUA.getPhoneDirectory(user_id)
  local data = AQUA.getUserDataTable(user_id)
  if data then
    if data.phone_directory == nil then
      data.phone_directory = {}
    end

    return data.phone_directory
  else
    return {}
  end
end

-- get directory name by number for a specific user
function AQUA.getPhoneDirectoryName(user_id, phone)
  local directory = AQUA.getPhoneDirectory(user_id)
  for k,v in pairs(directory) do
    if v == phone then
      return k
    end
  end

  return "unknown"
end
-- get phone sms tmp table
function AQUA.getPhoneSMS(user_id)
  local data = AQUA.getUserTmpTable(user_id)
  if data then
    if data.phone_sms == nil then
      data.phone_sms = {}
    end

    return data.phone_sms
  else
    return {}
  end
end

-- build phone menu
local phone_menu = {name=lang.phone.title(),css={top="75px",header_color="rgba(0,125,255,0.75)"}}

local function ch_directory(player,choice)
  local user_id = AQUA.getUserId(player)
  if user_id ~= nil then
    local phone_directory = AQUA.getPhoneDirectory(user_id)
    -- build directory menu
    local menu = {name=choice,css={top="75px",header_color="rgba(0,125,255,0.75)"}}

    local ch_add = function(player, choice) -- add to directory
      AQUA.prompt(player,lang.phone.directory.add.prompt_number(),"",function(player,phone)
        AQUA.prompt(player,lang.phone.directory.add.prompt_name(),"",function(player,name)
          name = sanitizeString(tostring(name),sanitizes.text[1],sanitizes.text[2])
          phone = sanitizeString(tostring(phone),sanitizes.text[1],sanitizes.text[2])
          if #name > 0 and #phone > 0 then
            phone_directory[name] = phone -- set entry
            AQUAclient.notify(player, {lang.phone.directory.add.added()})
          else
            AQUAclient.notify(player, {lang.common.invalid_value()})
          end
        end)
      end)
    end

    local ch_entry = function(player, choice) -- directory entry menu
      -- build entry menu
      local emenu = {name=choice,css={top="75px",header_color="rgba(0,125,255,0.75)"}}

      local name = choice
      local phone = phone_directory[name] or ""

      local ch_remove = function(player, choice) -- remove directory entry
        phone_directory[name] = nil
        AQUA.closeMenu(player) -- close entry menu (removed)
      end

      local ch_sendsms = function(player, choice) -- send sms to directory entry
        AQUA.prompt(player,lang.phone.directory.sendsms.prompt({cfg.sms_size}),"",function(player,msg)
          msg = sanitizeString(msg,sanitizes.text[1],sanitizes.text[2])
          AQUA.sendSMS(user_id, phone, msg, function(ok)
            if ok then
              AQUAclient.notify(player,{lang.phone.directory.sendsms.sent({phone})})
            else
              AQUAclient.notify(player,{lang.phone.directory.sendsms.not_sent({phone})})
            end
          end)
        end)
      end

      local ch_sendpos = function(player, choice) -- send current position to directory entry
        AQUAclient.getPosition(player,{},function(x,y,z)
          AQUA.sendSMSPos(user_id, phone, x,y,z,function(ok)
            if ok then
              AQUAclient.notify(player,{lang.phone.directory.sendsms.sent({phone})})
            else
              AQUAclient.notify(player,{lang.phone.directory.sendsms.not_sent({phone})})
            end
          end)
        end)
      end

      emenu[lang.phone.directory.sendsms.title()] = {ch_sendsms}
      emenu[lang.phone.directory.sendpos.title()] = {ch_sendpos}
      emenu[lang.phone.directory.remove.title()] = {ch_remove}

      -- nest menu to directory
      emenu.onclose = function() ch_directory(player,lang.phone.directory.title()) end

      -- open mnu
      AQUA.openMenu(player, emenu)
    end

    menu[lang.phone.directory.add.title()] = {ch_add}

    for k,v in pairs(phone_directory) do -- add directory entries (name -> number)
      menu[k] = {ch_entry,v}
    end

    -- nest directory menu to phone (can't for now)
    -- menu.onclose = function(player) AQUA.openMenu(player, phone_menu) end

    -- open menu
    AQUA.openMenu(player,menu)
  end
end

local function ch_sms(player, choice)
  local user_id = AQUA.getUserId(player)
  if user_id ~= nil then
    local phone_sms = AQUA.getPhoneSMS(user_id)

    -- build sms list
    local menu = {name=choice,css={top="75px",header_color="rgba(0,125,255,0.75)"}}

    -- add sms
    for k,v in pairs(phone_sms) do
      local from = AQUA.getPhoneDirectoryName(user_id, v[1]).." ("..v[1]..")"
      local phone = v[1]
      menu["#"..k.." "..from] = {function(player,choice)
        -- answer to sms
        AQUA.prompt(player,lang.phone.directory.sendsms.prompt({cfg.sms_size}),"",function(player,msg)
          msg = sanitizeString(msg,sanitizes.text[1],sanitizes.text[2])
          AQUA.sendSMS(user_id, phone, msg, function(ok)
            if ok then
              AQUAclient.notify(player,{lang.phone.directory.sendsms.sent({phone})})
            else
              AQUAclient.notify(player,{lang.phone.directory.sendsms.not_sent({phone})})
            end
          end)
        end)
      end, lang.phone.sms.info({from,htmlEntities.encode(v[2])})}
    end

    -- nest menu
    menu.onclose = function(player) AQUA.openMenu(player, phone_menu) end

    -- open menu
    AQUA.openMenu(player,menu)
  end
end

-- build service menu
local service_menu = {name=lang.phone.service.title(),css={top="75px",header_color="rgba(0,125,255,0.75)"}}

-- nest menu
service_menu.onclose = function(player) AQUA.openMenu(player, phone_menu) end

local function ch_service_alert(player,choice) -- alert a service
  local service = services[choice]
  if service then
    AQUAclient.getPosition(player,{},function(x,y,z)
      AQUA.prompt(player,lang.phone.service.prompt(),"",function(player, msg)
			  msg = sanitizeString(msg,sanitizes.text[1],sanitizes.text[2])
	  	  if msg ~= nil and msg ~= "" then
			    AQUAclient.notify(player,{service.notify}) -- notify player
			    AQUA.sendServiceAlert(player,choice,x,y,z,msg) -- send service alert (call request)
		    else
			    AQUAclient.notify(player,{"Empty Message."})
	      end
      end)
    end)
  end
end

for k,v in pairs(services) do
  service_menu[k] = {ch_service_alert}
end

local function ch_service(player, choice)
  AQUA.openMenu(player,service_menu)
end

-- build announce menu
local announce_menu = {name=lang.phone.announce.title(),css={top="75px",header_color="rgba(0,125,255,0.75)"}}

-- nest menu
announce_menu.onclose = function(player) AQUA.openMenu(player, phone_menu) end

local function ch_announce_alert(player,choice) -- alert a announce
  local announce = announces[choice]
  local user_id = AQUA.getUserId(player)
  if announce and user_id ~= nil then
    if announce.permission == nil or AQUA.hasPermission(user_id,announce.permission) then
      AQUA.prompt(player,lang.phone.announce.prompt(),"",function(player, msg)
        msg = sanitizeString(msg,sanitizes.text[1],sanitizes.text[2])
        if string.len(msg) > 10 and string.len(msg) < 1000 then
          if announce.price <= 0 or AQUA.tryPayment(user_id, announce.price) then -- try to pay the announce
            AQUAclient.notify(player, {lang.money.paid({announce.price})})

            msg = htmlEntities.encode(msg)
            msg = string.gsub(msg, "\n", "<br />") -- allow returns

            -- send announce to all
            local users = AQUA.getUsers()
            for k,v in pairs(users) do
              AQUAclient.announce(v,{announce.image,msg})
            end
          else
            AQUAclient.notify(player, {lang.money.not_enough()})
          end
        else
          AQUAclient.notify(player, {lang.common.invalid_value()})
        end
      end)
    else
      AQUAclient.notify(player, {lang.common.not_allowed()})
    end
  end
end

for k,v in pairs(announces) do
  announce_menu[k] = {ch_announce_alert,lang.phone.announce.item_desc({v.price,v.description or ""})}
end

local function ch_announce(player, choice)
  AQUA.openMenu(player,announce_menu)
end

phone_menu[lang.phone.directory.title()] = {ch_directory,lang.phone.directory.description()}
phone_menu[lang.phone.sms.title()] = {ch_sms,lang.phone.sms.description()}
phone_menu[lang.phone.service.title()] = {ch_service,lang.phone.service.description()}
phone_menu[lang.phone.announce.title()] = {ch_announce,lang.phone.announce.description()}

-- phone menu static builder after 10 seconds
SetTimeout(10000, function()
  AQUA.buildMenu("phone", {}, function(menu)
    for k,v in pairs(menu) do
      phone_menu[k] = v
    end
  end)
end)


