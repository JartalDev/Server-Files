local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
local htmlEntities = module("lib/htmlEntities")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "gcphone")

tvRP = {}
Tunnel.bindInterface("rp-radio",tvRP) -- listening for client tunnel

function tvRP.CheckIfPD()
    local src = source 
    local user_id = vRP.getUserId({src})
    if vRP.hasPermission(user_id, "police.menu") then 
        return true 
    else
        return false 
    end
end