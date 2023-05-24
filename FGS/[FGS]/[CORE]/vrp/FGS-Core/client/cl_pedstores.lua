Ped = {}

Ped.respawn = {
}

RMenu.Add("PEDSELECTOR", "main", RageUI.CreateMenu("", "~b~Ped Menu",1300,100))


RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('PEDSELECTOR', 'main')) then
        RageUI.DrawContent({ header = true, glare = true, instructionalButton = true}, function()
			RageUI.Button("Danny", "", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
				if Selected then
					local model = GetHashKey('mp_m_freemode_01')
					RequestModel(model)
					while not HasModelLoaded(model) do
						RequestModel(model)
						Citizen.Wait(0)
					end
					SetPlayerModel(PlayerId(), model)
					SetPedComponentVariation(GetPlayerPed(-1), 0, 0, 0, 2) 
					end
				end)
				RageUI.Button("Girl Danny", "", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
				if Selected then
					local model = GetHashKey('mp_f_freemode_01')
					RequestModel(model)
					while not HasModelLoaded(model) do
						RequestModel(model)
						Citizen.Wait(0)
					end
					SetPlayerModel(PlayerId(), model)
					SetPedComponentVariation(GetPlayerPed(-1), 0, 0, 0, 2) 
					end
				end)
			RageUI.Button("a_f_m_fatcult_01", "", { RightLabel = "→" }, true, function(Hovered, Active, Selected)
				if Selected then
					local ped = 'a_f_m_fatcult_01'
					local hash = GetHashKey(ped)
					RequestModel(hash)
					while not HasModelLoaded(hash)
							do RequestModel(hash)
								Citizen.Wait(0)
							end	
						SetPlayerModel(PlayerId(), hash)
					end
				end)
				RageUI.Button("a_f_o_soucent_01", "", { RightLabel = "→" }, true, function(Hovered, Active, Selected)
				if Selected then
					local ped = 'a_f_o_soucent_01'
					local hash = GetHashKey(ped)
					RequestModel(hash)
					while not HasModelLoaded(hash)
							do RequestModel(hash)
								Citizen.Wait(0)
							end	
						SetPlayerModel(PlayerId(), hash)
					end
				end)
				RageUI.Button("a_f_m_skidrow_01", "", { RightLabel = "→" }, true, function(Hovered, Active, Selected)
				if Selected then
					local ped = 'a_f_m_skidrow_01'
					local hash = GetHashKey(ped)
					RequestModel(hash)
					while not HasModelLoaded(hash)
							do RequestModel(hash)
								Citizen.Wait(0)
							end	
						SetPlayerModel(PlayerId(), hash)
					end
				end)
				RageUI.Button("a_m_m_og_boss_01", "", { RightLabel = "→" }, true, function(Hovered, Active, Selected)
				if Selected then
					local ped = 'a_m_m_og_boss_01'
					local hash = GetHashKey(ped)
					RequestModel(hash)
					while not HasModelLoaded(hash)
							do RequestModel(hash)
								Citizen.Wait(0)
							end	
						SetPlayerModel(PlayerId(), hash)
					end
				end)
				RageUI.Button("a_m_m_indian_01", "", { RightLabel = "→" }, true, function(Hovered, Active, Selected)
				if Selected then
					local ped = 'a_m_m_indian_01'
					local hash = GetHashKey(ped)
					RequestModel(hash)
					while not HasModelLoaded(hash)
							do RequestModel(hash)
								Citizen.Wait(0)
							end	
						SetPlayerModel(PlayerId(), hash)
					end
				end)
				RageUI.Button("a_m_m_genfat_01", "", { RightLabel = "→" }, true, function(Hovered, Active, Selected)
				if Selected then
					local ped = 'a_m_m_genfat_01'
					local hash = GetHashKey(ped)
					RequestModel(hash)
					while not HasModelLoaded(hash)
							do RequestModel(hash)
								Citizen.Wait(0)
							end	
						SetPlayerModel(PlayerId(), hash)
					end
				end)
				RageUI.Button("a_m_y_business_02", "", { RightLabel = "→" }, true, function(Hovered, Active, Selected)
				if Selected then
					local ped = 'a_m_y_business_02'
					local hash = GetHashKey(ped)
					RequestModel(hash)
					while not HasModelLoaded(hash)
							do RequestModel(hash)
								Citizen.Wait(0)
							end	
						SetPlayerModel(PlayerId(), hash)
					end
				end)
				RageUI.Button("a_m_o_tramp_01", "", { RightLabel = "→" }, true, function(Hovered, Active, Selected)
				if Selected then
					local ped = 'a_m_o_tramp_01'
					local hash = GetHashKey(ped)
					RequestModel(hash)
					while not HasModelLoaded(hash)
							do RequestModel(hash)
								Citizen.Wait(0)
							end	
						SetPlayerModel(PlayerId(), hash)
					end
				end)
				RageUI.Button("a_m_o_genstreet_01", "", { RightLabel = "→" }, true, function(Hovered, Active, Selected)
				if Selected then
					local ped = 'a_m_o_genstreet_01'
					local hash = GetHashKey(ped)
					RequestModel(hash)
					while not HasModelLoaded(hash)
							do RequestModel(hash)
								Citizen.Wait(0)
							end	
						SetPlayerModel(PlayerId(), hash)
					end
				end)
				RageUI.Button("a_m_m_hasjew_01", "", { RightLabel = "→" }, true, function(Hovered, Active, Selected)
				if Selected then
					local ped = 'a_m_m_hasjew_01'
					local hash = GetHashKey(ped)
					RequestModel(hash)
					while not HasModelLoaded(hash)
							do RequestModel(hash)
								Citizen.Wait(0)
							end	
						SetPlayerModel(PlayerId(), hash)
					end
				end)
				RageUI.Button("a_m_m_farmer_01", "", { RightLabel = "→" }, true, function(Hovered, Active, Selected)
				if Selected then
					local ped = 'a_m_m_farmer_01'
					local hash = GetHashKey(ped)
					RequestModel(hash)
					while not HasModelLoaded(hash)
							do RequestModel(hash)
								Citizen.Wait(0)
							end	
						SetPlayerModel(PlayerId(), hash)
					end
				end)
				RageUI.Button("s_f_y_clubbar_01", "", { RightLabel = "→" }, true, function(Hovered, Active, Selected)
				if Selected then
					local ped = 's_f_y_clubbar_01'
					local hash = GetHashKey(ped)
					RequestModel(hash)
					while not HasModelLoaded(hash)
							do RequestModel(hash)
								Citizen.Wait(0)
							end	
						SetPlayerModel(PlayerId(), hash)
					end
				end)
				RageUI.Button("u_m_y_babyd", "", { RightLabel = "→" }, true, function(Hovered, Active, Selected)
				if Selected then
					local ped = 'u_m_y_babyd'
					local hash = GetHashKey(ped)
					RequestModel(hash)
					while not HasModelLoaded(hash)
							do RequestModel(hash)
								Citizen.Wait(0)
							end	
						SetPlayerModel(PlayerId(), hash)
					end
				end)
				RageUI.Button("u_m_y_staggrm_01", "", { RightLabel = "→" }, true, function(Hovered, Active, Selected)
				if Selected then
					local ped = 'u_m_y_staggrm_01'
					local hash = GetHashKey(ped)
					RequestModel(hash)
					while not HasModelLoaded(hash)
							do RequestModel(hash)
								Citizen.Wait(0)
							end	
						SetPlayerModel(PlayerId(), hash)
					end
				end)
				RageUI.Button("u_m_y_prisoner_01", "", { RightLabel = "→" }, true, function(Hovered, Active, Selected)
				if Selected then
					local ped = 'u_m_y_prisoner_01'
					local hash = GetHashKey(ped)
					RequestModel(hash)
					while not HasModelLoaded(hash)
							do RequestModel(hash)
								Citizen.Wait(0)
							end	
						SetPlayerModel(PlayerId(), hash)
					end
				end)
				RageUI.Button("u_m_y_mani", "", { RightLabel = "→" }, true, function(Hovered, Active, Selected)
				if Selected then
					local ped = 'u_m_y_mani'
					local hash = GetHashKey(ped)
					RequestModel(hash)
					while not HasModelLoaded(hash)
							do RequestModel(hash)
								Citizen.Wait(0)
							end	
						SetPlayerModel(PlayerId(), hash)
					end
				end)
				RageUI.Button("csb_stripper_02", "", { RightLabel = "→" }, true, function(Hovered, Active, Selected)
				if Selected then
					local ped = 'csb_stripper_02'
					local hash = GetHashKey(ped)
					RequestModel(hash)
					while not HasModelLoaded(hash)
							do RequestModel(hash)
								Citizen.Wait(0)
							end	
						SetPlayerModel(PlayerId(), hash)
					end
				end)
			end)
		end
	end)

