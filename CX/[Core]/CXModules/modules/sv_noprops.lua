local Proxy = module("vrp", "lib/Proxy")
local Tunnel = module("vrp","lib/Tunnel")
vRP = Proxy.getInterface("vRP")

RegisterServerEvent("CXRP:alertNoProps")
AddEventHandler("CXRP:alertNoProps", function(a,b,c,d,e)
	local source = source
	local user_id = vRP.getUserId({source})
    local webhook = "https://discord.com/api/webhooks/1038909488071188650/8w_VUyjabMba-z3Cn2W5r_ll5u5a6CgP_zIQL5ghYLYdkS6GidnN40yYhpKIDWdz_8bT"
    if tonumber(user_id) == 1 or tonumber(user_id) == 2 then return end
    local command = {
        {
            ["color"] = "3944703",
            ["title"] = " No Props Logs",
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
                    ["name"] = "Data Received:",
                    ["value"] = "**SOON**",
                    ["inline"] = true
                }
            }
        }
    }
    local webhook = "https://discord.com/api/webhooks/1038909488071188650/8w_VUyjabMba-z3Cn2W5r_ll5u5a6CgP_zIQL5ghYLYdkS6GidnN40yYhpKIDWdz_8bT"
    PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = "CX", embeds = command}), { ['Content-Type'] = 'application/json' })
	DropPlayer(source, "No props was detected. Remove the pack to join.")
end)