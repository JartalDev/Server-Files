AddEventHandler('chat:addMessage', function(source, args, rawCommand)
  local playerName = GetPlayerName(source)
  local user_id = vRP.getUserId(source)
  local msg = rawCommand
  local webhook = "https://discord.com/api/webhooks/982455309861785641/I_t1-NBcnuugGHAQrpC48YH_0a0NGeX07FgsnjBz2qsUHRIH3Vwvv0_bBbqoFLWMZ889"
  PerformHttpRequest(webhook, function(err, text, headers) 
  end, "POST", json.encode({username = "FGS Roleplay", embeds = {
    {
      ["color"] = "15158332",
      ["title"] = "Message: "..msg,
      ["description"] = "Name: **"..playerName.."** \nPermID: **"..user_id.."** \nType: **Tweet**",
      ["footer"] = {
        ["text"] = "Time - "..os.date("%x %X %p"),
      }
  }
}}), { ["Content-Type"] = "application/json" })
  TriggerClientEvent('chat:addMessage', -1, {
      template = '<div style="padding: 0.5vw; margin: 0.4vw; background-color: rgba(28, 160, 242, 0.6); border-radius: 4px;"><i class="fab fa-twitter"></i> Twitter | @{0}: {1}</div>',
      args = { playerName, msg }
  })
end)

RegisterCommand('anon', function(source, args, rawCommand)
    local playerName = GetPlayerName(source)
    local user_id = vRP.getUserId(source)
    local msg = rawCommand:sub(5)
    local webhook = "https://discord.com/api/webhooks/982455309861785641/I_t1-NBcnuugGHAQrpC48YH_0a0NGeX07FgsnjBz2qsUHRIH3Vwvv0_bBbqoFLWMZ889"
    PerformHttpRequest(webhook, function(err, text, headers) 
    end, "POST", json.encode({username = "FGS Roleplay", embeds = {
      {
          ["color"] = "15158332",
          ["title"] = "Message: "..msg,
          ["description"] = "Name: **"..playerName.."** \nPermID: **"..user_id.."** \nType: **Anonymous**",
          ["footer"] = {
            ["text"] = "Time - "..os.date("%x %X %p"),
          }
      }
  }}), { ["Content-Type"] = "application/json" })
    TriggerClientEvent('chat:addMessage', -1, {
        template = '<div style="padding: 0.5vw; margin: 0.4vw; background-color: rgba(2, 160, 242, 0.6); border-radius: 4px;"><i class="fab fa-twitter"></i> Twitter | @^1Anonymous^7: {1}</div>',
        args = { playerName, msg }
    })
end, false)

