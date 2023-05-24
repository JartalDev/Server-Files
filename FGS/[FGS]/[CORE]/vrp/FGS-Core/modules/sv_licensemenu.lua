local weed = false
local coke = false
local ecstasy = false
local meth = false
local heroin = false
local large = false
local rebel = false
local diamond1 = false

RegisterServerEvent('FGS:OpenLicense')
AddEventHandler('FGS:OpenLicense', function()
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id ~= nil then
        if vRP.hasGroup(user_id, 'weed') then
            weed = true
        end
        if vRP.hasGroup(user_id, 'coke') then
            coke = true
        end
        if vRP.hasGroup(user_id, 'diamond1') then
            diamond1 = true
        end
        if vRP.hasGroup(user_id, 'ecstasy') then
            ecstasy = true
        end
        if vRP.hasGroup(user_id, 'meth') then
            meth = true
        end
        if vRP.hasGroup(user_id, 'heroin') then
            heroin = true
        end
        if vRP.hasGroup(user_id, 'rebel') then
            rebel = true
        end
        TriggerClientEvent('FGS:OpenLicenseMenu', source, weed, coke, ecstasy, meth, heroin, rebel, diamond1)
    else
        vRPclient.notify(source,{"You are a nil ID, relog."})
    end
end)