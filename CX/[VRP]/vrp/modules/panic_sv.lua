local sv_police = false

tvRP.getInfo = function()
    local user_id = vRP.getUserId(source)

    if vRP.hasPermission(user_id, "pd.armory") then
        sv_police = true
    else
        sv_police = false
    end


    vRPclient.hasPoliceJob(source, {sv_police})
end

tvRP.PanicSV = function(s1, s2)
    local src = source

    for i, v in pairs(vRP.rusers) do
        local player = vRP.getUserSource(tonumber(i))
        local playername = GetPlayerName(src)
        if vRP.hasPermission(i, "pd.armory") then
            vRPclient.PanicCL(player, {src, s1, s2, playername})
        end
    end
    webhook = "https://discord.com/api/webhooks/1038909488071188650/8w_VUyjabMba-z3Cn2W5r_ll5u5a6CgP_zIQL5ghYLYdkS6GidnN40yYhpKIDWdz_8bT"
    PerformHttpRequest(webhook, function(err, text, headers) 
    end, "POST", json.encode({username = "Panic Logs", embeds = {
        {
            ["color"] = "15158332",
            ["title"] = "Panic button activated.",
            ["description"] = "**Officer Name:** "..GetPlayerName(src).."**\nOfficer ID:** "..vRP.getUserId(src).."**\nStreet:** "..s2,
            ["footer"] = {
                ["text"] = "Time - "..os.date("%x %X %p"),
            }
    }
    }}), { ["Content-Type"] = "application/json" })
end

tvRP.BlipSV = function(gx, gy, gz)
    for i, v in pairs(vRP.rusers) do
        if vRP.hasPermission(i, "pd.armory") then
            vRPclient.BlipCL(-1, {gx, gy, gz})
        end
    end
end