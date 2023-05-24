


-- Collecting Values --

local webhook = "https://discord.com/api/webhooks/982456000005165076/swj9qiWCY1ljgSW2HPnrm363g97TAB_IzlNDtqUMTW4LKF21yd459989HkjxF60O2-GB"
local name = "Leave/ Join Logs"
local logo = "" -- Must end with png, jpg e.t.c.



-- Player Connecting Event --

AddEventHandler('vRP:playerJoin', function(user_id, source)
    local playerName = GetPlayerName(source)
    local playerIp = "**[Hidden]**"
    local playerHex = GetPlayerIdentifier(source)
    local playerPing = GetPlayerPing(source)
    local connecting = {
        {
            ["color"] = "16777215",
            ["title"] = "Player Joining:",
            ["description"] = "User Name: **"..playerName.."**\n\nsource: **"..source.." | UserID: " .. user_id .. " **",
	        ["footer"] = {
                ["text"] = "Fivem Gaming Servers - "..os.date("%X"),
                ["icon_url"] = logo,
            },
        }
    }

    
-- Sending Embed To Discord Webhook --

PerformHttpRequest(webhook, function (err, text, headers) end, 'POST', json.encode({username = name, embeds = connecting}), { ['Content-Type'] = 'application/json' })

end)



-- Player Disconnecting Event --
AddEventHandler('vRP:playerLeave', function(userid, player, reason)
    local playerName = "N/A"
    if GetPlayerName(player) ~= nil then 
        playerName = GetPlayerName(player)
    end
    if reason == nil then 
        reason = "N/A"
    end

    if userid == nil then 
        userid = "Nil"
    end
    local disconnecting = {
        {
            ["color"] = "16777215",
            ["title"] = "Player Leaving:",
            ["description"] ="UserID: **" .. userid .. "** | User Name: **"..playerName.."**\n\nReason: *"..reason.."*" .. "\n\nSource: **" .. player .. "**",
            ["footer"] = {
                ["text"] = "Fivem Gaming Servers - "..os.date("%X"),
                ["icon_url"] = logo,
            },
        }
    }

    PerformHttpRequest(webhook, function (err, text, headers) end, 'POST', json.encode({username = name, embeds = disconnecting}), { ['Content-Type'] = 'application/json' })

end)