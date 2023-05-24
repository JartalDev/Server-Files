--[[platUsers = {}
platUsersByID = {}

local function checkPlat(user_id, source)
    local rows = exports['ghmattimysql']:executeSync("SELECT * FROM btf_plat WHERE user_id = @user_id", { user_id = user_id })
    if #rows > 0 then
        local hours = rows[1].hoursLeft
        if hours < 1 then
            exports['ghmattimysql']:executeSync("DELETE FROM btf_plat WHERE user_id = @user_id", { user_id = user_id })
            platUsers[source] = nil
            platUsersByID[user_id] = nil
            TriggerClientEvent('btf:client:updatePlat', source, hours, false)
            return
        end
        platUsers[source] = {
            user_id = user_id,
            hoursLeft = rows[1].hoursLeft
        }
        platUsersByID[user_id] = source
        TriggerClientEvent('btf:client:updatePlat', source, hours, true)
    else
        if platUsers[source] then
            platUsers[source] = nil
            platUsersByID[user_id] = nil
        end
    end
end

RegisterNetEvent("btfPlat:addPlus", function()
    local source = source
    local user_id = vRP.getUserId(source)
    vRP.prompt( source, 'UserID: ', '', function(source, user_targer)
        user_targer = tonumber(user_targer)
        if user_targer ~= nil and vRP.getUserSource(user_targer) ~= nil then
            vRP.prompt( source, 'Minutes: ', '', function(source, hours)
                hours = tonumber(hours)
                if hours ~= nil then
                    vRP.prompt( source, 'Money: ', '', function(source, amount)
                        amount = tonumber(amount)
                        if amount ~= nil then
                            if platUsers[source] ~= nil and platUsers[source].hoursLeft >= amount then
                                vRP.request(vRP.getUserSource(tonumber(user_targer)), 'Do you want to receive ' ..hours .. ' hourse for '..amount..'$', 15, function(player,ok)
                                    if ok then
                                        if vRP.tryBankPayment(user_targer,amount) then
                                            vRP.giveBankMoney(user_id,amount)
                                            addPlus(user_targer, hours)
                                            removePlus(user_id, hours)
                                            print(player, source)
                                            checkPlat(user_targer, player)
                                            checkPlat(user_id, source)
                                            vRPclient.notify(source, {"He accepted your offer"})
                                        end
                                    else
                                        vRPclient.notify(source, {"He didn't accept your offer"})
                                    end
                                end)
                            else
                                vRPclient.notify(source, {"You don't have hours"})
                            end
                        end
                    end )
                end
            end )
        else
            vRPclient.notify(source, {"Player isn't online"})
        end
    end )
end)

AddEventHandler('vRP:playerSpawn', function(user_id, source, first_spawn)
    checkPlat(user_id, source)
end)

AddEventHandler('playerDropped', function()
    local source = source
    if platUsers[source] then
        platUsers[source] = nil
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(60 * 1000)
        local rows = exports['ghmattimysql']:executeSync("SELECT * FROM btf_plat")
        for k, v in pairs(rows) do
            local userid = v.user_id
            local hoursLeft = v.hoursLeft
            if hoursLeft > 0 then
                hoursLeft = hoursLeft - 1
                exports['ghmattimysql']:execute("UPDATE btf_plat SET hoursLeft = @hoursLeft WHERE user_id = @user_id",
                    { user_id = userid, hoursLeft = hoursLeft }, function() end)
                print("[btf] " .. userid .. " has " .. hoursLeft .. " hours left on their plat.")
            else
                exports['ghmattimysql']:execute("DELETE FROM btf_plat WHERE user_id = @user_id", { user_id = userid },
                    function() end)
                print("[btf] " .. userid .. " has no plat.")
            end
        end
    end
end)

RegisterNetEvent('btf_plat:checkPlat')
AddEventHandler('btf_plat:checkPlat', function()
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        checkPlat(user_id, source)
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(15000)
        for k, v in pairs(platUsers) do
            local user_id = v.user_id
            local source = k
            local hoursLeft = v.hoursLeft
            if hoursLeft > 0 then
                TriggerClientEvent('btf:client:updatePlat', source, hoursLeft, true)
            else
                TriggerClientEvent('btf:client:updatePlat', source, hoursLeft, false)
            end
        end
    end
end)

RegisterNetEvent('btf:plat:craftMoped', function()
    local source = source
    local plat = platUsers[source]
    if plat then
        local hoursLeft = plat.hoursLeft
        if hoursLeft > 0 then
            vRPclient.notify(source, { "Crafting" })
            TriggerClientEvent('btf:client:spawnMoped', source)
        else
            vRPclient.notify(source, { "You do not have a plat" })
        end
    else
        vRPclient.notify(source, { "You do not have a plat" })
    end
end)

RegisterCommand('PrintTable', function(source, args, raw)
    print(json.encode(platUsers))
end)

RegisterCommand('AddPlus', function(source, args, raw)
    if source ~= 0 then return end
    addPlus(args[1], args[2])
end)

function addPlus(permid, hours)
    local permid = tonumber(permid)
    local hours = tonumber(hours)
    local rows = exports['ghmattimysql']:executeSync("SELECT * FROM btf_plat WHERE user_id = @user_id", { user_id = permid })
    if #rows > 0 then
        local hoursLeft = rows[1].hoursLeft
        hoursLeft = hoursLeft + hours
        exports['ghmattimysql']:execute("UPDATE btf_plat SET hoursLeft = @hoursLeft WHERE user_id = @user_id",
            { user_id = permid, hoursLeft = hoursLeft }, function() end)
        print("[btf] " .. permid .. " has " .. hoursLeft .. " hours left on their plat.")
    else
        exports['ghmattimysql']:execute("INSERT INTO btf_plat (user_id, hoursLeft) VALUES (@user_id, @hoursLeft)",
            { user_id = permid, hoursLeft = hours }, function() end)
        print("[btf] " .. permid .. " has " .. hours .. " hours left on their plat.")
    end
end

function removePlus(permid, hours)
    local permid = tonumber(permid)
    local hours = tonumber(hours)
    local rows = exports['ghmattimysql']:executeSync("SELECT * FROM btf_plat WHERE user_id = @user_id", { user_id = permid })
    if #rows > 0 then
        local hoursLeft = rows[1].hoursLeft
        hoursLeft = hoursLeft - hours
        exports['ghmattimysql']:execute("UPDATE btf_plat SET hoursLeft = @hoursLeft WHERE user_id = @user_id",
            { user_id = permid, hoursLeft = hoursLeft }, function() end)
        print("[btf] " .. permid .. " has " .. hoursLeft .. " hours left on their plat.")
    end
end
]]

