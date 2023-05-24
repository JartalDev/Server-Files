local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
local htmlEntities = module("lib/htmlEntities")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "gcphone")

math.randomseed(os.time()) 

draCB.RegisterServerCallback('gcPhone:hasPhone', function(source, cb, data)
    local user_id = vRP.getUserId({source})
    if vRP.getInventoryItemAmount({user_id,"aphone"}) > 0 then
        cb(true)
    else
        cb(false)
    end
end)

--- Pour les numero du style XXX-XXXX
-- function getPhoneRandomNumber()
--     local numBase0 = math.random(100,999)
--     local numBase1 = math.random(0,9999)
--     local num = string.format("%03d-%04d", numBase0, numBase1 )
-- 	return num
-- end

--- Exemple pour les numero du style 06XXXXXXXX
function getPhoneRandomNumber()
    return '07' .. math.random(1000000,9999999)
end


--====================================================================================
--  Utils
--====================================================================================
function getSourceFromIdentifier(identifier, cb)
    return vRP.getUserSource({identifier})
end

local services = module("vrp", "cfg/phone")


function getNumberPhone(user_id)
    local toofuckinglong = nil 
    exports['sql']:execute("SELECT * FROM vrp_user_identities WHERE user_id = @uid", {uid = user_id}, function(rows)
        toofuckinglong = rows

    end)
    Wait(500)
    if toofuckinglong[1] ~= nil then
        return toofuckinglong[1].phone
    end
    return nil
end

local services = module("vrp", "cfg/phone")

local PhoneNumbers = {}

for k,v in pairs(services.services) do
	PhoneNumbers[k] = v.alert_permission
end

RegisterServerEvent('District:CallNHS')
AddEventHandler('District:CallNHS', function()
    local coords = GetEntityCoords(GetPlayerPed(source))
	startCall(source, "Ambulance", "Im dying", coords)
end)


RegisterServerEvent('vrp_addons_gcphone:startCall')
AddEventHandler('vrp_addons_gcphone:startCall', function(number, message, coords)
    startCall(source, number, message, coords)
end)


--


function startCall(src, number, message, coords)
    local num = getNumberPhone(src)
    print(PhoneNumbers[number])
    local serviceGroup = vRP.getUsersByPermission({PhoneNumbers[number]})
	if num ~= nil then
        print(number, num, message, coords.x, coords.y, coords.z, serviceGroup)
		sendServiceSMS(number, {sender = num, message = message, coords = {x = coords.x, y=coords.y, z=coords.z}}, serviceGroup)
		TriggerEvent('gcPhone:_internalAddMessage', number, num, message, 1, function(smsMess)
			TriggerClientEvent("gcPhone:receiveMessage", src, smsMess)
		end)
	end
end

function sendServiceSMS(number, alert, ids)
	local mess = alert.sender..": "..alert.message
	if alert.coords ~= nil then
		mess = mess .. ' - ' .. alert.coords.x .. ', ' .. alert.coords.y 
	end
	for l,w in pairs(ids) do
		local player = vRP.getUserSource({w})
        local num = getNumberPhone(w)
		if num ~= nil then
			TriggerEvent('gcPhone:_internalAddMessage', number, num, mess, 0, function(smsMess)
				TriggerClientEvent("gcPhone:receiveMessage", player, smsMess)
			end)
		end
	end
end



function getIdentifierByPhoneNumber(phone_number) 
    local idksomething = nil 
    exports['sql']:execute("SELECT vrp_user_identities.user_id FROM vrp_user_identities WHERE vrp_user_identities.phone = @phone_number", {['@phone_number'] = phone_number}, function(rows)
        idksomething = rows
    end)

    Wait(500)
    if idksomething[1] ~= nil then
        return idksomething[1].user_id
    end
    return nil
end


function getPlayerID(source)
    local player = vRP.getUserId({source})
    return player
end
function getIdentifiant(id)
    for _, v in ipairs(id) do
        return v
    end
end


function getOrGeneratePhoneNumber(sourcePlayer, identifier, cb)
    local sourcePlayer = sourcePlayer
    local identifier = identifier
    local myPhoneNumber = getNumberPhone(identifier)
    if myPhoneNumber == '0' or myPhoneNumber == nil then
        repeat
            myPhoneNumber = getPhoneRandomNumber()
            local id = getIdentifierByPhoneNumber(myPhoneNumber)
        until id == nil
        exports['sql']:execute("UPDATE vrp_user_identities SET phone = @myPhoneNumber WHERE user_id = @identifier", { 
            ['@myPhoneNumber'] = myPhoneNumber,
            ['@identifier'] = identifier
        }, function ()
            cb(myPhoneNumber)
        end)
    else
        cb(myPhoneNumber)
    end
