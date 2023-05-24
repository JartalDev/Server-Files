RegisterCommand("beta", function(source, args)
    TriggerServerEvent('beta', table.concat(args, " "))
    
end)