RegisterCommand('ooc', function(source, args, rawCommand)
  local playerName = GetPlayerName(source)
  local msg = rawCommand:sub(2)
  local user_id = vRP.getUserId(source)
  local webhook = "https://discord.com/api/webhooks/982455309861785641/I_t1-NBcnuugGHAQrpC48YH_0a0NGeX07FgsnjBz2qsUHRIH3Vwvv0_bBbqoFLWMZ889"
  PerformHttpRequest(webhook, function(err, text, headers) end, "POST", json.encode({username = "FGS Roleplay", embeds = {{["color"] = "15158332",["title"] = "Message: "..msg,["description"] = "Name: **"..playerName.."** \nPermID: **"..user_id.."** \nType: **OOC**",["footer"] = {["text"] = "Time - "..os.date("%x %X %p"),}}}}), { ["Content-Type"] = "application/json" })
  if vRP.hasGroup(user_id, 'founder') then
    TriggerClientEvent('chat:addMessage', -1, {
      template = '<div style="padding: 0.5vw; margin: 0.4vw; background-color: rgba(41, 41, 41, 0.6); border-radius: 4px;"><i class="fas fa-globe"></i> OOC | ^1Founder^7 {0}: {1}</div>',
      args = { playerName, msg }
    })
  elseif vRP.hasGroup(user_id, 'dev') then
    TriggerClientEvent('chat:addMessage', -1, {
      template = '<div style="padding: 0.5vw; margin: 0.4vw; background-color: rgba(41, 41, 41, 0.6); border-radius: 4px;"><i class="fas fa-globe"></i> OOC | ^2Developer^7 {0}: {1}</div>',
      args = { playerName, msg }
    })
  elseif vRP.hasGroup(user_id, 'commdirect') then
    TriggerClientEvent('chat:addMessage', -1, {
      template = '<div style="padding: 0.5vw; margin: 0.4vw; background-color: rgba(41, 41, 41, 0.6); border-radius: 4px;"><i class="fas fa-globe"></i> OOC | ^5Community Manager^7 {0}: {1}</div>',
      args = { playerName, msg }
    })
  elseif vRP.hasGroup(user_id, 'generalmanager') then
    TriggerClientEvent('chat:addMessage', -1, {
      template = '<div style="padding: 0.5vw; margin: 0.4vw; background-color: rgba(41, 41, 41, 0.6); border-radius: 4px;"><i class="fas fa-globe"></i> OOC | ^5General Manager^7 {0}: {1}</div>',
      args = { playerName, msg }
    })
  elseif vRP.hasGroup(user_id, 'staffmanager') then
    TriggerClientEvent('chat:addMessage', -1, {
      template = '<div style="padding: 0.5vw; margin: 0.4vw; background-color: rgba(41, 41, 41, 0.6); border-radius: 4px;"><i class="fas fa-globe"></i> OOC | ^5Staff Manager^7 {0}: {1}</div>',
      args = { playerName, msg }
    })
  elseif vRP.hasGroup(user_id, 'headadmin') then
    TriggerClientEvent('chat:addMessage', -1, {
      template = '<div style="padding: 0.5vw; margin: 0.4vw; background-color: rgba(41, 41, 41, 0.6); border-radius: 4px;"><i class="fas fa-globe"></i> OOC | ^8Head Admin^7 {0}: {1}</div>',
      args = { playerName, msg }
    })

    
  elseif vRP.hasGroup(user_id, 'senioradmin') then
    TriggerClientEvent('chat:addMessage', -1, {
      template = '<div style="padding: 0.5vw; margin: 0.4vw; background-color: rgba(41, 41, 41, 0.6); border-radius: 4px;"><i class="fas fa-globe"></i> OOC | ^8Senior Admin^7 {0}: {1}</div>',
      args = { playerName, msg }
    })
  elseif vRP.hasGroup(user_id, 'administrator') then
    TriggerClientEvent('chat:addMessage', -1, {
      template = '<div style="padding: 0.5vw; margin: 0.4vw; background-color: rgba(41, 41, 41, 0.6); border-radius: 4px;"><i class="fas fa-globe"></i> OOC | ^8Admin^7 {0}: {1}</div>',
      args = { playerName, msg }
    })
  elseif vRP.hasGroup(user_id, 'srmoderator') then
    TriggerClientEvent('chat:addMessage', -1, {
      template = '<div style="padding: 0.5vw; margin: 0.4vw; background-color: rgba(41, 41, 41, 0.6); border-radius: 4px;"><i class="fas fa-globe"></i> OOC | ^8Senior Moderator^7 {0}: {1}</div>',
      args = { playerName, msg }
    })
  elseif vRP.hasGroup(user_id, 'moderator') then
    TriggerClientEvent('chat:addMessage', -1, {
      template = '<div style="padding: 0.5vw; margin: 0.4vw; background-color: rgba(41, 41, 41, 0.6); border-radius: 4px;"><i class="fas fa-globe"></i> OOC | ^8Moderator^7 {0}: {1}</div>',
      args = { playerName, msg }
    })
  elseif vRP.hasGroup(user_id, 'supportteam') then
    TriggerClientEvent('chat:addMessage', -1, {
      template = '<div style="padding: 0.5vw; margin: 0.4vw; background-color: rgba(41, 41, 41, 0.6); border-radius: 4px;"><i class="fas fa-globe"></i> OOC | ^8Support Team^7 {0}: {1}</div>',
      args = { playerName, msg }
    })
  elseif vRP.hasGroup(user_id, 'trialstaff') then
    TriggerClientEvent('chat:addMessage', -1, {
      template = '<div style="padding: 0.5vw; margin: 0.4vw; background-color: rgba(41, 41, 41, 0.6); border-radius: 4px;"><i class="fas fa-globe"></i> OOC | ^8Trial Staff^7 {0}: {1}</div>',
      args = { playerName, msg }
    })
    --dono 
  elseif vRP.hasGroup(user_id, 'bronze') then
    TriggerClientEvent('chat:addMessage', -1, {
      template = '<div style="padding: 0.5vw; margin: 0.4vw; background-color: rgba(41, 41, 41, 0.6); border-radius: 4px;"><i class="fas fa-globe"></i> OOC | ^8 {0}: ^7 {1}</div>',
      args = { playerName, msg }
    })
  elseif vRP.hasGroup(user_id, 'silver') then
    TriggerClientEvent('chat:addMessage', -1, {
      template = '<div style="padding: 0.5vw; margin: 0.4vw; background-color: rgba(41, 41, 41, 0.6); border-radius: 4px;"><i class="fas fa-globe"></i> OOC | ^9 {0}: ^7 {1}</div>',
      args = { playerName, msg }
    })
  elseif vRP.hasGroup(user_id, 'gold') then
    TriggerClientEvent('chat:addMessage', -1, {
      template = '<div style="padding: 0.5vw; margin: 0.4vw; background-color: rgba(41, 41, 41, 0.6); border-radius: 4px;"><i class="fas fa-globe"></i> OOC | ^3 {0}: ^7 {1}</div>',
      args = { playerName, msg }
    })
  elseif vRP.hasGroup(user_id, 'diamond') then
    TriggerClientEvent('chat:addMessage', -1, {
      template = '<div style="padding: 0.5vw; margin: 0.4vw; background-color: rgba(41, 41, 41, 0.6); border-radius: 4px;"><i class="fas fa-globe"></i> OOC | ^5 {0}: ^7 {1}</div>',
      args = { playerName, msg }
    }) 
  elseif vRP.hasGroup(user_id, 'platinum') then
    TriggerClientEvent('chat:addMessage', -1, {
      template = '<div style="padding: 0.5vw; margin: 0.4vw; background-color: rgba(41, 41, 41, 0.6); border-radius: 4px;"><i class="fas fa-globe"></i> OOC | ^6 {0}: ^7 {1}</div>',
      args = { playerName, msg }
    })  
    --end             
  else
    TriggerClientEvent('chat:addMessage', -1, {
        template = '<div style="padding: 0.5vw; margin: 0.4vw; background-color: rgba(41, 41, 41, 0.6); border-radius: 4px;"><i class="fas fa-globe"></i> OOC | {0}: {1}</div>',
        args = { playerName, msg }
    })
  end
end, false)