end
--====================================================================================
--  Contacts
--====================================================================================
function getContacts(identifier)
    local result = exports['sql']:executeSync("SELECT * FROM phone_users_contacts WHERE phone_users_contacts.identifier = @identifier", {
        ['@identifier'] = identifier
    })
    
    Wait(10)
    return result
end

function addContact(source, identifier, number, display)
    local sourcePlayer = tonumber(source)
    exports['sql']:execute("INSERT INTO phone_users_contacts (`identifier`, `number`,`display`) VALUES(@identifier, @number, @display)", {
        ['@identifier'] = identifier,
        ['@number'] = number,
        ['@display'] = display,
    },function()
        notifyContactChange(sourcePlayer, identifier)
    end)
end
function updateContact(source, identifier, id, number, display)
    local sourcePlayer = tonumber(source)
    exports['sql']:execute("UPDATE phone_users_contacts SET number = @number, display = @display WHERE id = @id", { 
        ['@number'] = number,
        ['@display'] = display,
        ['@id'] = id,
    },function()
        notifyContactChange(sourcePlayer, identifier)
    end)
end
function deleteContact(source, identifier, id)
    local sourcePlayer = tonumber(source)
    exports['sql']:execute("DELETE FROM phone_users_contacts WHERE `identifier` = @identifier AND `id` = @id", {
        ['@identifier'] = identifier,
        ['@id'] = id,
    })
    notifyContactChange(sourcePlayer, identifier)
end
function deleteAllContact(identifier)
    exports['sql']:execute("DELETE FROM phone_users_contacts WHERE `identifier` = @identifier", {
        ['@identifier'] = identifier
    })
end
function notifyContactChange(source, identifier)
    local sourcePlayer = tonumber(source)
    local identifier = identifier
    if sourcePlayer ~= nil then 
        TriggerClientEvent("gcPhone:contactList", sourcePlayer, getContacts(identifier))
    end
end

RegisterServerEvent('gcPhone:addContact')
AddEventHandler('gcPhone:addContact', function(display, phoneNumber)
    local sourcePlayer = tonumber(source)
    local identifier = getPlayerID(source)
    addContact(sourcePlayer, identifier, phoneNumber, display)
end)

RegisterServerEvent('gcPhone:updateContact')
AddEventHandler('gcPhone:updateContact', function(id, display, phoneNumber)
    local sourcePlayer = tonumber(source)
    local identifier = getPlayerID(source)
    updateContact(sourcePlayer, identifier, id, phoneNumber, display)
end)

RegisterServerEvent('gcPhone:deleteContact')
AddEventHandler('gcPhone:deleteContact', function(id)
    local sourcePlayer = tonumber(source)
    local identifier = getPlayerID(source)
    deleteContact(sourcePlayer, identifier, id)
end)

--====================================================================================
--  Messages
--====================================================================================
function getMessages(identifier)
    local result = exports['sql']:executeSync("SELECT phone_messages.* FROM phone_messages LEFT JOIN vrp_user_identities ON vrp_user_identities.user_id = @identifier WHERE phone_messages.receiver = vrp_user_identities.phone", {
         ['@identifier'] = identifier
    })

    Wait(50)

    return result
    --return MySQLQueryTimeStamp("SELECT phone_messages.* FROM phone_messages LEFT JOIN users ON users.identifier = @identifier WHERE phone_messages.receiver = users.phone_number", {['@identifier'] = identifier})
end

RegisterServerEvent('gcPhone:_internalAddMessage')
AddEventHandler('gcPhone:_internalAddMessage', function(transmitter, receiver, message, owner, cb)
    cb(_internalAddMessage(transmitter, receiver, message, owner))
end)

