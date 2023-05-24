-- Configuration Options
local config = {
	prox_enabled = false,					-- Proximity Enabled
	prox_range = 100000,						-- Distance
	togglecommand = 'killfeed',	        	-- Toggle Kill Feed Command
	chatPrefix = '!',
}

-- Weapons Table
local weapons = {

	[GetHashKey("WEAPON_MOSIN")] = 'mosin',

	-- [Out Guns]
	[GetHashKey("WEAPON_WOODENBAT")] = 'melee',
	[GetHashKey("WEAPON_SINGULARITYKNIFE")] = 'melee',
	[GetHashKey("WEAPON_SHANK")] = 'melee',
	[GetHashKey("WEAPON_KATANASWORD")] = 'melee',
	[GetHashKey("WEAPON_DILDO")] = 'melee',
	[GetHashKey("WEAPON_BROOM")] = 'melee',

	[GetHashKey("WEAPON_M1911")] = 'pistol',
	[GetHashKey("WEAPON_MONTANA")] = 'pistol',
	[GetHashKey("WEAPON_NAILGUN")] = 'pistol',
	[GetHashKey("WEAPON_HUSHGHOST")] = 'pistol',
	[GetHashKey("WEAPON_P226")] = 'pistol',
	[GetHashKey("WEAPON_SCOUSEGLOCK")] = 'pistol',
	[GetHashKey("WEAPON_NIKEPISTOL")] = 'pistol',
	[GetHashKey("WEAPON_ETHANGLOCK")] = 'pistol',
	[GetHashKey("WEAPON_JOKEREXMMZ")] = 'pistol',
	[GetHashKey("WEAPON_GLOCK")] = 'pistol',
	[GetHashKey("WEAPON_HUSHG")] = 'pistol',
	[GetHashKey("WEAPON_WALTHERP99")] = 'pistol',
	[GetHashKey("WEAPON_7IT2")] = 'pistol',
	[GetHashKey("WEAPON_BLACKOPSPISTOL")] = 'pistol',
	[GetHashKey("WEAPON_GDEAGLE")] = 'deagle',


	[GetHashKey("WEAPON_R700")] = 'sniperr',
	[GetHashKey("WEAPON_BLACKOPSSNIPER")] = 'sniperr',


	[GetHashKey("WEAPON_NAZARIOUS")] = 'lmg',

	
	[GetHashKey("WEAPON_VESPER")] = 'smgs',
	[GetHashKey("WEAPON_UMP45")] = 'smgs',
	[GetHashKey("WEAPON_HAHA74U")] = 'smgs',
	[GetHashKey("WEAPON_MP5SDFGS")] = 'smgs',
	[GetHashKey("WEAPON_UWUDUBZYLILLI")] = 'smgs',
	[GetHashKey("WEAPON_MP5X")] = 'smgs',
	[GetHashKey("WEAPON_BLACKOPSSMG")] = 'smgs',


	[GetHashKey("WEAPON_VANDAL")] = 'aks',
	[GetHashKey("WEAPON_RUSTLR300")] = 'aks',
	[GetHashKey("WEAPON_LIQUIDCARBINE")] = 'aks',
	[GetHashKey("WEAPON_REDTIGER")] = 'aks',
	[GetHashKey("WEAPON_NSR")] = 'aks',
	[GetHashKey("WEAPON_ACR1")] = 'aks',
	[GetHashKey("WEAPON_SCARL")] = 'aks',
	[GetHashKey("WEAPON_G36C")] = 'aks',
	[GetHashKey("WEAPON_SIGMPX")] = 'aks',
	[GetHashKey("WEAPON_M4A1SPURPLE")] = 'aks',
	[GetHashKey("WEAPON_ELDERVANDAL")] = 'aks',
	[GetHashKey("WEAPON_GAMBINO")] = 'aks',
	[GetHashKey("WEAPON_BLACKOPSAR")] = 'aks',
	[GetHashKey("WEAPON_M4SICARIO")] = 'aks',
	[GetHashKey("WEAPON_graurainbow")] = 'aks',
	[GetHashKey("WEAPON_m4a1whitenoise")] = 'aks',
	[GetHashKey("WEAPON_m4a4neva")] = 'aks',
	[GetHashKey("WEAPON_m13anime")] = 'aks',
	[GetHashKey("WEAPON_TX15")] = 'aks',
	[GetHashKey("WEAPON_M4SICARIO")] = 'aks',


	[GetHashKey("WEAPON_OLYMPIA")] = 'shotgun',
	[GetHashKey("WEAPON_M870")] = 'shotgun',
}

