local enable = false 
local oldCoords
local TargetSpectate = nil


--local cfg = module("cfg/weapon")
--local WeaponNames = cfg.WeaponNames


RegisterNetEvent("S_vRP:requestSpectate")
AddEventHandler('S_vRP:requestSpectate', function(playerServerId, tgtCoords)
	TargetSpectate = tonumber(playerServerId)
	local localPlayerPed = PlayerPedId()
	if ((not tgtCoords) or (tgtCoords.z == 0.0)) then 
		tgtCoords = GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(tonumber(playerServerId)))) 
	end
    if playerServerId == GetPlayerServerId(PlayerId()) then 
		if oldCoords then
			RequestCollisionAtCoord(oldCoords.x, oldCoords.y, oldCoords.z)
			Wait(500)
			SetEntityCoords(playerPed, oldCoords.x, oldCoords.y, oldCoords.z, 0, 0, 0, false)
			oldCoords=nil
		end
		spectatePlayer(GetPlayerPed(PlayerId()),GetPlayerFromServerId(PlayerId()),GetPlayerName(PlayerId()))
        freezeshit(false)
		return 
	else
		if not oldCoords then
			oldCoords = GetEntityCoords(PlayerPedId())
		end
	end
	SetEntityCoords(localPlayerPed, tgtCoords.x, tgtCoords.y, tgtCoords.z - 10.0, 0, 0, 0, false)
	freezeshit(true)
	stopSpectateUpdate = true
	local adminPed = localPlayerPed
	local playerId = GetPlayerFromServerId(tonumber(playerServerId))
	repeat
		Wait(200)
		playerId = GetPlayerFromServerId(tonumber(playerServerId))
	until ((GetPlayerPed(playerId) > 0) and (playerId ~= -1))

	spectatePlayer(GetPlayerPed(playerId),playerId,GetPlayerName(playerId))
	stopSpectateUpdate = false 
end)

function freezeshit(frozen)
    local localPlayerPedId = PlayerPedId()
    FreezeEntityPosition(localPlayerPedId, frozen)
    if IsPedInAnyVehicle(localPlayerPedId, true) then
        FreezeEntityPosition(GetVehiclePedIsIn(localPlayerPedId, false), frozen)
    end 
end


Citizen.CreateThread( function()
	while true do
		Citizen.Wait(500)
		if drawInfo and not stopSpectateUpdate then
			local localPlayerPed = PlayerPedId()
			local targetPed = GetPlayerPed(drawTarget)
			local targetGod = GetPlayerInvincible(drawTarget)
			
			local tgtCoords = GetEntityCoords(targetPed)
			if tgtCoords and tgtCoords.x ~= 0 then
				SetEntityCoords(localPlayerPed, tgtCoords.x, tgtCoords.y, tgtCoords.z - 10.0, 0, 0, 0, false)
			end
		else
			Citizen.Wait(1000)
		end
	end
end)

Citizen.CreateThread(function()
	while true do 
		Citizen.Wait(0)
		if enable then 
			local targetid = GetPlayerFromServerId(TargetSpectate)
			if targetid ~= nil then 
				local targetped = GetPlayerPed(targetid)
				--local selectedWeapon = GetSelectedPedWeapon(targetped)
				--local PlayersWeaponName = WeaponNames[tostring(selectedWeapon)] or "N/A"
				DrawAdvancedText(0.89, 0.228, 0.004, 0.0028, 0.319, "Player Name: " .. GetPlayerName(targetid) .. " | Temp ID : " .. targetid, 055, 255, 255, 200, 0, 0)
				DrawAdvancedText(0.89, 0.258, 0.004, 0.0028, 0.319, "Player Health: " .. GetEntityHealth(targetped) .. " / ".. GetEntityMaxHealth(targetped), 055, 255, 255, 200, 0, 0)
				DrawAdvancedText(0.89, 0.328, 0.004, 0.0028, 0.319, "Player Armour: " .. GetPedArmour(targetped), 055, 255, 255, 200, 0, 0)
				--DrawAdvancedText(0.89, 0.388, 0.004, 0.0028, 0.319, "Player Weapon: " .. PlayersWeaponName .. " | Player Ammo: " .. GetAmmoInPedWeapon(targetPed, selectedWeapon), 055, 255, 255, 200, 0, 0)
				if IsControlJustPressed(0,38) then 
					spectatePlayer(PlayerPedId(), -1)
				end
			else
				spectatePlayer(PlayerPedId(), -1)
			end
		end
	end
end)







function spectatePlayer(targetPed, target, name)
	local playerPed = PlayerPedId() -- yourself
	enable = true
	if (target == PlayerId() or target == -1) then 
		enable = false
	end
	if(enable)then
		SetEntityVisible(playerPed, false, 0)
		SetEntityCollision(playerPed, false, false)
		SetEntityInvincible(playerPed, true)
		NetworkSetEntityInvisibleToNetwork(playerPed, true)
		Citizen.Wait(200) -- to prevent target player seeing you
		if targetPed == playerPed then
			Wait(500)
			targetPed = GetPlayerPed(target)
		end
		local targetx,targety,targetz = table.unpack(GetEntityCoords(targetPed, false))
		RequestCollisionAtCoord(targetx,targety,targetz)
		NetworkSetInSpectatorMode(true, targetPed)
		
		ShowNotification("started spectating " .. name)
	else
		if oldCoords then
			RequestCollisionAtCoord(oldCoords.x, oldCoords.y, oldCoords.z)
			Wait(500)
			SetEntityCoords(playerPed, oldCoords.x, oldCoords.y, oldCoords.z, 0, 0, 0, false)
			oldCoords=nil
		end
		NetworkSetInSpectatorMode(false, targetPed)
		ShowNotification("Stop spectating")
		freezeshit(false)
		Citizen.Wait(200) -- to prevent staying invisible
		SetEntityVisible(playerPed, true, 0)
		SetEntityCollision(playerPed, true, true)
		SetEntityInvincible(playerPed, false)
		NetworkSetEntityInvisibleToNetwork(playerPed, false)
	end
end



function DrawAdvancedText(x,y ,w,h,sc, text, r,g,b,a,font,jus)
    SetTextFont(font)
    SetTextProportional(0)
    SetTextScale(sc, sc)
	N_0x4e096588b13ffeca(jus)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
   -- SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
	DrawText(x - 0.1+w, y - 0.02+h)
end

function ShowNotification(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(false, false)
end