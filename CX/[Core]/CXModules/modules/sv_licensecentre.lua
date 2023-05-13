local cfg = module("CXModules", "cfg/cfg_licenses")

local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vRP")

RegisterNetEvent("CXRP:BuyLicense")
AddEventHandler("CXRP:BuyLicense", function(name)
    local user_id = vRP.getUserId({source})

    if user_id ~= nil then
        for k, v in pairs(cfg.licenses) do
            if v.name == name then
                if vRP.hasGroup({user_id, v.group}) == false then
                    if v.group == 'AdvancedRebel' and not vRP.hasGroup({user_id, 'Rebel'}) then vRPclient.notify(source,{"~r~You need to have Rebel License to be able to purchase this."}) return end
                    if vRP.tryBankPayment({user_id, v.price}) then
                        vRPclient.notify(source,{"~g~Bought "..v.name.." for £"..getMoneyStringFormatted(v.price)})
                        vRPclient.playFrontendSound(source,{"Hack_Success", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS"})
                        vRP.addUserGroup({user_id, v.group})
                        webhook = "https://discord.com/api/webhooks/1038909488071188650/8w_VUyjabMba-z3Cn2W5r_ll5u5a6CgP_zIQL5ghYLYdkS6GidnN40yYhpKIDWdz_8bT"
                        PerformHttpRequest(webhook, function(err, text, headers) 
                        end, "POST", json.encode({username = "vRP", embeds = {
                            {
                                ["color"] = "15158332",
                                ["title"] = "Purchase",
                                ["description"] = "**User Name:** "..GetPlayerName(source).."\n**User ID:** "..user_id.."\n**Purchased License:** "..v.name.. "\nPrice: " ..v.price,
                                ["footer"] = {
                                    ["text"] = "Time - "..os.date("%x %X %p"),
                                }
                        }}}), { ["Content-Type"] = "application/json" })
                    else
                        vRPclient.notify(source,{"~r~You don't have enough money to buy "..v.name})
                        vRPclient.playFrontendSound(source,{"Hack_Failed", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS"})
                    end
                else
                    vRPclient.notify(source,{"~r~You already own "..v.name})
                end
            end
        end
    end
end)

RegisterNetEvent("CXRP:BuyIllegalLicense")
AddEventHandler("CXRP:BuyIllegalLicense", function(name)
    local user_id = vRP.getUserId({source})

    if user_id ~= nil then
        for k, v in pairs(cfg.illegal) do
            if v.name == name then
                if vRP.hasGroup({user_id, v.group}) == false then
                    if v.group == 'AdvancedRebel' and not vRP.hasGroup({user_id, 'Rebel'}) then vRPclient.notify(source,{"~r~You need to have Rebel License to be able to purchase this."}) return end
                    if vRP.tryBankPayment({user_id, v.price}) then
                        vRPclient.notify(source,{"~g~Bought "..v.name.." for £"..getMoneyStringFormatted(v.price)})
                        vRPclient.playFrontendSound(source,{"Hack_Success", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS"})
                        vRP.addUserGroup({user_id, v.group})
                        webhook = "https://discord.com/api/webhooks/1038909488071188650/8w_VUyjabMba-z3Cn2W5r_ll5u5a6CgP_zIQL5ghYLYdkS6GidnN40yYhpKIDWdz_8bT"
                        PerformHttpRequest(webhook, function(err, text, headers) 
                        end, "POST", json.encode({username = "vRP", embeds = {
                            {
                                ["color"] = "15158332",
                                ["title"] = "Purchase",
                                ["description"] = "**User Name:** "..GetPlayerName(source).."\n**User ID:** "..user_id.."\n**Purchased License:** "..v.name.. "\nPrice: " ..v.price,
                                ["footer"] = {
                                    ["text"] = "Time - "..os.date("%x %X %p"),
                                }
                        }}}), { ["Content-Type"] = "application/json" })
                    else
                        vRPclient.notify(source,{"~r~You don't have enough money to buy "..v.name})
                        vRPclient.playFrontendSound(source,{"Hack_Failed", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS"})
                    end
                else
                    vRPclient.notify(source,{"~r~You already own "..v.name})
                end
            end
        end
    end
end)

RegisterNetEvent("CXRP:RemoveLicense")
AddEventHandler("CXRP:RemoveLicense", function(name)
    local user_id = vRP.getUserId({source})

    if user_id ~= nil then
        for k, v in pairs(cfg.licenses) do
            if v.name == name then
                if vRP.hasGroup({user_id, v.group}) then
                    vRP.removeUserGroup({user_id, "HighRoller"})
                    vRP.giveBankMoney({user_id, 5000000})
                    vRPclient.notify(source,{"~g~Removed "..v.name.." for £5,000,000"})
                    vRPclient.playFrontendSound(source,{"Hack_Success", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS"})
                    webhook = "https://discord.com/api/webhooks/1038909488071188650/8w_VUyjabMba-z3Cn2W5r_ll5u5a6CgP_zIQL5ghYLYdkS6GidnN40yYhpKIDWdz_8bT"
                    PerformHttpRequest(webhook, function(err, text, headers) 
                    end, "POST", json.encode({username = "vRP", embeds = {
                        {
                            ["color"] = "15158332",
                            ["title"] = "Refund",
                            ["description"] = "**User Name:** "..GetPlayerName(source).."\n**User ID:** "..user_id.."\n**Refunded License:** "..v.name,
                            ["footer"] = {
                                ["text"] = "Time - "..os.date("%x %X %p"),
                            }
                    }}}), { ["Content-Type"] = "application/json" })
                else
                    vRPclient.notify(source,{"~r~You do not own "..v.name.." License"})
                end
            end
        end
    end
end)
RegisterNetEvent("CXRP:RemoveLicensecenter")
AddEventHandler("CXRP:RemoveLicensecenter", function(name)
    local user_id = vRP.getUserId({source})

    if user_id ~= nil then
        for k, v in pairs(cfg.refundlicenese) do
            if v.name == name then
                if vRP.hasGroup({user_id, v.group}) then
                    vRP.removeUserGroup({user_id, v.group })
                    vRP.giveBankMoney({user_id, v.refund})
                    vRPclient.notify(source,{"~g~Removed "..v.name.." for £"..getMoneyStringFormatted(v.refund)})
                    vRPclient.playFrontendSound(source,{"Hack_Success", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS"})
                    webhook = "https://discord.com/api/webhooks/1038909488071188650/8w_VUyjabMba-z3Cn2W5r_ll5u5a6CgP_zIQL5ghYLYdkS6GidnN40yYhpKIDWdz_8bT"
                    PerformHttpRequest(webhook, function(err, text, headers) 
                    end, "POST", json.encode({username = "vRP", embeds = {
                        {
                            ["color"] = "15158332",
                            ["title"] = "Refunds",
                            ["description"] = "**User Name:** "..GetPlayerName(source).."\n**User ID:** "..user_id.."\n**Refunded License:** "..v.name,
                            ["footer"] = {
                                ["text"] = "Time - "..os.date("%x %X %p"),
                            }
                    }}}), { ["Content-Type"] = "application/json" })
                else
                    vRPclient.notify(source,{"~r~You do not own "..v.name.." License"})
                end
            end
        end
    end
end)

function getMoneyStringFormatted(cashString)
	local i, j, minus, int, fraction = tostring(cashString):find('([-]?)(%d+)([.]?%d*)')
	int = int:reverse():gsub("(%d%d%d)", "%1,")
	return minus .. int:reverse():gsub("^,", "") .. fraction 
end