platUsers = {}
platUsersByID = {}

local function checkPlat(user_id, source)
    local rows = exports['ghmattimysql']:executeSync("SELECT * FROM btf_plat WHERE user_id = @user_id", { user_id = user_id })
    if #rows > 0 then
        local time = rows[1].time
        local haveTime = getTimeTakingTIme(time, 0)
        if not haveTime then
            exports['ghmattimysql']:executeSync("DELETE FROM btf_plat WHERE user_id = @user_id", { user_id = user_id })
            platUsers[source] = nil
            platUsersByID[user_id] = nil
            TriggerClientEvent('btf:client:updatePlat', source, time, false)
            return
        end
        platUsers[source] = {
            user_id = user_id,
            time = rows[1].time
        }
        platUsersByID[user_id] = source
        TriggerClientEvent('btf:client:updatePlat', source, time, true)
    else
        if platUsers[source] then
            platUsers[source] = nil
            platUsersByID[user_id] = nil
        end
    end
end

RegisterNetEvent("btfPlat:addPlus", function()
    local source = source
    local user_id = vRP.getUserId(source)
    local days = 0
    vRP.prompt( source, 'UserID: ', '', function(source, user_targer)
        user_targer = tonumber(user_targer)
        if user_targer ~= nil and vRP.getUserSource(user_targer) ~= nil then
            vRP.prompt( source, 'Days: ', '', function(source, secoundsAmount)
                if tonumber(secoundsAmount) ~= nil then
                    days = secoundsAmount
                    secoundsAmount = tonumber(secoundsAmount) * 3600 * 24
                    vRP.prompt( source, 'Money: ', '', function(source, amount)
                        amount = tonumber(amount)
                        if amount ~= nil then
                            if platUsers[source] ~= nil then
                                local haveTime = getTimeTakingTIme(platUsers[source].time, secoundsAmount)
                                if haveTime then
                                    vRP.request(vRP.getUserSource(tonumber(user_targer)), 'Do you want to receive ' ..days .. ' days for '..amount..'$', 15, function(player,ok)
                                        if ok then
                                            if vRP.tryBankPayment(user_targer,amount) then
                                                vRP.giveBankMoney(user_id,amount)
                                                addPlus(user_targer, secoundsAmount)
                                                removePlus(user_id, secoundsAmount)
                                                checkPlat(user_targer, player)
                                                checkPlat(user_id, source)
                                                vRPclient.notify(source, {"He accepted your offer"})
                                            end
                                        else
                                            vRPclient.notify(source, {"He didn't accept your offer"})
                                        end
                                    end)
                                else
                                    vRPclient.notify(source, {"You don't have hours"})
                                end
                            end
                        end
                    end )
                end
            end )
        else
            vRPclient.notify(source, {"Player isn't online"})
        end
    end )
end)

AddEventHandler('vRP:playerSpawn', function(user_id, source, first_spawn)
    checkPlat(user_id, source)
end)