function _internalAddMessage(transmitter, receiver, message, owner)
    exports['sql']:execute("INSERT INTO phone_messages (`transmitter`, `receiver`,`message`, `isRead`,`owner`) VALUES(@transmitter, @receiver, @message, @isRead, @owner)", {
        ['@transmitter'] = transmitter,
        ['@receiver'] = receiver,
        ['@message'] = message,
        ['@isRead'] = owner,
        ['@owner'] = owner
    })
    local data = {message = message, time = tonumber(os.time().."000.0"), receiver = receiver, transmitter = transmitter, owner = owner, isRead = owner}
    return data
end

function addMessage(source, identifier, phone_number, message)
    local sourcePlayer = tonumber(source)
    local otherIdentifier = getIdentifierByPhoneNumber(phone_number)
    local myPhone = getNumberPhone(identifier)
    if otherIdentifier ~= nil and vRP.getUserSource({otherIdentifier}) ~= nil then 
        local tomess = _internalAddMessage(myPhone, phone_number, message, 0)
        TriggerClientEvent("gcPhone:receiveMessage", tonumber(vRP.getUserSource({otherIdentifier})), tomess)
    end
    local memess = _internalAddMessage(phone_number, myPhone, message, 1)
    TriggerClientEvent("gcPhone:receiveMessage", sourcePlayer, memess)
end

function setReadMessageNumber(identifier, num)
    local mePhoneNumber = getNumberPhone(identifier)
    exports['sql']:execute("UPDATE phone_messages SET phone_messages.isRead = 1 WHERE phone_messages.receiver = @receiver AND phone_messages.transmitter = @transmitter", { 
        ['@receiver'] = mePhoneNumber,
        ['@transmitter'] = num
    })
end


function deleteMessage(msgId)
    exports['sql']:execute("DELETE FROM phone_messages WHERE `id` = @id", {
        ['@id'] = msgId
    })
end


function deleteAllMessageFromPhoneNumber(source, identifier, phone_number)
    local source = source
    local identifier = identifier
    local mePhoneNumber = getNumberPhone(identifier)
    exports['sql']:execute("DELETE FROM phone_messages WHERE `receiver` = @mePhoneNumber and `transmitter` = @phone_number", {['@mePhoneNumber'] = mePhoneNumber,['@phone_number'] = phone_number})
end

function deleteAllMessage(identifier)
    local mePhoneNumber = getNumberPhone(identifier)
    exports['sql']:execute("DELETE FROM phone_messages WHERE `receiver` = @mePhoneNumber", {
        ['@mePhoneNumber'] = mePhoneNumber
    })
end

RegisterServerEvent('gcPhone:sendMessage')
AddEventHandler('gcPhone:sendMessage', function(phoneNumber, message)
    local sourcePlayer = tonumber(source)
    local identifier = getPlayerID(source)
    addMessage(sourcePlayer, identifier, phoneNumber, message)
end)

RegisterServerEvent('gcPhone:deleteMessage')
AddEventHandler('gcPhone:deleteMessage', function(msgId)
    deleteMessage(msgId)
end)

RegisterServerEvent('gcPhone:deleteMessageNumber')
AddEventHandler('gcPhone:deleteMessageNumber', function(number)
    local sourcePlayer = tonumber(source)
    local identifier = getPlayerID(source)
    deleteAllMessageFromPhoneNumber(sourcePlayer,identifier, number)
    -- TriggerClientEvent("gcphone:allMessage", sourcePlayer, getMessages(identifier))
end)

RegisterServerEvent('gcPhone:deleteAllMessage')
AddEventHandler('gcPhone:deleteAllMessage', function()
    local sourcePlayer = tonumber(source)
    local identifier = getPlayerID(source)
    deleteAllMessage(identifier)
end)

RegisterServerEvent('gcPhone:setReadMessageNumber')
AddEventHandler('gcPhone:setReadMessageNumber', function(num)
    local identifier = getPlayerID(source)
    setReadMessageNumber(identifier, num)
end)

RegisterServerEvent('gcPhone:deleteALL')
AddEventHandler('gcPhone:deleteALL', function()
    local sourcePlayer = tonumber(source)
    local identifier = getPlayerID(source)
    deleteAllMessage(identifier)
    deleteAllContact(identifier)
    appelsDeleteAllHistorique(identifier)
    TriggerClientEvent("gcPhone:contactList", sourcePlayer, {})
    TriggerClientEvent("gcPhone:allMessage", sourcePlayer, {})
    TriggerClientEvent("appelsDeleteAllHistorique", sourcePlayer, {})
end)

