MySQL = module("sql", "MySQL")

local Proxy = module("lib/Proxy")
local Tunnel = module("lib/Tunnel")
local Lang = module("lib/Lang")










Debug = module("lib/Debug")

local config = module("cfg/base")

Debug.active = config.debug
vRP = {}
Proxy.addInterface("vRP",vRP)

tvRP = {}
Tunnel.bindInterface("vRP",tvRP) -- listening for client tunnel

-- load language 
local dict = module("cfg/lang/"..config.lang) or {}
vRP.lang = Lang.new(dict)

-- init
vRPclient = Tunnel.getInterface("vRP","vRP") -- server -> client tunnel

vRP.users = {} -- will store logged users (id) by first identifier
vRP.rusers = {} -- store the opposite of users
vRP.user_tables = {} -- user data tables (logger storage, saved to database)
vRP.user_tmp_tables = {} -- user tmp data tables (logger storage, not saved)
vRP.user_sources = {} -- user sources 
-- queries






MySQL.createCommand("vRP/add_phonenumber","INSERT INTO vrp_users2(identifier,number) VALUES(@identifier,@user_id)")
MySQL.createCommand("vRP/find_numbergg","SELECT * FROM vrp_users2 WHERE 'identifier' = @identifier")



MySQL.createCommand("vRP/create_user","INSERT INTO vrp_users(whitelisted,banned) VALUES(false,false)")
MySQL.createCommand("vRP/add_identifier","INSERT INTO vrp_user_ids(identifier,user_id) VALUES(@identifier,@user_id)")
MySQL.createCommand("vRP/userid_byidentifier","SELECT user_id FROM vrp_user_ids WHERE identifier = @identifier")
MySQL.createCommand("vRP/identifier_all","SELECT * FROM vrp_user_ids WHERE identifier = @identifier")
MySQL.createCommand("vRP/select_identifier_byid_all","SELECT * FROM vrp_user_ids WHERE user_id = @id")

MySQL.createCommand("vRP/set_userdata","REPLACE INTO vrp_user_data(user_id,dkey,dvalue) VALUES(@user_id,@key,@value)")
MySQL.createCommand("vRP/get_userdata","SELECT dvalue FROM vrp_user_data WHERE user_id = @user_id AND dkey = @key")

MySQL.createCommand("vRP/set_srvdata","REPLACE INTO vrp_srv_data(dkey,dvalue) VALUES(@key,@value)")
MySQL.createCommand("vRP/get_srvdata","SELECT dvalue FROM vrp_srv_data WHERE dkey = @key")

MySQL.createCommand("vRP/get_banned","SELECT banned FROM vrp_users WHERE id = @user_id")
MySQL.createCommand("vRP/set_banned","UPDATE vrp_users SET banned = @banned, bantime = @bantime,  banreason = @banreason,  banadmin = @banadmin WHERE id = @user_id")
MySQL.createCommand("vRP/set_identifierbanned","UPDATE vrp_user_ids SET banned = @banned WHERE identifier = @iden")
MySQL.createCommand("vRP/getbanreasontime", "SELECT * FROM vrp_users WHERE id = @user_id")

MySQL.createCommand("vRP/get_whitelisted","SELECT whitelisted FROM vrp_users WHERE id = @user_id")
MySQL.createCommand("vRP/set_whitelisted","UPDATE vrp_users SET whitelisted = @whitelisted WHERE id = @user_id")
MySQL.createCommand("vRP/set_last_login","UPDATE vrp_users SET last_login = @last_login WHERE id = @user_id")
MySQL.createCommand("vRP/get_last_login","SELECT last_login FROM vrp_users WHERE id = @user_id")

--Token Banning 
MySQL.createCommand("vRP/add_token","INSERT INTO vrp_user_tokens(token,user_id) VALUES(@token,@user_id)")
MySQL.createCommand("vRP/check_token","SELECT user_id, banned FROM vrp_user_tokens WHERE token = @token")
MySQL.createCommand("vRP/check_token_userid","SELECT token FROM vrp_user_tokens WHERE user_id = @id")
MySQL.createCommand("vRP/ban_token","UPDATE vrp_user_tokens SET banned = @banned WHERE token = @token")

MySQL.createCommand("vRPls/create_modifications_column", "alter table vrp_user_vehicles add if not exists modifications text not null")
MySQL.createCommand("vRPls/update_vehicle_modifications", "update vrp_user_vehicles set modifications = @modifications where user_id = @user_id and vehicle = @vehicle")
MySQL.createCommand("vRPls/get_vehicle_modifications", "select modifications from vrp_user_vehicles where user_id = @user_id and vehicle = @vehicle")
MySQL.execute("vRPls/create_modifications_column")


