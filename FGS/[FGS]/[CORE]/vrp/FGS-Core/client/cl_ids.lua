RegisterCommand("getid", function(source, args)
    FGS_server_callback("FGS:GetID",args)
end)



RegisterNetEvent('FGS:CLIENTGETID')
AddEventHandler('FGS:CLIENTGETID', function(id)
    FGS_server_callback("FGS:GetID",source)
    


end)


FGS_server_callback("PlayerJoined")