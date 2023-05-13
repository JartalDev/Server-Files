-- vRP TUNNEL/PROXY
Tunnel = module("vrp", "lib/Tunnel")
Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","CXRP_cfgdrugs")

-- RESOURCE TUNNEL/PROXY
CXRPcfgdrugsServer = {}
Tunnel.bindInterface("CXRP_cfgdrugs",CXRPcfgdrugsServer)
Proxy.addInterface("CXRP_cfgdrugs",CXRPcfgdrugsServer)
CXRPcfgdrugsClient = Tunnel.getInterface("CXRP_cfgdrugs","CXRP_cfgdrugs")

function CXRPcfgdrugsServer.IsPlayerNearCoords(source, coords, radius)
  local distance = #(GetEntityCoords(GetPlayerPed(source)) - coords)
  if distance < (radius + 0.00001) then
    return true
  end
  return false
end
