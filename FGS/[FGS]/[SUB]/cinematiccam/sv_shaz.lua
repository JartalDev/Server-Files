-- Networking
RegisterServerEvent("netDisable")
AddEventHandler("netDisable", function(bcnetid, target)
	TriggerClientEvent('disableBaitCar', target, bcnetid)
end)

RegisterServerEvent("netUnlock")
AddEventHandler("netUnlock", function(bcnetid, target)
	TriggerClientEvent('unlockBaitCar', target, bcnetid)
end)

RegisterServerEvent("netRearm")
AddEventHandler("netRearm", function(bcnetid, target)
	TriggerClientEvent('rearmBaitCar', target, bcnetid)
end)

RegisterServerEvent("netReset")
AddEventHandler("netReset", function(bcnetid, target)
	TriggerClientEvent('resetBaitCar', -1)
end)
