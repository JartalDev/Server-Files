-- vRP TUNNEL/PROXY
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","CXRP_Clamp")

-- RESOURCE TUNNEL/PROXY
CXRPClampServer = {}
Tunnel.bindInterface("CXRP_Clamp",CXRPClampServer)
Proxy.addInterface("CXRP_Clamp",CXRPClampServer)
CXRPClampClient = Tunnel.getInterface("CXRP_Clamp","CXRP_Clamp")


RegisterCommand("clamp", function(source, args, rawCommand)
  local user_id = vRP.getUserId({source})
  if vRP.hasPermission({user_id,"police.menu"}) then
    CXRPClampClient.ClampVehicle(source)
  else
    vRPclient.notify(source,{"~r~You are not on duty."})
  end
end, false)

function CXRPClampServer.ChangeVehState(veh, disable)
  print(veh, disable)
  CXRPClampClient.ChangeVehState(-1, {veh, disable})
end


RegisterServerEvent("CXRP:ClampVehicle")
AddEventHandler("CXRP:ClampVehicle", function()
  local user_id = vRP.getUserId({source})
  if vRP.hasPermission({user_id,"police.menu"}) then
    CXRPClampClient.ClampVehicle(source)
  else
    vRPclient.notify(source,{"~r~You are not on duty."})
  end
end, false)