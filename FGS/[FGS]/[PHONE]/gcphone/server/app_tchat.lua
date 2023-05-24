function TchatGetMessageChannel(a, b)
    exports['sql']:execute("SELECT * FROM phone_app_chat WHERE channel = @channel ORDER BY time DESC LIMIT 100",{['@channel']=a},b)
end
  
function TchatAddMessage(a, b)
    exports['sql']:execute("INSERT INTO phone_app_chat (channel, message) VALUES(@channel, @message)",{['@channel']=a,['@message']=b}, function(data)
        exports['sql']:execute("SELECT * from phone_app_chat WHERE id = @id", {['@id'] = data.insertId }, function(rows)
            TriggerClientEvent('gcPhone:tchat_receive',-1, rows[1])
        end)
    end)
end
  
  
RegisterServerEvent('gcPhone:tchat_channel')
AddEventHandler('gcPhone:tchat_channel', function(channel)
    local sourcePlayer = tonumber(source)
    TchatGetMessageChannel(channel, function (messages)
        TriggerClientEvent('gcPhone:tchat_channel', sourcePlayer, channel, messages)
    end)
end)
  
RegisterServerEvent('gcPhone:tchat_addMessage')
AddEventHandler('gcPhone:tchat_addMessage', function(channel, message)
    TchatAddMessage(channel, message)
end)