AddEventHandler('playerDropped', function()
    local source = source
    if platUsers[source] then
        platUsers[source] = nil
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        local rows = exports['ghmattimysql']:executeSync("SELECT * FROM btf_plat")
        for k, v in pairs(rows) do
            local userid = v.user_id
            local haveTime, day, hours, minute, secounds = getTimeTakingTIme(v.time, 1)
            if haveTime then
                exports['ghmattimysql']:execute("UPDATE btf_plat SET time = @time WHERE user_id = @user_id",
                    { user_id = userid, time = setTimeInString(day, hours, minute, secounds) }, function() end)
            else
                exports['ghmattimysql']:execute("DELETE FROM btf_plat WHERE user_id = @user_id", { user_id = userid },
                    function() end)
            end
        end
    end
end)

RegisterNetEvent('btf_plat:checkPlat')
AddEventHandler('btf_plat:checkPlat', function()
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        checkPlat(user_id, source)
    end
end)

--[[
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(15000)
        for k, v in pairs(platUsers) do
            local haveTime, day, hours, minute, secounds = getTimeTakingTIme(v.time, 0)
            if haveTime then
                TriggerClientEvent('btf:client:updatePlat', k, v.time, true)
            else
                TriggerClientEvent('btf:client:updatePlat', k, "00:00:00", false)
            end
        end
    end
end)]]

RegisterNetEvent('btf:plat:craftMoped', function()
    local source = source
    local plat = platUsers[source]
    if plat then
        local haveTime = getTimeTakingTIme(plat.time, 0)
        if haveTime then
            vRPclient.notify(source, { "Crafting" })
            TriggerClientEvent('btf:client:spawnMoped', source)
        else
            vRPclient.notify(source, { "You do not have a plat" })
        end
    else
        vRPclient.notify(source, { "You do not have a plat" })
    end
end)

RegisterCommand('PrintTable', function(source, args, raw)
    print(json.encode(platUsers))
end)

RegisterCommand('AddPlus', function(source, args, raw)
    if source ~= 0 then return end
    addPlus(args[1], args[2])
end)

function addPlus(permid, secounds)
    local permid = tonumber(permid)
    local secounds = tonumber(secounds)
    local rows = exports['ghmattimysql']:executeSync("SELECT * FROM btf_plat WHERE user_id = @user_id", { user_id = permid })
    if #rows > 0 then
        local day, hours, minute, secounds = getTimeAddingTIme(rows[1].time, secounds)
        exports['ghmattimysql']:execute("UPDATE btf_plat SET time = @time WHERE user_id = @user_id",
            { user_id = permid, time = setTimeInString(day, hours, minute, secounds) }, function() end)
    else
        local day, hours, minute, secounds = getTimeAddingTIme(0,secounds)
        exports['ghmattimysql']:execute("INSERT INTO btf_plat (user_id, time) VALUES (@user_id, @time)",
            { user_id = permid, time = setTimeInString(day, hours, minute, secounds) }, function() end)
    end
end

function removePlus(permid, secounds)
    local permid = tonumber(permid)
    local hours = tonumber(hours)
    local rows = exports['ghmattimysql']:executeSync("SELECT * FROM btf_plat WHERE user_id = @user_id", { user_id = permid })
    if #rows > 0 then
        local haveTime, day, hours, minute, secounds = getTimeTakingTIme(rows[1].time, secounds)
        exports['ghmattimysql']:execute("UPDATE btf_plat SET time = @time WHERE user_id = @user_id",
            { user_id = permid, time = setTimeInString(day, hours, minute, secounds) }, function() end)
    end
end

function getTimeOfString(texto)
    if type(texto) == "string" then
        texto = string.gsub(texto, ":", " ")
        local t={}
        local count = 1
        for str in string.gmatch(texto, "([^ ]+)") do
            t[count] = tonumber(str)
            count = count + 1
        end
        return t[1], t[2], t[3], t[4] 
    else
        return texto, texto, texto, texto
    end
end

function setTimeInString(day, hours, minute, secounds)
    return day..":"..hours..":"..minute..":"..secounds
end

function getTimeTakingTIme(data, tempo)
    local day, hours, minute, secounds = getTimeOfString(data)
    local haveTime = true
    secounds = secounds - tempo
    if secounds < 0 then
        minute = minute + math.floor(secounds / 60)
        secounds = math.floor(secounds % 60)
        if minute < 0 then
            hours = hours + math.floor(minute / 60)
            minute = minute % 60
            if hours < 0 then
                day = day + math.floor(hours / 24)
                hours = hours % 24
                if day < 0 then
                    minute = 0
                    secounds = 0
                    hours = 0
                    day = 0
                    haveTime = false
                end
            end
        end
    end

    return haveTime, day, hours, minute, secounds
end

function getTimeAddingTIme(data, time)
    local day, hours, minute, secounds = getTimeOfString(data)
    local extraTime
    secounds = secounds + time
    if secounds > 59 then
        extraTime = math.floor(secounds / 60)
        secounds = math.floor(secounds % 60)
        minute = minute + extraTime
        if minute > 59 then
            extraTime = math.floor(minute / 60)
            minute = minute % 60
            hours = hours + extraTime
            if hours > 24 then
                extraTime = math.floor(hours / 24)
                hours = hours % 24
                day = day + extraTime
            end
        end
    end
    return day, hours, minute, secounds
end