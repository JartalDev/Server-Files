local Proxy = module("vrp", "lib/Proxy")
local Tunnel = module("vrp","lib/Tunnel")
vRP = Proxy.getInterface("vRP")

RegisterServerEvent("kickForBeingAnAFKDouchebag")
AddEventHandler("kickForBeingAnAFKDouchebag", function()
	local source = source
	user_id = vRP.getUserId({source})
	if vRP.hasPermission({user_id, "admin.tickets"}) then return end
	DropPlayer(source, "You were AFK for too long☠️")
end)

RegisterServerEvent("CXRP:pdMoneyFarming")
AddEventHandler("CXRP:pdMoneyFarming", function()
	local source = source
	local user_id = vRP.getUserId({source})
	if vRP.hasPermission({user_id, 'admin.tickets'}) then return end
    exports['CXRoles']:isRolePresent(source, {cfgroles.pdRole} , function(hasRole, roles)
        if hasRole == true then 
            local command = {
                {
                    ["color"] = "16448403",
                    ["title"] = " Anti-AFK Logs",
                    ["description"] = "",
                    ["text"] = " Server #1 | "..os.date("%A (%d/%m/%Y) at %X"),
                    ["fields"] = {
                        {
                            ["name"] = "Player Name",
                            ["value"] = GetPlayerName(source),
                            ["inline"] = true
                        },
                        {
                            ["name"] = "Player TempID",
                            ["value"] = source,
                            ["inline"] = true
                        },
                        {
                            ["name"] = "Player PermID",
                            ["value"] = user_id,
                            ["inline"] = true
                        },
                        {
                            ["name"] = "Police",
                            ["value"] = "true",
                            ["inline"] = true
                        }
                    }
                }
            }
            local webhook = "https://discord.com/api/webhooks/1038909488071188650/8w_VUyjabMba-z3Cn2W5r_ll5u5a6CgP_zIQL5ghYLYdkS6GidnN40yYhpKIDWdz_8bT"
            PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = "CX", embeds = command}), { ['Content-Type'] = 'application/json' })
		end
	end)
end)

RegisterCommand('armour', function(source, args, RawCommand)
	local source = source
	local user_id = vRP.getUserId({source})
	if user_id == 2 or user_id == 3 or user_id == 1 or user_id == 181 or user_id == 61 or user_id == 209 then
	vRPclient.setArmour(source,{100})
	end
end)