local playerlist = {}
local playersId = 0
local staffOnline = 0
local pdOnline = 0
local nhsdOnline = 0
local job = ''

RegisterServerEvent("playerlist:playerJoined")
AddEventHandler("playerlist:playerJoined", function()
local source = source
local xPlayer = QBCore.Functions.GetPlayer(source)
if xPlayer ~= nil then
name = xPlayer.getName()
user_id = xPlayer.PlayerData.citizenid
playtime = xPlayer.PlayerData.playtime or 0
PlayerTimeInHours = playtime / 60
if PlayerTimeInHours < 1 then
PlayerTimeInHours = 0
end
playersId = playersId + 1
job = 'Unemployed'
if xPlayer.PlayerData.job ~= nil and xPlayer.PlayerData.job.name == 'staff' then
staffOnline = staffOnline + 1
job = 'Staff'
end
if xPlayer.PlayerData.job ~= nil and xPlayer.PlayerData.job.name == 'police' then
pdOnline = pdOnline + 1
job = 'Police'
end
if xPlayer.PlayerData.job ~= nil and xPlayer.PlayerData.job.name == 'nhs' then
dpdOnline = dpdOnline + 1
job = 'NHS'
end
table.insert(playerlist, { UserID = user_id, playersTime = math.ceil(PlayerTimeInHours), playersId = playersId, playersName = name, playersJob = job })
end
TriggerClientEvent("playerlist:updatePlayers", -1, playerlist, #GetPlayers() .. '/128', 'Staff 🧙‍♂️ ' .. staffOnline .. ' | Police 👮‍♂️ ' .. pdOnline .. ' | dpd 🚑 ' .. dpdOnline, false)
end)

RegisterServerEvent("playerlist:getUpdatedPlayers")
AddEventHandler("playerlist:getUpdatedPlayers", function(value)
TriggerClientEvent("playerlist:updatePlayers", source, playerlist, #GetPlayers() .. '/128', 'Staff 🧙‍♂️ ' .. staffOnline .. ' | Police 👮‍♂️ ' .. pdOnline .. ' | dpd 🚑 ' .. dpdOnline, value)
end)

AddEventHandler("playerDropped", function()
local source = source
local xPlayer = QBCore.Functions.GetPlayer(source)
if xPlayer ~= nil then
name = xPlayer.getName()
user_id = xPlayer.PlayerData.citizenid
for k, v in pairs(playerlist) do
if v.UserID == user_id then
table.remove(playerlist, k)
end
end
if xPlayer.PlayerData.job ~= nil and xPlayer.PlayerData.job.name == 'staff' then
staffOnline = staffOnline - 1
end
if xPlayer.PlayerData.job ~= nil and xPlayer.PlayerData.job.name == 'police' then
pdOnline = pdOnline - 1
end
if xPlayer.PlayerData.job ~= nil and xPlayer.PlayerData.job.name == 'NHS' then
dpdOnline = dpdOnline - 1
end
end
end)