RegisterServerEvent('CXRP:openCarDev')
AddEventHandler('CXRP:openCarDev', function()
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id ~= nil and vRP.hasPermission(user_id, "cardev.menu") then 
      vRPclient.openCarDev(source,{})
    end
end)

RegisterServerEvent('CXRP:setCarDev')
AddEventHandler('CXRP:setCarDev', function(status)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id ~= nil and vRP.hasPermission(user_id, "cardev.menu") then 
      if status then
        SetPlayerRoutingBucket(source, 10)
      else
        SetPlayerRoutingBucket(source, 0)
      end
    end
end)

RegisterServerEvent('CXRP:takeCarScreenshot')
AddEventHandler('CXRP:takeCarScreenshot', function()
    local source = source
    local user_id = vRP.getUserId(source)
    local name = GetPlayerName(source)
    if user_id ~= nil and vRP.hasPermission(user_id, "cardev.menu") then 
        exports["discord-screenshot"]:requestClientScreenshotUploadToDiscord(source,{username = " Car Screenshots"},30000,function(error)
            if error then
                return print("^1ERROR: " .. error)
            end
        end)
    end   
end)

RegisterServerEvent("CXRP:getCarDevDebug")
AddEventHandler("CXRP:getCarDevDebug", function(text)
   local source = source
   local user_id = vRP.getUserId(source)
   local command = {
      {
        ["color"] = "16777215",
        ["title"] = "Requested by "..GetPlayerName(source).." Perm ID: "..user_id.."",
        ["description"] = text[1],
        ["footer"] = {
          ["text"] = "CX - "..os.date("%X"),
          ["icon_url"] = "", -- LOGO
        }
      }
    }
    PerformHttpRequest("https://discord.com/api/webhooks/1038945323059511446/09cC8Ds5YMPODAX5TSWtZen2K68N2oLY2CQjZJn49UwWphWGWQO_Au-O29PN849ff9cf", function(err, text, headers) end, 'POST', json.encode({username = "vRP Staff Logs", embeds = command}), { ['Content-Type'] = 'application/json' })
end)