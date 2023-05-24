local staffon = false 
armour = 0
health = 200

staffon = false
adminTicketSavedCustomization = nil
savedAdminTicketGuns = nil
RegisterNetEvent("FGS:staffon")
AddEventHandler("FGS:staffon",function(DioMode)
	staffon = DioMode
	if not staffon then
 		SetEntityInvincible(GetPlayerPed(-1), false)
		SetPlayerInvincible(PlayerId(), false)
		SetPedCanRagdoll(GetPlayerPed(-1), true)
		ClearPedBloodDamage(GetPlayerPed(-1))
		ResetPedVisibleDamage(GetPlayerPed(-1))
		ClearPedLastWeaponDamage(GetPlayerPed(-1))
		SetEntityProofs(GetPlayerPed(-1), false, false, false, false, false, false, false, false)
		SetEntityCanBeDamaged(GetPlayerPed(-1), true)    
        if adminTicketSavedCustomization ~= nil then 
            tvRP.setCustomization(adminTicketSavedCustomization)
            adminTicketSavedCustomization = nil 
        end
		tvRP.giveWeapons(savedAdminTicketGuns,false)
        Wait(1000)
        SetPedArmour(PlayerPedId(), armour)
        SetEntityHealth(PlayerPedId(),health)
	else
        if adminTicketSavedCustomization == nil then 
            adminTicketSavedCustomization = tvRP.getCustomization()
        end
        armour = GetPedArmour(PlayerPedId())
		savedAdminTicketGuns = tvRP.getWeapons()
        
        RemoveAllPedWeapons(PlayerPedId(), true)
        if GetEntityModel(PlayerPedId()) ~= GetHashKey("mp_f_freemode_01") then
		    Wait(100)                   
            SetPedComponentVariation(GetPlayerPed(-1),3,31,0,0) -- [Hand]
            SetPedComponentVariation(GetPlayerPed(-1),4,175,13,0) -- [Legs]
            SetPedComponentVariation(GetPlayerPed(-1),8,15,0,0) -- [Undershirt]
            SetPedComponentVariation(GetPlayerPed(-1),11,398,0,00) -- [Jacket]
			SetPedComponentVariation(GetPlayerPed(-1),6,145,0,00) -- [shoe]
            SetPedArmour(PlayerPedId(), armour)
            SetEntityHealth(PlayerPedId(),health)
        elseif
        GetEntityModel(PlayerPedId()) ~= GetHashKey("mp_m_freemode_01") then
		    Wait(100)
            SetPedComponentVariation(GetPlayerPed(-1),3,36,0,0) -- [Hand]
            SetPedComponentVariation(GetPlayerPed(-1),4,161,0,0) -- [Legs]
            SetPedComponentVariation(GetPlayerPed(-1),8,2,0,0) -- [Undershirt]
            SetPedComponentVariation(GetPlayerPed(-1),11,500,0,00) -- [Jacket]
			SetPedComponentVariation(GetPlayerPed(-1),6,116,0,00) -- [shoe]
            SetPedArmour(PlayerPedId(), armour)
            SetEntityHealth(PlayerPedId(),health)
        end
        
	end
end)


Citizen.CreateThread(function() 
	while true do
		if staffon then
			SetEntityInvincible(GetPlayerPed(-1), true)
			SetPlayerInvincible(PlayerId(), true)
			SetPedCanRagdoll(GetPlayerPed(-1), false)
			ClearPedBloodDamage(GetPlayerPed(-1))
			ResetPedVisibleDamage(GetPlayerPed(-1))
			ClearPedLastWeaponDamage(GetPlayerPed(-1))
			SetEntityProofs(GetPlayerPed(-1), true, true, true, true, true, true, true, true)
			SetEntityCanBeDamaged(GetPlayerPed(-1), false)
			SetEntityHealth(GetPlayerPed(-1), 200)			
            SetTextEntry_2("STRING")
            AddTextComponentString("~r~You are in Admin Mode, /staffmode or /return to go off duty.")
            EndTextCommandPrint(1000, 1)		end
		Wait(0)
	end
end)



local noclip = false
local noclip_speed = 5.0

function tvRP.toggleNoclip()
    noclip = not noclip
    local ped = GetPlayerPed(-1)
    if noclip then -- set
        SetEntityVisible(ped, false, false)
    else -- unset
        SetEntityVisible(ped, true, false)
    end
end

function tvRP.isNoclip()
    return noclip
end

-- noclip/invisibility
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if noclip then
            local ped = GetPlayerPed(-1)
            local x, y, z = tvRP.getPosition()
            local dx, dy, dz = tvRP.getCamDirection()
            local speed = noclip_speed

            -- reset velocity
            SetEntityVelocity(ped, 0.0001, 0.0001, 0.0001)

            -- forward
            if IsControlPressed(0, 32) then -- MOVE UP
                x = x + speed * dx
                y = y + speed * dy
                z = z + speed * dz
            end

            -- backward
            if IsControlPressed(0, 269) then -- MOVE DOWN
                x = x - speed * dx
                y = y - speed * dy
                z = z - speed * dz
            end

            SetEntityCoordsNoOffset(ped, x, y, z, true, true, true)
        end
    end
end)