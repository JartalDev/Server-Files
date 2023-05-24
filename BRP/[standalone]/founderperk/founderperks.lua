RegisterCommand("founder", function(source, args, rawCommand)
    -- Check for Permissions
    if player hasPermission "admin" then
      -- Get the player's current vehicle
      local playerPed = GetPlayerPed(source)
      local vehicle = GetVehiclePedIsIn(playerPed, false)
      
      -- Fix the vehicle
      SetVehicleFixed(vehicle)
      SetVehicleDirtLevel(vehicle, 0.0)
      
      -- Notify the player that their vehicle has been fixed
      TriggerClientEvent("chat:addMessage", source, { args = { "[^2BRP2^]", "Your vehicle has been fixed." }})
    else
      -- Notify the player that they don't have permission to use the command
      TriggerClientEvent("chat:addMessage", source, { args = { "[^1BRP1^]", "You don't have permission to use this command." }})
    end
  end)