AddEventHandler('gcPhone:deleteALLvRPIdentity', function(src,user_id,num)
    deleteAllMessage(user_id)
    deleteAllContact(user_id)
    appelsDeleteAllHistorique(user_id)
    TriggerClientEvent("gcPhone:contactList", src, {})
    TriggerClientEvent("gcPhone:allMessage", src, {})
    TriggerClientEvent("appelsDeleteAllHistorique", src, {})
    TriggerClientEvent("gcPhone:myPhoneNumber", src, num) -- update phonenumber
end)

--====================================================================================
--  Gestion des appels
--====================================================================================
local AppelsEnCours = {}
local PhoneFixeInfo = {}
local lastIndexCall = 10

function getHistoriqueCall (num)
    local result = exports['sql']:executeSync("SELECT * FROM phone_calls WHERE phone_calls.owner = @num ORDER BY time DESC LIMIT 120", {
        ['@num'] = num
    })

    Wait(50)

    return result
end

function sendHistoriqueCall (src, num) 
    local histo = getHistoriqueCall(num)
    TriggerClientEvent('gcPhone:historiqueCall', src, histo)
end

function saveAppels (appelInfo)
    if appelInfo.extraData == nil or appelInfo.extraData.useNumber == nil then
        exports['sql']:execute("INSERT INTO phone_calls (`owner`, `num`,`incoming`, `accepts`) VALUES(@owner, @num, @incoming, @accepts)", {
            ['@owner'] = appelInfo.transmitter_num,
            ['@num'] = appelInfo.receiver_num,
            ['@incoming'] = 1,
            ['@accepts'] = appelInfo.is_accepts
        }, function()
            notifyNewAppelsHisto(appelInfo.transmitter_src, appelInfo.transmitter_num)
        end)
    end
    if appelInfo.is_valid == true then
        local num = appelInfo.transmitter_num
        if appelInfo.hidden == true then
            mun = "###-####"
        end
        exports['sql']:execute("INSERT INTO phone_calls (`owner`, `num`,`incoming`, `accepts`) VALUES(@owner, @num, @incoming, @accepts)", {
            ['@owner'] = appelInfo.receiver_num,
            ['@num'] = num,
            ['@incoming'] = 0,
            ['@accepts'] = appelInfo.is_accepts
        }, function()
            if appelInfo.receiver_src ~= nil then
                notifyNewAppelsHisto(appelInfo.receiver_src, appelInfo.receiver_num)
            end
        end)
    end
end

function notifyNewAppelsHisto (src, num) 
    sendHistoriqueCall(src, num)
end

RegisterServerEvent('gcPhone:getHistoriqueCall')
AddEventHandler('gcPhone:getHistoriqueCall', function()
    local sourcePlayer = tonumber(source)
    local srcIdentifier = getPlayerID(source)
    local srcPhone = getNumberPhone(srcIdentifier)
    sendHistoriqueCall(sourcePlayer, num)
end)

local FixePhone = {}