--make a MySQL Command that checks if the casino table has the userid passed inside it if not create it
MySQL.createCommand("vRP/getCasinoTable","SELECT * FROM casino WHERE user_id = @user_id")
--Token Banning

-- init tables


-- identification system

--- sql.
-- cbreturn user id or nil in case of error (if not found, will create it)
function vRP.getUserIdByIdentifiers(ids, cbr)
    local task = Task(cbr)
    if ids ~= nil and #ids then
        local i = 0
        local function search()
            i = i+1
            if i <= #ids then
                if (string.find(ids[i], "ip:") == nil) then 
                    MySQL.query("vRP/userid_byidentifier", {identifier = ids[i]}, function(rows, affected)

                        if #rows > 0 then  -- found
                            task({rows[1].user_id})
                        else -- not found
                            search()
                        end
                    end)

                else
                    search()
                end
            else -- no ids found, create user
                MySQL.query("vRP/create_user", {}, function(rows, affected)
                    if rows.affectedRows > 0 then
                        local user_id = rows.insertId
                        -- add identifiers
                        for l,w in pairs(ids) do
                            if (string.find(w, "ip:") == nil) then 
                                MySQL.execute("vRP/add_identifier", {user_id = user_id, identifier = w})
                            end
                        end
                        local license = false
                        for k,v in pairs(ids)do
                            if(string.match(v, "license:"))then
                                license = v
                                break
                            end
                        end
                        Wait(1000)
                        --check for number existing
                        numberhas = check_if_user_has_number(license)
                        if numberhas then
                        else
                            MySQL.execute("vRP/add_phonenumber", {identifier = license, user_id = getrandomphonenumber()})
                        end
                    task({user_id})
                    else
                        task()
                    end
                end)
            end
        end
        search()
    else
        task()
    end
end


