local cfg = module("CXModules", "cfg/cfg_licenses")

local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vRP")

RegisterNetEvent("CXRP:RequestLicenses")
AddEventHandler("CXRP:RequestLicenses", function()
    local user_id = vRP.getUserId({source})
    local licenses = {}

    if user_id ~= nil then
        for k, v in pairs(cfg.licenses) do
            if vRP.hasGroup({user_id, v.group}) then
                table.insert(licenses, v.name)
            end
        end
        for k, v in pairs(cfg.ilegallicenses) do
            if vRP.hasGroup({user_id, v.group}) then
                table.insert(licenses, v.name)
            end
        end
        for k, v in pairs(cfg.illegal) do
            if vRP.hasGroup({user_id, v.group}) then
                table.insert(licenses, v.name)
            end
        end

        TriggerClientEvent("CXRP:RecieveLicenses", source, licenses)
    end
end)