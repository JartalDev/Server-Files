local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "FGS_Fuel")

if Config.UseESX then
	RegisterServerEvent('fuel:pay')
	AddEventHandler('fuel:pay', function(price)
		local user_id = vRP.getUserId({source})
		local fuelAmount = math.floor(price)
		if vRP.tryFullPayment({user_id ,fuelAmount})then
		
		end
	end)
end
