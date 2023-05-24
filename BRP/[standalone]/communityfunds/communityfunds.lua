local communityFunds = 0

RegisterServerEvent('communityfunds:addFunds')
AddEventHandler('communityfunds:addFunds', function(amount)
  local source = source
  
  -- check if the player has the necessary permission to add funds to the community using qbcore permission
  if not exports['qbcore']:HasPermission(source, 'communityfunds.add') then
    TriggerClientEvent('chat:addMessage', source, {args = {'^1Error:', 'You do not have permission to add funds to the community.'}})
    return
  end
  
  communityFunds = communityFunds + amount
end)

RegisterServerEvent('communityfunds:removeFunds')
AddEventHandler('communityfunds:removeFunds', function(amount)
  local source = source
  
  -- check if the player has the necessary permission to remove funds from the community using qbcore permission
  if not exports['qbcore']:HasPermission(source, 'communityfunds.remove') then
    TriggerClientEvent('chat:addMessage', source, {args = {'^1Error:', 'You do not have permission to remove funds from the community.'}})
    return
  end
  
  if communityFunds >= amount then
    communityFunds = communityFunds - amount
    TriggerClientEvent('chat:addMessage', -1, {args = {'Community Funds:', '£' .. communityFunds}})
  else
    TriggerClientEvent('chat:addMessage', source, {args = {'^1Error:', 'There are not enough community funds to complete this transaction.'}})
  end
end)

RegisterCommand('communityfunds', function(source, args, rawCommand)
  local source = source
  
  -- check if the player has the necessary permission to view community funds using qbcore permission
  if not exports['qbcore']:HasPermission(source, 'communityfunds.view') then
    TriggerClientEvent('chat:addMessage', source, {args = {'^1Error:', 'You do not have permission to view community funds.'}})
    return
  end 
end false)

--when TriggerClientEvent("communityfunds") do 
  --NativeUIMenu.Create("communityfunds, Deposit, Withdraw,") function()
  --end
--end -- dont touch
  
  
  -- please dont touch unless you have spoken to me ( inc ) as this can be very easily broken 

  -- read all comments to make sure you know the triggers for them
  
 
