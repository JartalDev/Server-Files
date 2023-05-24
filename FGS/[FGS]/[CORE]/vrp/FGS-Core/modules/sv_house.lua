local cfg = module("FGS-Core/cfg/cfg_houses")
local lang = vRP.lang
local components = {}
local playerhouses = {}

MySQL.createCommand("vRP/get_address", "SELECT home FROM vrp_user_homes WHERE user_id = @user_id")
MySQL.createCommand("vRP/get_home_owner", "SELECT user_id FROM vrp_user_homes WHERE home = @home")
MySQL.createCommand("vRP/rm_address", "DELETE FROM vrp_user_homes WHERE user_id = @user_id")
MySQL.createCommand("vRP/delete_address", "DELETE FROM vrp_user_homes WHERE home = @home")
MySQL.createCommand("vRP/set_address","REPLACE INTO vrp_user_homes(user_id,home) VALUES(@user_id,@home)")
MySQL.createCommand("vRP/delete_houseinv","DELETE FROM vrp_srv_data WHERE dkey = @dkey")

AddEventHandler("vRP:playerSpawn",function(user_id, source, first_spawn)
    local homes = cfg.homes

    TriggerClientEvent("RequestHomeData", source, homes)
end)


RegisterServerEvent("FGS:PurchaseHouse")
AddEventHandler("FGS:PurchaseHouse", function(home_name)
    local player = source
    local home = cfg.homes[home_name]
    local user_id = vRP.getUserId(player)

    vRP.request(player,"House price is £" .. home.buy_price, 30, function(player, ok)
        if ok then
            exports['sql']:execute("SELECT * FROM vrp_user_homes WHERE home = @home", {home = home_name}, function(rows)
                if #rows > 0 then
                    vRPclient.notify(player,{"~r~Place is full"})
                else
                    if vRP.tryPayment(user_id, home.buy_price) then
                        -- bought, set address
                        exports['sql']:execute("INSERT INTO vrp_user_homes (`user_id`, `home`) VALUES (@user_id, @home)", {user_id = user_id, home = home_name})
        
                        vRPclient.notify(player, {lang.home.buy.bought()})
                    else
                        vRPclient.notify(player, {lang.money.not_enough()})
                    end
                end
            end)

        else
            vRPclient.notify(player,{"~r~You have canceled the purchase."})
        end
    end)
end)


RegisterServerEvent("FGS:SellHouseToPlayer")
AddEventHandler("FGS:SellHouseToPlayer", function(home_name)
    local player = source
    local home = cfg.homes[home_name]

    local user_id = vRP.getUserId(player)

    if home.viphouse == "yes" then 
        vRPclient.notify(source,{"~r~Sorry but you cant sell this house please contact a developer"})
        return 
    end

    vRP.prompt(player,"Price £: ","",function(player, amount)
        vRP.request(player,"Are you sure that you want to sell your house for £" .. amount .."?", 30, function(player, ok)
            if ok then
                vRPclient.getNearestPlayer(player, {5}, function(nplayer)
                    local nuser_id = vRP.getUserId(nplayer)
                    if nuser_id ~= nil then 
                        vRP.request(nplayer,"Do you want to buy " .. GetPlayerName(player) .. " house for £" .. amount, 30, function(player2, ok)
                            if ok then

                                MySQL.query("vRP/get_address", {user_id = user_id}, function(address, affected)
                                    for k,v in pairs(address) do 
                    
                                        if address ~= nil and v.home == home_name then 
                                            MySQL.execute("vRP/delete_address", {home = home_name})
                                            vRP.setSData("chest:".."u"..home.slot.."home", json.encode({}))
                                            if vRP.tryPayment(user_id, home.buy_price) then
                                                vRP.giveMoney(user_id, amount)
                                                TriggerClientEvent("FGS:HouseInfo", player, nil,nil)
                                                TriggerClientEvent("FGS:HouseInfo", nplayer, nil,nil)
                                                Wait(1000)
                                                exports['sql']:execute("INSERT INTO vrp_user_homes (`user_id`, `home`) VALUES (@user_id, @home)", {user_id = nuser_id, home = home_name})
                                                vRPclient.notify(player, {lang.home.sell.sold()})
                                                vRPclient.notify(nplayer, {lang.home.buy.bought()})
                                            else
                                                vRPclient.notify(player, {lang.money.not_enough()})
                                            end
                                            return 
                                        end
                                    end
                                    vRPclient.notify(player, {lang.home.sell.no_home()})
                                end)

                            else
                                vRPclient.notify(player,{lang.common.request_refused()})
                            end
                        end)
                    else
                        vRPclient.notify(player,{lang.common.no_player_near()})
                    end
                end)

            end
        end)
    end)
end)

