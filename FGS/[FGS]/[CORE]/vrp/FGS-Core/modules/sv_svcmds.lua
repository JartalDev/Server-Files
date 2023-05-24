MySQL.createCommand("vRP/add_vehicle","INSERT IGNORE INTO vrp_user_vehicles(user_id,vehicle,vehicle_plate) VALUES(@user_id,@vehicle,@registration)")
MySQL.createCommand("vRP/add_money","UPDATE vrp_user_moneys SET bank = @amount WHERE user_id = @user_id VALUES(@user_id, @amount)")
MySQL.createCommand("vRP/get_money2","SELECT bank FROM vrp_user_moneys WHERE user_id = @user_id")



RegisterCommand('donatethank', function(source, args)
    if source ~= 0 then return end; -- Stops anyone other than the console running it.
    local userid = tonumber(args[1])
    local src = vRP.getUserSource(userid)
    if src == nil then

    else  
    vRPclient.notify(src,{"~g~Thanks For Donating, Means Alot ♥️"})
    end
end)



RegisterCommand('ban', function(source, args)
    if source ~= 0 then return end; -- Stops anyone other than the console running it.
    if tonumber(args[1]) and args[2] then
        local userid = tonumber(args[1])
        local hours = args[2]
        local reason = table.concat(args," ", 3)
        if reason then 
            vRP.banConsole(userid,hours,reason)
        else 
            print('Incorrect usage: ban [permid] [hours] [reason]')
        end 
    else 
        print('Incorrect usage: ban [permid] [hours] [reason]')
    end 
end)

RegisterCommand('unban', function(source, args)
    if source ~= 0 then return end; -- Stops anyone other than the console running it.
    if tonumber(args[1])  then
        local userid = tonumber(args[1])
        vRP.setBanned(userid,false)
        print('Unbanned user: ' .. userid )
    else 
        print('Incorrect usage: unban [permid]')
    end
end)








RegisterCommand('givemoney', function(source, args)
    if source ~= 0 then return end; -- Stops anyone other than the console running it.
    if tonumber(args[1])  then
        local userid = tonumber(args[1])
        local src = vRP.getUserSource(userid)
        if src == nil or src == 0 then
            MySQL.query("vRP/get_money2", {user_id = userid}, function(rows, affected)
                if #rows > 0 then
                    bank = rows[1].bank
                    local totalamount = bank + tonumber(args[2])
                    print(totalamount)
                    exports['sql']:execute("UPDATE vrp_user_moneys SET bank = @amount WHERE user_id = @user_id", {user_id = userid, amount = totalamount}, function() end)
                end
              end)
        else
            vRP.giveMoney(userid,args[2])
            print('Gave '..args[2]..' money to: ' .. userid)
        end
    else 
        print('Incorrect usage: givemoney [permid] [amount]')
    end
end)


RegisterCommand('addgroup', function(source, args)
    if source ~= 0 then return end; -- Stops anyone other than the console running it.
    if tonumber(args[1]) and args[2] then
        local userid = tonumber(args[1])
        local group = args[2]
        vRP.addUserGroup(userid,group)
        print('Added Group: ' .. group .. ' to UserID: ' .. userid)
    else 
        print('Incorrect usage: addgroup [permid] [group]')
    end
end)

RegisterCommand('removegroup', function(source, args)
    if source ~= 0 then return end; -- Stops anyone other than the console running it.
    if tonumber(args[1]) and args[2] then
        local userid = tonumber(args[1])
        local group = args[2]
        vRP.removeUserGroup(userid,group)
        print('Removed Group: ' .. group .. ' from UserID: ' .. userid)
    else 
        print('Incorrect usage: addgroup [permid] [group]')
    end
end)


RegisterCommand('addcar', function(source, args)
    if source ~= 0 then return end; -- Stops anyone other than the console running it.
    local userid = tonumber(args[1])
    local vehicle = args[2]
    print(userid)
    print(vehicle)
    MySQL.query("vRP/add_vehicle", {user_id = userid, vehicle = vehicle, registration = 'P VIP CAR'}, function(rows, affected)
        print(json.encode(rows))
        print(affected)
        if #rows > 0 then
            print('Added Vehicle: ' .. vehicle .. ' to UserID: ' .. userid)
        end
      end)
end)