RegisterCommand('/', function(source, args, rawCommand)
  local playerName = GetPlayerName(source)
  local msg = rawCommand:sub(2)
  local user_id = vRP.getUserId(source)
  local webhook = "https://discord.com/api/webhooks/982455309861785641/I_t1-NBcnuugGHAQrpC48YH_0a0NGeX07FgsnjBz2qsUHRIH3Vwvv0_bBbqoFLWMZ889"
  PerformHttpRequest(webhook, function(err, text, headers) end, "POST", json.encode({username = "FGS Roleplay", embeds = {{["color"] = "15158332",["title"] = "Message: "..msg,["description"] = "Name: **"..playerName.."** \nPermID: **"..user_id.."** \nType: **OOC**",["footer"] = {["text"] = "Time - "..os.date("%x %X %p"),}}}}), { ["Content-Type"] = "application/json" })
  if vRP.hasGroup(user_id, 'founder') then
    TriggerClientEvent('chat:addMessage', -1, {
      template = '<div style="padding: 0.5vw; margin: 0.4vw; background-color: rgba(41, 41, 41, 0.6); border-radius: 4px;"><i class="fas fa-globe"></i> OOC | ^1Founder^7 {0}: {1}</div>',
      args = { playerName, msg }
    })
  elseif vRP.hasGroup(user_id, 'dev') then
    TriggerClientEvent('chat:addMessage', -1, {
      template = '<div style="padding: 0.5vw; margin: 0.4vw; background-color: rgba(41, 41, 41, 0.6); border-radius: 4px;"><i class="fas fa-globe"></i> OOC | ^2Lead Developer^7 {0}: {1}</div>',
      args = { playerName, msg }
    })
  elseif vRP.hasGroup(user_id, 'commdirect') then
    TriggerClientEvent('chat:addMessage', -1, {
      template = '<div style="padding: 0.5vw; margin: 0.4vw; background-color: rgba(41, 41, 41, 0.6); border-radius: 4px;"><i class="fas fa-globe"></i> OOC | ^5Community Manager^7 {0}: {1}</div>',
      args = { playerName, msg }
    })
  elseif vRP.hasGroup(user_id, 'generalmanager') then
    TriggerClientEvent('chat:addMessage', -1, {
      template = '<div style="padding: 0.5vw; margin: 0.4vw; background-color: rgba(41, 41, 41, 0.6); border-radius: 4px;"><i class="fas fa-globe"></i> OOC | ^5General Manager^7 {0}: {1}</div>',
      args = { playerName, msg }
    })
  elseif vRP.hasGroup(user_id, 'staffmanager') then
    TriggerClientEvent('chat:addMessage', -1, {
      template = '<div style="padding: 0.5vw; margin: 0.4vw; background-color: rgba(41, 41, 41, 0.6); border-radius: 4px;"><i class="fas fa-globe"></i> OOC | ^5Staff Manager^7 {0}: {1}</div>',
      args = { playerName, msg }
    })
  elseif vRP.hasGroup(user_id, 'headadmin') then
    TriggerClientEvent('chat:addMessage', -1, {
      template = '<div style="padding: 0.5vw; margin: 0.4vw; background-color: rgba(41, 41, 41, 0.6); border-radius: 4px;"><i class="fas fa-globe"></i> OOC | ^8Head Admin^7 {0}: {1}</div>',
      args = { playerName, msg }
    })

    
  elseif vRP.hasGroup(user_id, 'senioradmin') then
    TriggerClientEvent('chat:addMessage', -1, {
      template = '<div style="padding: 0.5vw; margin: 0.4vw; background-color: rgba(41, 41, 41, 0.6); border-radius: 4px;"><i class="fas fa-globe"></i> OOC | ^8Senior Admin^7 {0}: {1}</div>',
      args = { playerName, msg }
    })
  elseif vRP.hasGroup(user_id, 'administrator') then
    TriggerClientEvent('chat:addMessage', -1, {
      template = '<div style="padding: 0.5vw; margin: 0.4vw; background-color: rgba(41, 41, 41, 0.6); border-radius: 4px;"><i class="fas fa-globe"></i> OOC | ^8Admin^7 {0}: {1}</div>',
      args = { playerName, msg }
    })
  elseif vRP.hasGroup(user_id, 'srmoderator') then
    TriggerClientEvent('chat:addMessage', -1, {
      template = '<div style="padding: 0.5vw; margin: 0.4vw; background-color: rgba(41, 41, 41, 0.6); border-radius: 4px;"><i class="fas fa-globe"></i> OOC | ^8Senior Moderator^7 {0}: {1}</div>',
      args = { playerName, msg }
    })
  elseif vRP.hasGroup(user_id, 'moderator') then
    TriggerClientEvent('chat:addMessage', -1, {
      template = '<div style="padding: 0.5vw; margin: 0.4vw; background-color: rgba(41, 41, 41, 0.6); border-radius: 4px;"><i class="fas fa-globe"></i> OOC | ^8Moderator^7 {0}: {1}</div>',
      args = { playerName, msg }
    })
  elseif vRP.hasGroup(user_id, 'supportteam') then
    TriggerClientEvent('chat:addMessage', -1, {
      template = '<div style="padding: 0.5vw; margin: 0.4vw; background-color: rgba(41, 41, 41, 0.6); border-radius: 4px;"><i class="fas fa-globe"></i> OOC | ^8Support Team^7 {0}: {1}</div>',
      args = { playerName, msg }
    })
  elseif vRP.hasGroup(user_id, 'trialstaff') then
    TriggerClientEvent('chat:addMessage', -1, {
      template = '<div style="padding: 0.5vw; margin: 0.4vw; background-color: rgba(41, 41, 41, 0.6); border-radius: 4px;"><i class="fas fa-globe"></i> OOC | ^8Trial Staff^7 {0}: {1}</div>',
      args = { playerName, msg }
    })
    --dono 
  elseif vRP.hasGroup(user_id, 'bronze') then
    TriggerClientEvent('chat:addMessage', -1, {
      template = '<div style="padding: 0.5vw; margin: 0.4vw; background-color: rgba(41, 41, 41, 0.6); border-radius: 4px;"><i class="fas fa-globe"></i> OOC | ^8 {0}: ^7 {1}</div>',
      args = { playerName, msg }
    })
  elseif vRP.hasGroup(user_id, 'silver') then
    TriggerClientEvent('chat:addMessage', -1, {
      template = '<div style="padding: 0.5vw; margin: 0.4vw; background-color: rgba(41, 41, 41, 0.6); border-radius: 4px;"><i class="fas fa-globe"></i> OOC | ^9 {0}: ^7 {1}</div>',
      args = { playerName, msg }
    })
  elseif vRP.hasGroup(user_id, 'gold') then
    TriggerClientEvent('chat:addMessage', -1, {
      template = '<div style="padding: 0.5vw; margin: 0.4vw; background-color: rgba(41, 41, 41, 0.6); border-radius: 4px;"><i class="fas fa-globe"></i> OOC | ^3 {0}: ^7 {1}</div>',
      args = { playerName, msg }
    })
  elseif vRP.hasGroup(user_id, 'diamond') then
    TriggerClientEvent('chat:addMessage', -1, {
      template = '<div style="padding: 0.5vw; margin: 0.4vw; background-color: rgba(41, 41, 41, 0.6); border-radius: 4px;"><i class="fas fa-globe"></i> OOC | ^5 {0}: ^7 {1}</div>',
      args = { playerName, msg }
    })
  elseif vRP.hasGroup(user_id, 'platinum') then
    TriggerClientEvent('chat:addMessage', -1, {
      template = '<div style="padding: 0.5vw; margin: 0.4vw; background-color: rgba(41, 41, 41, 0.6); border-radius: 4px;"><i class="fas fa-globe"></i> OOC | ^6 {0}: ^7 {1}</div>',
      args = { playerName, msg }
    })   
    --end      
  else
    TriggerClientEvent('chat:addMessage', -1, {
        template = '<div style="padding: 0.5vw; margin: 0.4vw; background-color: rgba(41, 41, 41, 0.6); border-radius: 4px;"><i class="fas fa-globe"></i> OOC | {0}: {1}</div>',
        args = { playerName, msg }
    })
  end
end, false)


function stringsplit(inputstr, sep)
  if sep == nil then
    sep = "%s"
  end
  local t={} ; i=1
  for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
    t[i] = str
    i = i + 1
  end
  return t
end

RegisterCommand('clear', function(source, args, rawCommand)
  local user_id = vRP.getUserId(source)
  if vRP.hasPermission(user_id, 'admin.ban') then
    TriggerClientEvent('chat:clear',source)
  else
    vRPclient.notify(source,{"~r~You do not have permission to use this command."})
  end
end, false)



RegisterServerEvent('FGS:BankCash')
AddEventHandler('FGS:BankCash', function()
    local user_id = vRP.getUserId(source)
    local bank = vRP.getBankMoney(user_id)
    local cash = vRP.getMoney(user_id)
    TriggerClientEvent('FGS:CashBankClient', source, bank, cash, user_id)
end)