RegisterServerEvent('gcPhone:internal_startCall')
AddEventHandler('gcPhone:internal_startCall', function(source, phone_number, rtcOffer, extraData)
    if FixePhone[phone_number] ~= nil then
        onCallFixePhone(source, phone_number, rtcOffer, extraData)
        return
    end
    
    local rtcOffer = rtcOffer
    if phone_number == nil or phone_number == '' then 
        print('BAD CALL NUMBER IS NIL')
        return
    end

    local hidden = string.sub(phone_number, 1, 1) == '#'
    if hidden == true then
        phone_number = string.sub(phone_number, 2)
    end

    local indexCall = lastIndexCall
    lastIndexCall = lastIndexCall + 1

    local sourcePlayer = tonumber(source)
    local srcIdentifier = getPlayerID(source)

    local srcPhone = ''
    if extraData ~= nil and extraData.useNumber ~= nil then
        srcPhone = extraData.useNumber
    else
        srcPhone = getNumberPhone(srcIdentifier)
    end
    local destPlayer = getIdentifierByPhoneNumber(phone_number)
    local is_valid = destPlayer ~= nil and destPlayer ~= srcIdentifier
    AppelsEnCours[indexCall] = {
        id = indexCall,
        transmitter_src = sourcePlayer,
        transmitter_num = srcPhone,
        receiver_src = nil,
        receiver_num = phone_number,
        is_valid = destPlayer ~= nil,
        is_accepts = false,
        hidden = hidden,
        rtcOffer = rtcOffer,
        extraData = extraData
    }
    

    if is_valid == true then
        -- getSourceFromIdentifier(destPlayer, function (srcTo)
        if vRP.getUserSource({destPlayer}) ~= nil then
            srcTo = tonumber(vRP.getUserSource({destPlayer}))

            if srcTo ~= nil then
                AppelsEnCours[indexCall].receiver_src = srcTo
                -- TriggerEvent('gcPhone:addCall', AppelsEnCours[indexCall])
                TriggerClientEvent('gcPhone:waitingCall', sourcePlayer, AppelsEnCours[indexCall], true)
                TriggerClientEvent('gcPhone:waitingCall', srcTo, AppelsEnCours[indexCall], false)
            else
                -- TriggerEvent('gcPhone:addCall', AppelsEnCours[indexCall])
                TriggerClientEvent('gcPhone:waitingCall', sourcePlayer, AppelsEnCours[indexCall], true)
            end
        end
    else
        TriggerEvent('gcPhone:addCall', AppelsEnCours[indexCall])
        TriggerClientEvent('gcPhone:waitingCall', sourcePlayer, AppelsEnCours[indexCall], true)
    end

end)

RegisterServerEvent('gcPhone:startCall')
AddEventHandler('gcPhone:startCall', function(phone_number, rtcOffer, extraData)
    TriggerEvent('gcPhone:internal_startCall',source, phone_number, rtcOffer, extraData)
end)

RegisterServerEvent('gcPhone:candidates')
AddEventHandler('gcPhone:candidates', function (callId, candidates)
    -- print('send cadidate', callId, candidates)
    if AppelsEnCours[callId] ~= nil then
        local source = source
        local to = AppelsEnCours[callId].transmitter_src
        if source == to then 
            to = AppelsEnCours[callId].receiver_src
        end
        -- print('TO', to)
        TriggerClientEvent('gcPhone:candidates', to, candidates)
    end
end)


RegisterServerEvent('gcPhone:acceptCall')
AddEventHandler('gcPhone:acceptCall', function(infoCall, rtcAnswer)
    local id = infoCall.id
    if AppelsEnCours[id] ~= nil then
        if PhoneFixeInfo[id] ~= nil then
            onAcceptFixePhone(source, infoCall, rtcAnswer)
            return
        end
        AppelsEnCours[id].receiver_src = infoCall.receiver_src or AppelsEnCours[id].receiver_src
        if AppelsEnCours[id].transmitter_src ~= nil and AppelsEnCours[id].receiver_src~= nil then
            AppelsEnCours[id].is_accepts = true
            AppelsEnCours[id].rtcAnswer = rtcAnswer
            TriggerClientEvent('gcPhone:acceptCall', AppelsEnCours[id].transmitter_src, AppelsEnCours[id], true)
	    SetTimeout(1000, function() -- change to +1000, if necessary.
       		TriggerClientEvent('gcPhone:acceptCall', AppelsEnCours[id].receiver_src, AppelsEnCours[id], false)
	    end)
            saveAppels(AppelsEnCours[id])
        end
    end
end)




RegisterServerEvent('gcPhone:rejectCall')
AddEventHandler('gcPhone:rejectCall', function (infoCall)
    local id = infoCall.id
    if AppelsEnCours[id] ~= nil then
        if PhoneFixeInfo[id] ~= nil then
            onRejectFixePhone(source, infoCall)
            return
        end
        if AppelsEnCours[id].transmitter_src ~= nil then
            TriggerClientEvent('gcPhone:rejectCall', AppelsEnCours[id].transmitter_src)
        end
        if AppelsEnCours[id].receiver_src ~= nil then
            TriggerClientEvent('gcPhone:rejectCall', AppelsEnCours[id].receiver_src)
        end

        if AppelsEnCours[id].is_accepts == false then 
            saveAppels(AppelsEnCours[id])
        end
        TriggerEvent('gcPhone:removeCall', AppelsEnCours)
        AppelsEnCours[id] = nil
    end
end)

RegisterServerEvent('gcPhone:appelsDeleteHistorique')
AddEventHandler('gcPhone:appelsDeleteHistorique', function (numero)
    local sourcePlayer = tonumber(source)
    local srcIdentifier = getPlayerID(source)
    local srcPhone = getNumberPhone(srcIdentifier)
    exports['sql']:execute("DELETE FROM phone_calls WHERE `owner` = @owner AND `num` = @num", {
        ['@owner'] = srcPhone,
        ['@num'] = numero
    })
end)

function appelsDeleteAllHistorique(srcIdentifier)
    local srcPhone = getNumberPhone(srcIdentifier)
    exports['sql']:execute("DELETE FROM phone_calls WHERE `owner` = @owner", {
        ['@owner'] = srcPhone
    })
end

RegisterServerEvent('gcPhone:appelsDeleteAllHistorique')
AddEventHandler('gcPhone:appelsDeleteAllHistorique', function ()
    local sourcePlayer = tonumber(source)
    local srcIdentifier = getPlayerID(source)
    appelsDeleteAllHistorique(srcIdentifier)
end)










































--====================================================================================
--  OnLoad
--====================================================================================
AddEventHandler("vRP:playerSpawn",function(user_id, source, first_spawn)
    local sourcePlayer = tonumber(source)
    local identifier = getPlayerID(source)
    getOrGeneratePhoneNumber(sourcePlayer, identifier, function (myPhoneNumber)
        TriggerClientEvent("gcPhone:myPhoneNumber", sourcePlayer, myPhoneNumber)
        TriggerClientEvent("gcPhone:contactList", sourcePlayer, getContacts(identifier))
        TriggerClientEvent("gcPhone:allMessage", sourcePlayer, getMessages(identifier))
    end)
    local bankM = vRP.getBankMoney({user_id})
    TriggerClientEvent('gcphone:setAccountMoney', source, bankM)
end)


-- Just For reload
RegisterServerEvent('gcPhone:allUpdate')
AddEventHandler('gcPhone:allUpdate', function()
    local sourcePlayer = tonumber(source)
    local identifier = getPlayerID(source)
    local num = getNumberPhone(identifier)
    TriggerClientEvent("gcPhone:myPhoneNumber", sourcePlayer, num)
    TriggerClientEvent("gcPhone:contactList", sourcePlayer, getContacts(identifier))
    TriggerClientEvent("gcPhone:allMessage", sourcePlayer, getMessages(identifier))
    sendHistoriqueCall(sourcePlayer, num)
end)



function onCallFixePhone (source, phone_number, rtcOffer, extraData)
    local indexCall = lastIndexCall
    lastIndexCall = lastIndexCall + 1

    local hidden = string.sub(phone_number, 1, 1) == '#'
    if hidden == true then
        phone_number = string.sub(phone_number, 2)
    end
    local sourcePlayer = tonumber(source)
    local srcIdentifier = getPlayerID(source)

    local srcPhone = ''
    if extraData ~= nil and extraData.useNumber ~= nil then
        srcPhone = extraData.useNumber
    else
        srcPhone = getNumberPhone(srcIdentifier)
    end

    AppelsEnCours[indexCall] = {
        id = indexCall,
        transmitter_src = sourcePlayer,
        transmitter_num = srcPhone,
        receiver_src = nil,
        receiver_num = phone_number,
        is_valid = false,
        is_accepts = false,
        hidden = hidden,
        rtcOffer = rtcOffer,
        extraData = extraData,
        coords = FixePhone[phone_number].coords
    }
    
    PhoneFixeInfo[indexCall] = AppelsEnCours[indexCall]

    TriggerClientEvent('gcPhone:notifyFixePhoneChange', -1, PhoneFixeInfo)
    TriggerClientEvent('gcPhone:waitingCall', sourcePlayer, AppelsEnCours[indexCall], true)
end



function onAcceptFixePhone(source, infoCall, rtcAnswer)
    local id = infoCall.id
    
    AppelsEnCours[id].receiver_src = source
    if AppelsEnCours[id].transmitter_src ~= nil and AppelsEnCours[id].receiver_src~= nil then
        AppelsEnCours[id].is_accepts = true
        AppelsEnCours[id].forceSaveAfter = true
        AppelsEnCours[id].rtcAnswer = rtcAnswer
        PhoneFixeInfo[id] = nil
        TriggerClientEvent('gcPhone:notifyFixePhoneChange', -1, PhoneFixeInfo)
        TriggerClientEvent('gcPhone:acceptCall', AppelsEnCours[id].transmitter_src, AppelsEnCours[id], true)
	SetTimeout(1000, function() -- change to +1000, if necessary.
       		TriggerClientEvent('gcPhone:acceptCall', AppelsEnCours[id].receiver_src, AppelsEnCours[id], false)
	end)
        saveAppels(AppelsEnCours[id])
    end
end

function onRejectFixePhone(source, infoCall, rtcAnswer)
    local id = infoCall.id
    PhoneFixeInfo[id] = nil
    TriggerClientEvent('gcPhone:notifyFixePhoneChange', -1, PhoneFixeInfo)
    TriggerClientEvent('gcPhone:rejectCall', AppelsEnCours[id].transmitter_src)
    if AppelsEnCours[id].is_accepts == false then
        saveAppels(AppelsEnCours[id])
    end
    AppelsEnCours[id] = nil
    
end


RegisterServerEvent("gcPhone:moneyTransfer")
AddEventHandler("gcPhone:moneyTransfer",function(num, amount)
    local source = source


    local nuser_id = tonumber(num)
    --if #result > 0 then
    --    nuser_id = tonumber(num)
    --else
    --    vRPclient.notify(source, {"This number is not registered to PayPal (" .. num .. ")"})
    --    return
    --end
    local nplayer = vRP.getUserSource({nuser_id})
    if nplayer ~= nil then
        local user_id = vRP.getUserId({source})
        local player = vRP.getUserSource({user_id})
        if tonumber(player) == tonumber(nplayer) then
            vRPclient.notify(source, {"You can not transfer money to yourself."})
            CancelEvent()
        else
            local result2 =
                exports["sql"]:executeSync(
                "SELECT * FROM vrp_user_identities WHERE user_id = @user_id",
                {["@user_id"] = user_id}
            )[1]
            local identity = htmlEntities.encode(result2.firstname) .. " " .. htmlEntities.encode(result2.name)
            local nidentity = htmlEntities.encode(result[1].firstname) .. " " .. htmlEntities.encode(result[1].name)
            local rounded = math.floor(tonumber(amount))
            if (string.len(rounded) >= 9) then
                vRPclient.notify(source, {"The amount is too high."})

                CancelEvent()
            else
                vRP.request({player,"Do you want to transfer " .. rounded .. " to " .. nidentity .. "?",30,function(player, ok)
                    if ok then
                        local bankbalance = vRP.getBankMoney({user_id})
                        local newbalance = bankbalance - rounded
                        if (rounded <= bankbalance) then
                            local bankbalance2 = vRP.getBankMoney({nuser_id})
                            local newbalance2 = bankbalance2 + rounded
                            local new_balance = bankbalance - amount
                            local new_balance2 = bankbalance2 + amount
                            vRP.setBankMoney({user_id, new_balance, "Gcphone bank given money to: " .. nuser_id})
                            vRP.setBankMoney({nuser_id, new_balance2, "Gcphone bank recivied money from: " .. user_id})
                            local wallet = vRP.getMoney({user_id})
                            local wallet2 = vRP.getMoney({nuser_id})
                            TriggerClientEvent('mythic_notify:client:SendAlert', player, { type = 'success', text = "Transferred: " .. rounded .. " £ to " .. nidentity .. "."})
                            TriggerClientEvent('mythic_notify:client:SendAlert', nplayer, { type = 'success', text = "Received: " .. rounded .. " £ from " .. identity .. "."})
                            CancelEvent()
                        else
                            TriggerClientEvent('mythic_notify:client:SendAlert', player, { type = 'error', text = 'You do not have enough money in your account.'})
                        end
                    else
                        TriggerClientEvent('mythic_notify:client:SendAlert', player, { type = 'error', text = 'You have canceled.'})
                    end
                end})
            end
        end
    else
        vRPclient.notify(source, {'This account is not available right now.'})
    end
end)



-----------------------------








RegisterServerEvent('vrp_addons_gcphone:sendMessage')
AddEventHandler('vrp_addons_gcphone:sendMessage', function(number, alert, player)
	local mess = alert.message
	if alert.coords ~= nil then
		mess = mess .. ' GPS: ' .. alert.coords.x .. ', ' .. alert.coords.y 
	end
    local n = getNumberPhone(src)
    if n ~= nil then
        TriggerEvent('gcPhone:_internalAddMessage', number, n, mess, 0, function(smsMess)
            TriggerClientEvent("gcPhone:receiveMessage", player, smsMess)
        end)
    end
end)