local users = {}

RegisterNetEvent("PlayerJoined")
AddEventHandler("PlayerJoined", function()
    local tempid = source
    local user_id = vRP.getUserId(source)
    if users[tempid] then
        --
    else
        users[tempid] = user_id
    end
end)

RegisterServerEvent("FGS:GetID")
AddEventHandler("FGS:GetID", function(args)
    local source = source
    local user_id = vRP.getUserId(args[1])
    local source2 = args[1]
    if user_id ~= nil then
        TriggerClientEvent('chat:addMessage', source, {
            template = '<div style="padding: 0.5vw; margin: 0.4vw; background-color: rgba(171, 7, 7, 0.6); border-radius: 4px;"><i class="fas fa-exclamation-triangle"></i> ^*System^r | TempID: ^3 {0} ^7PermID: ^3{1}^7.</div>',
            args = { args[1], user_id }
        })
    else
        for i, v in pairs(users) do
            if tonumber(i) == tonumber(args[1]) then
                TriggerClientEvent('chat:addMessage', source, {
                    template = '<div style="padding: 0.5vw; margin: 0.4vw; background-color: rgba(171, 7, 7, 0.6); border-radius: 4px;"><i class="fas fa-exclamation-triangle"></i> ^*System^r | TempID: ^3 {0} ^7PermID: ^3{1}^7.</div>',
                    args = { tostring(i), tostring(v) }
                })
            end
        end
    end
end)


RegisterCommand("getmyid", function(source)
    local user_id = vRP.getUserId(source)
    TriggerClientEvent('chat:addMessage', source, {
        template = '<div style="padding: 0.5vw; margin: 0.4vw; background-color: rgba(171, 7, 7, 0.6); border-radius: 4px;"><i class="fas fa-exclamation-triangle"></i> ^*System^r | Your Permanent ID is: {0}</div>',
        args = { user_id }
    })
end)

RegisterCommand("getmytempid", function(source)
    local temp_id = source
    TriggerClientEvent('chat:addMessage', source, {
        template = '<div style="padding: 0.5vw; margin: 0.4vw; background-color: rgba(171, 7, 7, 0.6); border-radius: 4px;"><i class="fas fa-exclamation-triangle"></i> ^*System^r | Your Temporary ID is: {0}</div>',
        args = { temp_id }
    })
end)