local feedActive = true
local isDead = false
Citizen.CreateThread(function()
    while true do
		local killed = GetPlayerPed(PlayerId())
		local killedCoords = GetEntityCoords(killed)
		if IsEntityDead(killed) and not isDead then
            local killer = GetPedKiller(killed)
            if killer ~= 0 then
                if killer == killed then
					TriggerServerEvent('KillFeed:Died', killedCoords)
				else
					local KillerNetwork = NetworkGetPlayerIndexFromPed(killer)
					if KillerNetwork == "**Invalid**" or KillerNetwork == -1 then
						TriggerServerEvent('KillFeed:Died', killedCoords)
					else
						TriggerServerEvent('KillFeed:Killed', GetPlayerServerId(KillerNetwork), hashToWeapon(GetPedCauseOfDeath(killed)), killedCoords)
					end
                end
            else
				TriggerServerEvent('KillFeed:Died', killedCoords)
            end
            isDead = true
        end
		if not IsEntityDead(killed) then
			isDead = false
		end
        Citizen.Wait(50)
    end
end)

RegisterNetEvent('KillFeed:AnnounceKill')
AddEventHandler('KillFeed:AnnounceKill', function(killed, killer, weapon, coords)
	if feedActive then
		if coords ~= nil and config.prox_enabled then
			local myLocation = GetEntityCoords(GetPlayerPed(PlayerId()))
			if #(myLocation - coords) < config.prox_range then
				SendNUIMessage({
					type = 'newKill',
					killer = killer,
					killed = killed,
					weapon = weapon,
				})
			end
		else
			SendNUIMessage({
				type = 'newKill',
				killer = killer,
				killed = killed,
				weapon = weapon,
			})
		end
	end
end)

RegisterNetEvent('KillFeed:AnnounceDeath')
AddEventHandler('KillFeed:AnnounceDeath', function(killed, coords)
	if feedActive then
		if coords ~= nil and config.prox_enabled then
			local myLocation = GetEntityCoords(GetPlayerPed(PlayerId()))
			if #(myLocation - coords) < config.prox_range then
				SendNUIMessage({
					type = 'newDeath',
					killed = killed,
				})
			end
		else
			SendNUIMessage({
				type = 'newDeath',
				killed = killed,
			})
		end
	end
end)

function hashToWeapon(hash)
	if weapons[hash] ~= nil then
		return weapons[hash]
	else
		return 'weapon_unarmed'
	end
end

Citizen.CreateThread(function()
	RegisterCommand(config.togglecommand, function(source, args, raw)
		feedActive = not feedActive
		if feedActive then
			--TriggerEvent("chatMessage", '[RDM]', {255, 0, 0}, "" .. "^0 You have ^2enabled^0 the kill feed.")
			TriggerEvent("showNotify", "Kill feed is now ~g~Enabled~w~.")
		else
			--TriggerEvent("chatMessage", '[RDM]', {255, 0, 0}, "" .. "^0 You have ^1disabled^0 the kill feed.")
			TriggerEvent("showNotify", "Kill feed is now ~r~Disabled~w~.")
		end
	end)
	--TriggerEvent('chat:addSuggestion', '/' .. config.togglecommand, 'Toggle the Kill Feed display', {})	
end)

RegisterNetEvent('showNotify')
AddEventHandler('showNotify', function(notify)
	ShowAboveRadarMessage(notify)
end)

function ShowAboveRadarMessage(message)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(message)
	DrawNotification(0,1)
end