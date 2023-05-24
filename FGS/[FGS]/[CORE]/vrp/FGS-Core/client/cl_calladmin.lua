cooldown = false

RegisterCommand("calladmin", function()
  FGS_server_callback("FGS:ADMINTICKETSENT",cooldown)
  cooldown = true
end)
  
Citizen.CreateThread(function()
  while true do
  Wait(60000)
    if cooldown == true then
      cooldown = false
    end
  end
end)

RegisterCommand('return', function()
  FGS_server_callback('FGS:return')
end)
  
RegisterCommand('999', function()
  FGS_server_callback('FGS:receivePoliceTickets')
end)

RegisterCommand('101', function()
  FGS_server_callback('FGS:recieveNHSCall')
end)

RegisterCommand('lawyer', function()
  FGS_server_callback('FGS:recieveLawyerCall')
end)