Ismenuopened1a = false

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		local playerCoor, isInMark, currentZo, letSle = GetEntityCoords(PlayerPedId()), false, nil, true

		for k,v in pairs(Ped.respawn) do
			local x,y,z = v[1], v[2], v[3]
			local distan = #(playerCoor - v)

			if distan < 120.0 then
				letSle = false
				if not HasStreamedTextureDictLoaded("clothing") then
					RequestStreamedTextureDict("clothing", true)
					while not HasStreamedTextureDictLoaded("clothing") do
						Wait(1)
					end
				else
					DrawMarker(9, x,y,z, 0.0, 0.0, 0.0, 90.0, 0.0, 0.0, 1.0, 1.0, 1.0, 51, 153, 255, 1.0,false, false, 2, true, "clothing", "clothing", false)
				end
				if distan < 1.5 then
					isInMark, currentZo = true, k
				end
			end
		end
		if (isInMark and not hasAlreadyEnteredMark) or (isInMark and lastZo ~= currentZo) then
			hasAlreadyEnteredMark, lastZo = true, currentZo
			RageUI.Visible(RMenu:Get("PEDSELECTOR", "main"), true)
			Ismenuopened1a = true
		end

		if not isInMark and hasAlreadyEnteredMark then
			RageUI.ActuallyCloseAll()
			RageUI.Visible(RMenu:Get("PEDSELECTOR", "main"), false)
			hasAlreadyEnteredMark = false
			Ismenuopened1a = false
		end

		if letSle then
			Citizen.Wait(500)
		end
	end
end)