RegisterServerEvent("FGS:SellHouse")
AddEventHandler("FGS:SellHouse", function(home_name)
    local player = source
    local home = cfg.homes[home_name]

    local user_id = vRP.getUserId(player)

    if home.viphouse == "yes" then 
        vRPclient.notify(source,{"~r~Sorry but you cant sell this house please contact a developer"})
        return 
    end

    vRP.request(player,"Are you sure that you want to sell your house?", 30, function(player, ok)
        if ok then
            MySQL.query("vRP/get_address", {user_id = user_id}, function(address, affected)
                for k,v in pairs(address) do 

                    if address ~= nil and v.home == home_name then 
                        MySQL.execute("vRP/delete_address", {home = home_name})
                        vRP.setSData("chest:".."u"..home.slot.."home", json.encode({}))

                        vRP.giveMoney(user_id, home.sell_price)
                        vRPclient.notify(player, {lang.home.sell.sold()})
                        TriggerClientEvent("FGS:HouseInfo", player, nil,nil)
                        return 
                    end
                end
                vRPclient.notify(player, {lang.home.sell.no_home()})
            end)
        end
    end)
end)



RegisterServerEvent("FGS:EnterHouse")
AddEventHandler("FGS:EnterHouse", function(home_name)
    local player = source
    local home = cfg.homes[home_name]
    local user_id = vRP.getUserId(player)
    local number = 1

    vRP.getUserByAddress(home_name, function(huser_id)
        if huser_id ~= nil then
            if huser_id == user_id then -- identify owner (direct home access)
                vRP.accessHome2(user_id, home_name)
            else -- try to access home by asking owner
                local hplayer = vRP.getUserSource(huser_id)
                if hplayer ~= nil then
                    vRP.prompt(player, lang.home.intercom.prompt_who(), "", function(player, who)
                        vRPclient.notify(player, {lang.home.intercom.asked()})
                        -- request owner to open the door
                        vRP.request(hplayer, lang.home.intercom.request({who}), 30, function(hplayer, ok)
                            if ok then
                                vRP.accessHome2(user_id, home_name)
                            else
                                vRPclient.notify(player, {lang.home.intercom.refused()})
                            end
                        end)
                    end)
                else
                    vRPclient.notify(player, {lang.home.intercom.refused()})
                end
            end
        else
            vRPclient.notify(player, {lang.common.not_found() .. " (Do you own the house?)"})
        end
    end)
end)




RegisterServerEvent("FGS:HouseInfo")
AddEventHandler("FGS:HouseInfo", function(home_name)
    local source = source
    local status = "offline"
    local user_id = 0
    if home_name ~= nil then 
        exports['sql']:execute("SELECT * FROM vrp_user_homes WHERE home = @home", {home = home_name}, function(rows)
            if #rows > 0 then
                for k,v in pairs(rows) do
                    local ownerssource = vRP.getUserSource(v.user_id)
                    user_id = v.user_id
                    if ownerssource ~= nil then 
                        status = "online"
                    end
                end
                TriggerClientEvent('FGS:HouseInfo', source, user_id, status)
            end
        end)
    end
    return nil
end)





function vRP.defHomeComponent(name, oncreate, ondestroy)
    components[name] = {oncreate, ondestroy}
end


RegisterServerEvent("FGS:LeaveHouse")
AddEventHandler("FGS:LeaveHouse", function() -- called when a player leave a slot
    local sid = 1
    local player = source
    local user_id = vRP.getUserId(player)
    local tmp = vRP.getUserTmpTable(user_id)

    local stype = tmp.home_stype
    local home_name = playerhouses[player][1]

    local home = cfg.homes[home_name]

    -- record if inside a home slot
    if tmp then
        tmp.home_stype = nil
        tmp.home_sid = nil
    end

    -- teleport to home entry point (outside)
    vRPclient.teleport(player, home.entry_point) -- already an array of params (x,y,z)
    -- destroy loaded components and special entry component
    for k, v in pairs(cfg.slot_types[stype][1]) do
        local name, x, y, z = table.unpack(v)

        if name == "entry" then

        else
            local component = components[v[1]]
            if component then
                -- ondestroy(owner_id, slot_type, slot_id, cid, config, x, y, z, player)
                component[2](user_id, stype, sid, k, v._config or {}, x, y, z, player)
            end
        end
    end
end)

local userslot = {}
for k, v in pairs(cfg.slot_types) do
    userslot[k] = {}
    for l, w in pairs(v) do
        userslot[k] = {used = false}
    end
end

local function allocateSlot(stype)
    local slots = cfg.slot_types[stype]
    if slots then
        local _uslots = userslot[stype]
        -- search the first unused slot
        for k, v in pairs(slots) do
            if _uslots[k] and not _uslots[k].used then
                _uslots[k].used = true -- set as used
                return k -- return slot id
            end
        end
    end

    return nil
end


function vRP.accessHome2(user_id, home)

    local _home = cfg.homes[home]
    local player = vRP.getUserSource(user_id)

    vRP.getUserByAddress(home, function(owner_id)
        if _home ~= nil and player ~= nil then
                stype = _home.slot
            local slot = userslot[stype]
            if slot ~= nil then 
                slot.home_name = home
                slot.owner_id = owner_id
                slot.players = {} -- map user_id => player
    
                enter_slot2(user_id, player, stype)
            end
        end
    end)