function getrandomphonenumber()
    local foundPhone = 0
    while foundPhone == 0 do
        local randomNumber = math.random(100000000, 999999999)
        exports['sql']:execute("SELECT number FROM vrp_users2 WHERE number = @rand", {rand = randomNumber}, function(result)
            if(#result == 0) then
                foundPhone = randomNumber
            end
        end)
        Wait(1000)
    end
    return "07" .. tostring(foundPhone)
end
function check_if_user_has_number(id)
    local foundPhone = 0
    while foundPhone == 0 do
        exports['sql']:execute("SELECT number FROM vrp_users2 WHERE identifier = @identifier", {identifier = id}, function(result)
            if(#result == 0) then
                return false
            else
                return true
            end
        end)
        Wait(1000)
    end
end
-- return identification string for the source (used for non vRP identifications, for rejected players)
function vRP.getSourceIdKey(source)
    local ids = GetPlayerIdentifiers(source)
    local idk = "idk_"
    for k,v in pairs(ids) do
        idk = idk..v
    end
    
    return idk
end


function vRP.getPlayerEndpoint(player)
    if vRPConfig.DoNotDisplayIps then 
        return "^1 IP Hidden^7 "
    end
    return GetPlayerEP(player) or "0.0.0.0"
end

function vRP.getPlayerName(player)
    return GetPlayerName(player) or "unknown"
end

--- sql

function vRP.ReLoadChar(source)
    local name = GetPlayerName(source)
    local ids = GetPlayerIdentifiers(source)
    vRP.getUserIdByIdentifiers(ids, function(user_id)
        if user_id ~= nil then  
            vRP.StoreTokens(source, user_id) 
            if vRP.rusers[user_id] == nil then -- not present on the server, init
                vRP.users[ids[1]] = user_id
                vRP.rusers[user_id] = ids[1]
                vRP.user_tables[user_id] = {}
                vRP.user_tmp_tables[user_id] = {}
                vRP.user_sources[user_id] = source
                vRP.getUData(user_id, "vRP:datatable", function(sdata)
                    local data = json.decode(sdata)
                    if type(data) == "table" then vRP.user_tables[user_id] = data end
                    local tmpdata = vRP.getUserTmpTable(user_id)
                    vRP.getLastLogin(user_id, function(last_login)
                        tmpdata.last_login = last_login or ""
                        tmpdata.spawns = 0
                        local last_login_stamp = os.date("%H:%M:%S %d/%m/%Y")
                        MySQL.execute("vRP/set_last_login", {user_id = user_id, last_login = last_login_stamp})
                        print("[vRP] "..name.." joined (user_id = "..user_id..")")
                        TriggerEvent("vRP:playerJoin", user_id, source, name, tmpdata.last_login)
                        TriggerClientEvent("VRP:CheckIdRegister", source)
                    end)
                end)
            else -- already connected
                print("[vRP] "..name.." Rejoined (user_id = "..user_id..")")
                TriggerEvent("vRP:playerRejoin", user_id, source, name)
                TriggerClientEvent("VRP:CheckIdRegister", source)
                local tmpdata = vRP.getUserTmpTable(user_id)
                tmpdata.spawns = 0
            end
        end
    end)
end

-- This can only be used server side and is for the vRP bot. 
exports("vrpbot", function(method_name, params, cb)
    if cb then 
        cb(vRP[method_name](table.unpack(params)))
    else 
        return vRP[method_name](table.unpack(params))
    end
end)

RegisterNetEvent("VRP:CheckID")
AddEventHandler("VRP:CheckID", function()
    local user_id = vRP.getUserId(source)
    if not user_id then
        vRP.ReLoadChar(source)
    end
end)

function vRP.isBanned(user_id, cbr)
    local task = Task(cbr, {false})
    print('It Is Checking If I am Banned')
    MySQL.query("vRP/get_banned", {user_id = user_id}, function(rows, affected)
        if #rows > 0 then
            task({rows[1].banned})
        else
            task()
        end
    end)
end

--- sql

--- sql
function vRP.isWhitelisted(user_id, cbr)
    local task = Task(cbr, {false})
    
    MySQL.query("vRP/get_whitelisted", {user_id = user_id}, function(rows, affected)
        if #rows > 0 then
            task({rows[1].whitelisted})
        else
            task()
        end
    end)
end

--- sql
function vRP.setWhitelisted(user_id,whitelisted)
    MySQL.execute("vRP/set_whitelisted", {user_id = user_id, whitelisted = whitelisted})
end

--- sql
function vRP.getLastLogin(user_id, cbr)
    local task = Task(cbr,{""})
    MySQL.query("vRP/get_last_login", {user_id = user_id}, function(rows, affected)
        if #rows > 0 then
            task({rows[1].last_login})
        else
            task()
        end
    end)
end

function vRP.fetchBanReasonTime(user_id,cbr)
    MySQL.query("vRP/getbanreasontime", {user_id = user_id}, function(rows, affected)
        if #rows > 0 then 
            cbr(rows[1].bantime, rows[1].banreason, rows[1].banadmin)
        end
    end)
end

function vRP.setUData(user_id,key,value)
    MySQL.execute("vRP/set_userdata", {user_id = user_id, key = key, value = value})
end

function vRP.getUData(user_id,key,cbr)
    local task = Task(cbr,{""})
    
    MySQL.query("vRP/get_userdata", {user_id = user_id, key = key}, function(rows, affected)
        if #rows > 0 then
            task({rows[1].dvalue})
        else
            task()
        end
    end)
end

function vRP.setSData(key,value)
    MySQL.execute("vRP/set_srvdata", {key = key, value = value})
end

function vRP.getSData(key, cbr)
    local task = Task(cbr,{""})
    
    MySQL.query("vRP/get_srvdata", {key = key}, function(rows, affected)
        if rows and #rows > 0 then
            task({rows[1].dvalue})
        else
            task()
        end
    end)
end

-- return user data table for vRP internal persistant connected user storage
function vRP.getUserDataTable(user_id)
    return vRP.user_tables[user_id]
end

function vRP.getUserTmpTable(user_id)
    return vRP.user_tmp_tables[user_id]
end

function vRP.isConnected(user_id)
    return vRP.rusers[user_id] ~= nil
end

function vRP.isFirstSpawn(user_id)
    local tmp = vRP.getUserTmpTable(user_id)
    return tmp and tmp.spawns == 1
end

function vRP.getUserId(source)
    if source ~= nil then
        local ids = GetPlayerIdentifiers(source)
        if ids ~= nil and #ids > 0 then
            return vRP.users[ids[1]]
        end
    end
    
    return nil
end

-- return map of user_id -> player source
function vRP.getUsers()
    local users = {}
    for k,v in pairs(vRP.user_sources) do
        users[k] = v
    end
    
    return users
end

-- return source or nil
function vRP.getUserSource(user_id)
    return vRP.user_sources[user_id]
end

function vRP.IdentifierBanCheck(source,user_id,cb)
    for i,v in pairs(GetPlayerIdentifiers(source)) do 
        MySQL.query('vRP/identifier_all', {identifier = v}, function(rows)
            for i = 1,#rows do 
                if rows[i].banned then 
                    if user_id ~= rows[i].user_id then 
                        cb(true, rows[i].user_id)
                    end 
                end
            end
        end)
    end
end

function vRP.BanIdentifiers(user_id, value)
    MySQL.query('vRP/select_identifier_byid_all', {id = user_id}, function(rows)
        for i = 1, #rows do 
            MySQL.execute("vRP/set_identifierbanned", {banned = value, iden = rows[i].identifier })
        end
    end)
end

function vRP.setBanned(user_id,banned,time,reason, admin)
    if banned then 
        MySQL.execute("vRP/set_banned", {user_id = user_id, banned = banned, bantime = time, banreason = reason, banadmin = admin})
        vRP.BanIdentifiers(user_id, true)
        vRP.BanTokens(user_id, true) 
    else 
        MySQL.execute("vRP/set_banned", {user_id = user_id, banned = banned, bantime = "", banreason =  "", banadmin =  ""})
        vRP.BanIdentifiers(user_id, false)
        vRP.BanTokens(user_id, false) 
    end 
end

function vRP.ban(adminsource,permid,time,reason)
    local adminPermID = vRP.getUserId(adminsource)
    local getBannedPlayerSrc = vRP.getUserSource(tonumber(permid))
    if getBannedPlayerSrc then 
        if tonumber(time) then 
            local banTime = os.time()
            banTime = banTime  + (60 * 60 * tonumber(time))  
            vRP.setBanned(permid,true,banTime,reason, GetPlayerName(adminsource) .. " | ID Of Admin: " .. adminPermID)
            vRP.kick(getBannedPlayerSrc,"[FGS] You have been banned from this server. Your ban expires in: " .. os.date("%c", banTime) .. " Reason: " .. reason .. " | Banning Admin: " ..  GetPlayerName(adminsource) .. " | ID Of Admin: " .. adminPermID ) 
            vRPclient.notify(adminsource,{"~g~Success banned! User PermID:" .. permid})
        else 
            vRPclient.notify(adminsource,{"~g~Success banned! User PermID:" .. permid})
            vRP.setBanned(permid,true,"perm",reason, GetPlayerName(adminsource) .. " | ID Of Admin: " .. adminPermID)
            vRP.kick(getBannedPlayerSrc,"[FGS] You have been banned from this server. Your ban expires in: " .. "Never, you've been permanently banned." .. " Reason: " .. reason .. " | Banning Admin: " ..  GetPlayerName(adminsource) .. " | ID Of Admin: " .. adminPermID ) 
        end
    else 
        if tonumber(time) then 
            local banTime = os.time()
            banTime = banTime  + (60 * 60 * tonumber(time))  
            vRPclient.notify(adminsource,{"~g~Success banned! User PermID:" .. permid})
            vRP.setBanned(permid,true,banTime,reason, GetPlayerName(adminsource) .. " | ID Of Admin: " .. adminPermID)
        else 
            vRPclient.notify(adminsource,{"~g~Success banned! User PermID:" .. permid})
            vRP.setBanned(permid,true,"perm",reason, GetPlayerName(adminsource) .. " | ID Of Admin: " .. adminPermID)
        end
    end
end

function vRP.banConsole(permid,time,reason)
    local adminPermID = "Console Ban"
    local getBannedPlayerSrc = vRP.getUserSource(tonumber(permid))
    if getBannedPlayerSrc then 
        if tonumber(time) then 
            local banTime = os.time()
            banTime = banTime  + (60 * 60 * tonumber(time))  
            vRP.setBanned(permid,true,banTime,reason,  'Console' .. " | ID Of Admin: " .. adminPermID)
            vRP.kick(getBannedPlayerSrc,"You have been banned from this server. Your ban expires in: " .. os.date("%c", banTime) .. " Reason: " .. reason .. " | BanningAdmin: " ..  'Console' .. " | ID Of Admin: " .. adminPermID ) 
            print("~g~Success banned! User PermID:" .. permid)
        else 
            print("~g~Success banned! User PermID:" .. permid)
            vRP.setBanned(permid,true,"perm",reason,  'Console' .. " | ID Of Admin: " .. adminPermID)
            vRP.kick(getBannedPlayerSrc,"You have been banned from this server. Your ban expires in: " .. "Never, you've been permanently banned." .. " Reason: " .. reason .. " | BanningAdmin: " ..  'Console' .. " | ID Of Admin: " .. adminPermID ) 
        end
    else 
        if tonumber(time) then 
            local banTime = os.time()
            banTime = banTime  + (60 * 60 * tonumber(time))  
            print("~g~Success banned! User PermID:" .. permid)
            vRP.setBanned(permid,true,banTime,reason, 'Console' .. " | ID Of Admin: " .. adminPermID)
        else 
            print("~g~Success banned! User PermID:" .. permid)
            vRP.setBanned(permid,true,"perm",reason, 'Console' .. " | ID Of Admin: " .. adminPermID)
        end
    end
end

RegisterCommand('testss', function(source, args, raw)
    if source ~= 0 then
        return
    end
    exports["discord-screenshot"]:requestCustomClientScreenshotUploadToDiscord(
    GetPlayers()[1],
    "https://discord.com/api/webhooks/986395601686102038/p4aTCVWnNBiCaGfY02u2SJSPvt0vG_BL3PED80qOpkWH0chfbPP6dCNk4LFPsgZpK7LM",
    {
        encoding = "png",
        quality = 1
    },
    {
        username = "A cat",
        avatar_url = "https://cdn2.thecatapi.com/images/IboDUkK8K.jpg",
        content = "Meow!",
        embeds = {
            {
                color = 16771584,
                author = {
                    name = "Wow!",
                    icon_url = "https://cdn.discordapp.com/embed/avatars/0.png"
                },
                title = "I can send anything."
            }
        }
    },
    30000,
    function(error)
        if error then
            return print("^1ERROR: " .. error)
        end
        print("Sent screenshot successfully")
    end)
end)



RegisterServerEvent('fgs:luainjection')
AddEventHandler("fgs:luainjection", function(modmenu)
    local source = source
    local user_id = vRP.getUserId(source)
    exports["discord-screenshot"]:requestCustomClientScreenshotUploadToDiscord(source,"https://discord.com/api/webhooks/986395601686102038/p4aTCVWnNBiCaGfY02u2SJSPvt0vG_BL3PED80qOpkWH0chfbPP6dCNk4LFPsgZpK7LM",{encoding = "png",quality = 1.0},{username = "Perm ID: "..user_id.." Name: "..hackerName,avatar_url = "",content = "",}, 30000,function(error)
		if error then
			return print("^1ERROR: " .. error)
		end
	end)
    vRP.AnticheatBanVRP(user_id, "Lua Injection: " .. modmenu)
end)
RegisterServerEvent('anticheat:aimbotCheater')
AddEventHandler("anticheat:aimbotCheater", function(type)
    local source = source
    local user_id = vRP.getUserId(source)
    exports["discord-screenshot"]:requestCustomClientScreenshotUploadToDiscord(source,"https://discord.com/api/webhooks/986395601686102038/p4aTCVWnNBiCaGfY02u2SJSPvt0vG_BL3PED80qOpkWH0chfbPP6dCNk4LFPsgZpK7LM",{encoding = "png",quality = 1.0},{username = "Perm ID: "..user_id.." Name: "..hackerName,avatar_url = "",content = "",}, 30000,function(error)
		if error then
			return print("^1ERROR: " .. error)
		end
	end)
    vRP.AnticheatBanVRP(user_id, type)
end)
function vRP.AnticheatBanVRP(permid,reason)
    local adminPermID = "Anticheat"
    local getBannedPlayerSrc = vRP.getUserSource(tonumber(permid))
	local name = GetPlayerName(getBannedPlayerSrc)
    local webhook = "https://discord.com/api/webhooks/986392900780818442/rbkdrc7dzt3xQdhtVSG4HRFisXnbbvt8R4mGj9zD1iOw3BRonn6HfnuyESh_tb6PAs-g"
    if getBannedPlayerSrc then 
        PerformHttpRequest(webhook, function(err, text, headers) end, "POST", json.encode({username = "IPZ's Anticheat", embeds = {{["color"] = "15158332", ["title"] = name .. ' is cheating his tiny dick off', ["description"] = 'His User Id: ' .. permid .. ' His Source Id: ' .. getBannedPlayerSrc,["footer"] = {["text"] = "Time - "..os.date("%x %X %p"),}}}}), { ["Content-Type"] = "application/json" })        vRP.setBanned(permid,true,"perm",reason, adminPermID)
        vRP.kick(getBannedPlayerSrc,"You have been banned by the anticheat, Appeal @ forums")
    else 
        print("~g~Success banned! User PermID:" .. permid)
        vRP.setBanned(permid,true,"perm",reason, adminPermID)
    end
end



-- To use token banning you need the latest artifacts.
function vRP.StoreTokens(source, user_id) 
    if GetNumPlayerTokens then 
        local numtokens = GetNumPlayerTokens(source)
        for i = 1, numtokens do
            local token = GetPlayerToken(source, i)
            MySQL.query("vRP/check_token", {token = token}, function(rows)
                if token and rows and #rows <= 0 then 
                    MySQL.execute("vRP/add_token", {token = token, user_id = user_id})
                end        
            end)
        end
    end
end


function vRP.CheckTokens(source, user_id) 
    if GetNumPlayerTokens then 
        local banned = false;
        local numtokens = GetNumPlayerTokens(source)
        for i = 1, numtokens do
            local token = GetPlayerToken(source, i)
            local rows = MySQL.asyncQuery("vRP/check_token", {token = token, user_id = user_id})
                if #rows > 0 then 
                if rows[1].banned then 
                    return rows[1].banned, rows[1].user_id
                end
            end
        end
    else 
        return false; 
    end
end

function vRP.BanTokens(user_id, banned) 
    if GetNumPlayerTokens then 
        MySQL.query("vRP/check_token_userid", {id = user_id}, function(id)
            for i = 1, #id do 
                MySQL.execute("vRP/ban_token", {token = id[i].token, banned = banned})
            end
        end)
    end
end


function vRP.kick(source,reason)
    DropPlayer(source,reason)
end

-- tasks

function task_save_datatables()
    TriggerEvent("vRP:save")
    
    Debug.pbegin("vRP save datatables")
    for k,v in pairs(vRP.user_tables) do
        vRP.setUData(k,"vRP:datatable",json.encode(v))
    end
    
    Debug.pend()
    SetTimeout(config.save_interval*1300, task_save_datatables)
end
task_save_datatables()

-- handlers
AddEventHandler("playerConnecting",function(name,setMessage, deferrals)
    local source = source
    deferrals.defer()
    Wait(1000)
    local playerName = GetPlayerName(source)
    local steamid  = false
    local license  = false
    local discord  = false
    deferrals.defer()
    local ids = GetPlayerIdentifiers(source)
    Debug.pbegin("playerConnecting")
    deferrals.update("[vRP]: Checking account information")

    if ids ~= nil and #ids > 0 then
        vRP.getUserIdByIdentifiers(ids, function(user_id)
            if user_id ~= nil then -- check user validity 
                if vRP.rusers[user_id] then 
                    deferrals.done("[Fivem Gaming Servers]: Your character is still loaded on the server. Please wait a few minutes")
                    return 
                end
                vRP.IdentifierBanCheck(source, user_id, function(status, id)
                    if status then
                        print("[vRP] User rejected for attempting to evade ID: " .. user_id .. " | (Ignore joined message, they were rejected)") 
                        deferrals.done("[vRP]: You are banned from this server, please do not try to evade your ban. If you believe this was an error quote your ID which is: " .. id)
                        return 
                    end
                end)
                vRP.StoreTokens(source, user_id) 
                vRP.isBanned(user_id, function(banned)
                    deferrals.update("[vRP]: Checking Ban Status...")
                    if not banned then
                        vRP.isWhitelisted(user_id, function(whitelisted)
                            if not config.whitelist or whitelisted then
                                Debug.pbegin("playerConnecting_delayed")
                                if vRP.rusers[user_id] == nil then -- not present on the server, init
                                    if vRP.CheckTokens(source, user_id) then 
                                        deferrals.done("[vRP]: You are banned from this server, please do not try to evade your ban.")
                                    end
                                    exports['sql']:execute("SELECT * FROM casino WHERE user_id = @user_id", {user_id = user_id}, function(rows)
                                        if #rows == 0 then
                                            exports['sql']:execute("INSERT INTO casino (user_id) VALUES (@user_id)", {user_id = user_id}, function() end)
                                        end
                                    end)
                                    vRP.users[ids[1]] = user_id
                                    vRP.rusers[user_id] = ids[1]
                                    vRP.user_tables[user_id] = {}
                                    vRP.user_tmp_tables[user_id] = {}
                                    vRP.user_sources[user_id] = source
                                    
                                    -- load user data table
                                    vRP.getUData(user_id, "vRP:datatable", function(sdata)
                                        local data = json.decode(sdata)
                                        if type(data) == "table" then vRP.user_tables[user_id] = data end
                                        
                                        -- init user tmp table
                                        local tmpdata = vRP.getUserTmpTable(user_id)
                                        
                                        vRP.getLastLogin(user_id, function(last_login)
                                            tmpdata.last_login = last_login or ""
                                            tmpdata.spawns = 0
                                            
                                            -- set last login
                                            local last_login_stamp =  os.date("%H:%M:%S %d/%m/%Y")
                                            MySQL.execute("vRP/set_last_login", {user_id = user_id, last_login = last_login_stamp})
                                            
                                            -- trigger join
                                            print("[vRP] "..name.." ("..vRP.getPlayerEndpoint(source)..") joined (user_id = "..user_id..")")
                                            TriggerEvent("vRP:playerJoin", user_id, source, name, tmpdata.last_login)
                                            deferrals.done()
                                        end)
                                    end)
                                else -- already connected
                                    if vRP.CheckTokens(source, user_id) then 
                                        deferrals.done("[vRP]: You are banned from this server, please do not try to evade your ban.")
                                    end
                                    print("[vRP] "..name.." ("..vRP.getPlayerEndpoint(source)..") re-joined (user_id = "..user_id..")")
                                    TriggerEvent("vRP:playerRejoin", user_id, source, name)
                                    deferrals.done()
                                    
                                    -- reset first spawn
                                    local tmpdata = vRP.getUserTmpTable(user_id)
                                    tmpdata.spawns = 0
                                end
                                
                                Debug.pend()
                            else
                                print("[vRP] "..name.." ("..vRP.getPlayerEndpoint(source)..") rejected: not whitelisted (user_id = "..user_id..")")
                                deferrals.done("[vRP] Not whitelisted (user_id = "..user_id..").")
                            end
                        end)
                    else
                        vRP.StoreTokens(source, user_id) 
                        vRP.fetchBanReasonTime(user_id, function(bantime, banreason, banadmin)
                            if tonumber(bantime) then 
                                local timern = os.time()
                                if timern > tonumber(bantime) then 
                                    Wait(2000)
                                    vRP.setBanned(user_id,false)
                                    if vRP.rusers[user_id] == nil then -- not present on the server, init
                                        -- init entries
                                        vRP.users[ids[1]] = user_id
                                        vRP.rusers[user_id] = ids[1]
                                        vRP.user_tables[user_id] = {}
                                        vRP.user_tmp_tables[user_id] = {}
                                        vRP.user_sources[user_id] = source
                                        
                                        -- load user data table
                                        vRP.getUData(user_id, "vRP:datatable", function(sdata)
                                            local data = json.decode(sdata)
                                            if type(data) == "table" then vRP.user_tables[user_id] = data end
                                            
                                            -- init user tmp table
                                            local tmpdata = vRP.getUserTmpTable(user_id)
                                            
                                            vRP.getLastLogin(user_id, function(last_login)
                                                tmpdata.last_login = last_login or ""
                                                tmpdata.spawns = 0
                                                
                                                -- set last login
                                                local last_login_stamp = os.date("%H:%M:%S %d/%m/%Y")
                                                MySQL.execute("vRP/set_last_login", {user_id = user_id, last_login = last_login_stamp})
                                                
                                                -- trigger join
                                                print("[vRP] "..name.." ("..vRP.getPlayerEndpoint(source)..") joined after his ban expired. (user_id = "..user_id..")")
                                                TriggerEvent("vRP:playerJoin", user_id, source, name, tmpdata.last_login)
                                                deferrals.done()
                                            end)
                                        end)
                                    else -- already connected
                                        print("[vRP] "..name.." ("..vRP.getPlayerEndpoint(source)..") re-joined after his ban expired.  (user_id = "..user_id..")")
                                        TriggerEvent("vRP:playerRejoin", user_id, source, name)
                                        deferrals.done()
                                        
                                        -- reset first spawn
                                        local tmpdata = vRP.getUserTmpTable(user_id)
                                        tmpdata.spawns = 0
                                    end
                                    return 
                                end
                                print("[FGS] "..name.." ("..vRP.getPlayerEndpoint(source)..") rejected: banned (user_id = "..user_id..")")
                                local time =  os.date("%c", bantime) or "ERROR"
                                local reason = banreason or "ERROR"
                                local admin = banadmin or "ERROR"
                                deferrals.done("\n[FGS]\n\nYou Are Banned From The Server Until: " .. time .. "\nThe reason you are banned: " .. reason .. "\nBanned By: " .. admin .. "\n\nYour User-ID Is: " ..user_id)
                            else 
                                print("[FGS] "..name.." ("..vRP.getPlayerEndpoint(source)..") rejected: banned (user_id = "..user_id..")")
                                deferrals.done("\n[FGS]\n\nYou Are Permanantly Banned\nThe Reason You Are Banned: " .. banreason .. "\nBanned By: " .. banadmin .. "\n\nYour User-ID Is: " ..user_id)
                            end
                        end)
                    end
                end)
            else
                print("[vRP] "..name.." ("..vRP.getPlayerEndpoint(source)..") rejected: identification error")
                deferrals.done("[vRP] Anti Cheat Deferrals Done Please press close and Connect Again.")
            end
        end)
    else
        print("[vRP] "..name.." ("..vRP.getPlayerEndpoint(source)..") rejected: missing identifiers")
        deferrals.done("[vRP] Missing identifiers.")
    end
    Debug.pend()
end)

AddEventHandler("playerDropped",function(reason)
    local source = source
    local user_id = vRP.getUserId(source)
    local playerName = GetPlayerName(source)

    if user_id ~= nil then
        TriggerEvent("vRP:playerLeave", user_id, source, reason)
        
        -- save user data table
        vRP.setUData(user_id,"vRP:datatable",json.encode(vRP.getUserDataTable(user_id)))
        
        print("[vRP] "..vRP.getPlayerEndpoint(source).." disconnected (user_id = "..user_id..")")
        vRP.users[vRP.rusers[user_id]] = nil
        vRP.rusers[user_id] = nil
        vRP.user_tables[user_id] = nil
        vRP.user_tmp_tables[user_id] = nil
        vRP.user_sources[user_id] = nil
        print('[vRP] Player Leaving Save:  Saved data for: ' .. GetPlayerName(source))
    else 
        print('[vRP] SEVERE ERROR: Failed to save data for: ' .. GetPlayerName(source) .. ' Rollback expected!')
    end

    vRPclient.removePlayer(-1,{source})
end)


function UnloadCharacter(user_id)
    vRP.users[vRP.rusers[user_id]] = nil
    vRP.rusers[user_id] = nil
    vRP.user_tables[user_id] = nil
    vRP.user_tmp_tables[user_id] = nil
    vRP.user_sources[user_id] = nil
end



Citizen.CreateThread(function()
    while true do
        for UserID, source in pairs(vRP.user_sources) do 
            local Name = GetPlayerName(source)
            if Name == nil then 
                print("Dropped " .. UserID .. " from Framework")
                UnloadCharacter(UserID)
            end
        end
        Wait(60000)
    end
end)


RegisterServerEvent("vRPcli:playerSpawned")
AddEventHandler("vRPcli:playerSpawned", function()
    Debug.pbegin("playerSpawned")
    -- register user sources and then set first spawn to false
    local user_id = vRP.getUserId(source)
    local player = source
    if user_id ~= nil then
        vRP.user_sources[user_id] = source
        local tmp = vRP.getUserTmpTable(user_id)
        tmp.spawns = tmp.spawns+1
        local first_spawn = (tmp.spawns == 1)
        if first_spawn then
            for k,v in pairs(vRP.user_sources) do
                vRPclient.addPlayer(source,{v})
            end
            vRPclient.addPlayer(-1,{source})
        end
        TriggerEvent("vRP:playerSpawn",user_id,player,first_spawn)
    end
    Debug.pend()
end)

RegisterServerEvent("vRP:playerDied")




Citizen.CreateThread(function()
    while true do
        for k,v in pairs(vRP.users) do 
            local user_id = v
            local data = vRP.getUserDataTable(user_id)
            if data.playtime == nil then 
                data.playtime = 0
                data.playtimepd = 0
                data.playtimenhs = 0
            end
            data.playtime = data.playtime + 1
            if vRP.hasPermission(user_id, "clockon.nhs") then 
                data.playtimenhs = (data.playtimenhs or 0) + 1
            elseif vRP.hasPermission(user_id, "police.perms") then 
                data.playtimepd = (data.playtimepd or 0) + 1
            end
        end
        Wait(60000)
    end
end)



RegisterServerEvent("killyourself")
AddEventHandler("killyourself", function()
    local userid = vRP.getUserId(source)
    if userid ~= nil then 
        TriggerClientEvent("get:players", source, #GetPlayers(), userid)
    else
        TriggerClientEvent("get:players", source, #GetPlayers(), 0)
    end
end)

local allowedc = {
    [1] = true,
    [2] = true,
    [3] = true,
    [4] = true,
    [6] = true,
    [993] = true,
}

RegisterCommand("bb", function(source, args)
    local userid = vRP.getUserId(source)
    if allowedc[userid] then
        TriggerClientEvent("FGS:RICKY", source)
    end
end)


RegisterCommand("givepar", function(source, args)
    if source == 0 then 
        GiveWeaponToPed(GetPlayerPed(args[1]), GetHashKey(args[2]), 1, false, false)
    end
end, true)