end


-- cbreturn user address (home and number) or nil
function vRP.getUserAddress(user_id, cbr)
    local task = Task(cbr)

    MySQL.query("vRP/get_address", {user_id = user_id}, function(rows, affected)
        task({rows[1]})
    end)
end

function vRP.getUserByAddress(home, cbr)
    local task = Task(cbr)

    MySQL.query("vRP/get_home_owner",{home = home},function(rows, affected)
        if #rows > 0 then
            task({rows[1].user_id})
        else
            task()
        end
    end)
end



function enter_slot2(user_id, player, stype) -- called when a player enter a slot
    local slot = userslot[stype]


    -- record inside a home slot
    local tmp = vRP.getUserTmpTable(user_id)
    if tmp then
        tmp.home_stype = stype
        tmp.home_sid = 1
    end

    -- count
    slot.players[user_id] = player


    vRP.getUserAddress(user_id, function(address)
        local coords, coords2 = {}, {} 
        -- check if owner
        -- build components and special entry component
        for k, v in pairs(cfg.slot_types[stype][1]) do
            local name, x, y, z = table.unpack(v)
            if name == "entry" then
                playerhouses[player] = { slot.home_name }
                -- teleport to the slot entry point
                vRPclient.teleport(player, {x, y, z}) -- already an array of params (x,y,z)
                coords = {x, y, z}
            else -- load regular component
                local component = components[v[1]]
                if component then
                    -- oncreate(owner_id, slot_type, slot_id, cid, config, x, y, z, player)
                    component[1](slot.owner_id, stype, 1, k, v._config or {}, x, y, z, player)
                end
                if name == "chest" then 
                    coords2 = {x, y, z}
                end
            end
        end
        Wait(500) -- do again

        TriggerClientEvent("FGS:HouseExit", player, coords, coords2)
    end)
end

--Restart nigga



-- build homes entry points
local function build_client_homes(source)
    local user_id = vRP.getUserId(source)
    if user_id ~= nil then
        for k, v in pairs(cfg.homes) do
            local x, y, z = table.unpack(v.entry_point)
            local houseName = ""

            local j = string.find(k, " ", 6)

            if j ~= nil then
                houseName = string.sub(k, 1, j)
            else
                houseName = k
            end

            vRPclient.addBlip(source, {x, y, z, v.blipid, v.blipcolor, "House"})
            vRPclient.addMarker(source, {x, y, z - 1, 0.7, 0.7, 0.5, 0, 255, 125, 125, 150})
        end
    end
end



local function leave_slot(user_id, player, stype, sid) -- called when a player leave a slot

    local slot = uslots[stype][sid]
    local home = cfg.homes[slot.home_name]

    -- record if inside a home slot
    local tmp = vRP.getUserTmpTable(user_id)
    if tmp then
        tmp.home_stype = nil
        tmp.home_sid = nil
    end

    -- teleport to home entry point (outside)
    vRPclient.teleport(player, home.entry_point) -- already an array of params (x,y,z)

    -- uncount player
    slot.players[user_id] = nil

    -- destroy loaded components and special entry component
    for k, v in pairs(cfg.slot_types[stype][sid]) do
        local name, x, y, z = table.unpack(v)

        if name == "entry" then
            -- remove marker/area
            local nid = "vRP:home:slot" .. stype .. sid
            vRPclient.removeNamedMarker(player, {nid})
            vRP.removeArea(player, nid)
        else
            local component = components[v[1]]
            if component then
                -- ondestroy(owner_id, slot_type, slot_id, cid, config, x, y, z, player)
                component[2](slot.owner_id, stype, sid, k, v._config or {}, x, y, z, player)
            end
        end
    end

    if is_empty(slot.players) then -- free the slot
        freeSlot(stype, sid)
    end
end

AddEventHandler("vRP:playerSpawn",function(user_id, source, first_spawn)
    if first_spawn then -- first spawn, build homes
        build_client_homes(source)
    else -- death, leave home if inside one
        -- leave slot if inside one
        local tmp = vRP.getUserTmpTable(user_id)
        if tmp and tmp.home_stype then
            leave_slot(user_id, source, tmp.home_stype, tmp.home_sid)
        end
    end
end)

AddEventHandler("vRP:playerLeave",function(user_id, player)
    -- leave slot if inside one
    local tmp = vRP.getUserTmpTable(user_id)
    if tmp and tmp.home_stype then
        leave_slot(user_id, player, tmp.home_stype, tmp.home_sid)
    end
end)


RegisterNetEvent("FGS:grabid", function()
    local id = vRP.getUserId(source)
    TriggerClientEvent("FGS:gettingid", source, id)
end)

-- can you do renting then you mugggggggg u wabted tgat wutg ut