local drugs = {

	-- Weed
	["Collect Weed"] = {
		location = vec3(2943.5905761719,4690.5493164062,51.169910430908),
		action = function()
			FGS_server_callback("FGS-Drugs:WeedCanCollect")
			if plat_hasPlat then
				exports.rprogress:Start("FGS", 7500)
				ClearPedTasks(playerPed)
				local amount = 4
				FGS_server_callback("FGS-Drugs:WeedCollect", amount)
			else
				exports.rprogress:Start("FGS", 10000)
				ClearPedTasks(playerPed)
				local amount = 4
				FGS_server_callback("FGS-Drugs:WeedCollect", amount)
			end
		end
	},
	["Process Weed"] = {
		location = vec3(1945.3312988281,4853.1108398438,45.452812194824),
		action = function()
			FGS_server_callback("FGS-Drugs:WeedCanProcess")
			if plat_hasPlat then
				exports.rprogress:Start("FGS", 7500)
				ClearPedTasks(playerPed)
				local amount = 4
			    FGS_server_callback("FGS-Drugs:WeedProcess", amount)
			else
				exports.rprogress:Start("FGS", 10000)
				ClearPedTasks(playerPed)
				local amount = 4
			    FGS_server_callback("FGS-Drugs:WeedProcess", amount)
			end
		end
		
	},

	-- Ecstasy
	["Collect Frog Legs"] = {
		location = vec3(5337.4912109375,-5263.515625,32.730861663818),
		action = function()
			FGS_server_callback("FGS-Drugs:EcstasyCanCollect")
			if plat_hasPlat then
				exports.rprogress:Start("FGS", 7500)
				ClearPedTasks(playerPed)
				local amount = 4
				FGS_server_callback("FGS-Drugs:EcstasyCollect", amount)
			else
				exports.rprogress:Start("FGS", 10000)
				ClearPedTasks(playerPed)
				local amount = 4
				FGS_server_callback("FGS-Drugs:EcstasyCollect", amount)
			end
		end
	},
	["Process Frog Legs"] = {
		location = vec3(-2083.5766601563,2617.1372070313,3.0839664936066),
		action = function()
			FGS_server_callback("FGS-Drugs:FrogCanProcess")
			if plat_hasPlat then
				exports.rprogress:Start("FGS", 7500)
				ClearPedTasks(playerPed)
				local amount = 4
			    FGS_server_callback("FGS-Drugs:FrogProcess", amount)
			else
				exports.rprogress:Start("FGS", 10000)
				ClearPedTasks(playerPed)
				local amount = 4
			    FGS_server_callback("FGS-Drugs:FrogProcess", amount)
			end
		end
		
	},
	["Process Ecstasy"] = {
		location = vec3(462.25802612305,-3235.4230957031,6.0695581436157),
		action = function()
			FGS_server_callback("FGS-Drugs:EcstasyCanProcess")
			if plat_hasPlat then
				exports.rprogress:Start("FGS", 7500)
				ClearPedTasks(playerPed)
				local amount = 4
			    FGS_server_callback("FGS-Drugs:EcstasyProcess", amount)
			else
				exports.rprogress:Start("FGS", 10000)
				ClearPedTasks(playerPed)
				local amount = 4
			    FGS_server_callback("FGS-Drugs:EcstasyProcess", amount)
			end
		end
		
	},
	-- diamond
	["Collect Diamond"] = {
		location = vec3(409.96615600586,2891.7504882813,41.319911956787),
		action = function()
			FGS_server_callback("FGS-Drugs:DiamondCanCollect")
			if plat_hasPlat then
				exports.rprogress:Start("FGS", 7500)
				ClearPedTasks(playerPed)
				local amount = 4
				FGS_server_callback("FGS-Drugs:DiamondCollect", amount)
			else
				exports.rprogress:Start("FGS", 10000)
				ClearPedTasks(playerPed)
				local amount = 4
				FGS_server_callback("FGS-Drugs:DiamondCollect", amount)
			end
		end	
	},

	["Process Diamond"] = {
		location = vec3(2665.3227539063,2845.0732421875,39.56840133667),
		action = function()
		    FGS_server_callback("FGS-Drugs:DiamondCanProcess")
			if plat_hasPlat then
				exports.rprogress:Start("FGS", 7500)
				ClearPedTasks(playerPed)
				local amount = 4
			    FGS_server_callback("FGS-Drugs:DiamondProcess", amount)
			else
				exports.rprogress:Start("FGS", 10000)
				ClearPedTasks(playerPed)
				local amount = 4
			    FGS_server_callback("FGS-Drugs:DiamondProcess", amount)
            end
		end
	},

	-- Cocaine
	["Collect Cocaine"] = {
		location = vec3(1467.2235107422,1112.7380371094,114.33924865723),
		action = function()
			FGS_server_callback("FGS-Drugs:CokeCanCollect")
			if plat_hasPlat then
				exports.rprogress:Start("FGS", 7500)
				ClearPedTasks(playerPed)
				local amount = 4
				FGS_server_callback("FGS-Drugs:CokeCollect", amount)
			else
				exports.rprogress:Start("FGS", 10000)
				ClearPedTasks(playerPed)
				local amount = 4
				FGS_server_callback("FGS-Drugs:CokeCollect", amount)
            end
		end	
	},

	["Process Cocaine"] = {
		location = vec3(-291.93908691406,2524.5732421875,74.659271240234),
	    action = function()
		    FGS_server_callback("FGS-Drugs:CokeCanProcess")
			if plat_hasPlat then
				exports.rprogress:Start("FGS", 7500)
				ClearPedTasks(playerPed)
				local amount = 4
				FGS_server_callback("FGS-Drugs:CocaineProcess", amount)
			else
				exports.rprogress:Start("FGS", 10000)
				ClearPedTasks(playerPed)
				local amount = 4
				FGS_server_callback("FGS-Drugs:CocaineProcess", amount)
            end
	    end
		
	},
	
	-- Meth
	["Collect Meth"] = {
		location = vec3(422.35244750977,6465.5004882812,28.819103240967),
		action = function()
			FGS_server_callback("FGS-Drugs:MethCanCollect")
			if plat_hasPlat then
				exports.rprogress:Start("FGS", 7500)
				ClearPedTasks(playerPed)
				local amount = 4
				FGS_server_callback("FGS-Drugs:MethCollect", amount)
			else
				exports.rprogress:Start("FGS", 10000)
				ClearPedTasks(playerPed)
				local amount = 4
				FGS_server_callback("FGS-Drugs:MethCollect", amount)
            end
		end	
	},
	
	["Process Meth"] = {
		location = vec3(2338.5649414062,2570.6274414062,47.725009918213),
		action = function()
			FGS_server_callback("FGS-Drugs:MethCanProcess")
			if plat_hasPlat then
				exports.rprogress:Start("FGS", 7500)
				ClearPedTasks(playerPed)
				local amount = 4
				FGS_server_callback("FGS-Drugs:MethProcess", amount)
			else
				exports.rprogress:Start("FGS", 10000)
				ClearPedTasks(playerPed)
				local amount = 4
				FGS_server_callback("FGS-Drugs:MethProcess", amount)
            end
		end
		
	},

	-- HEROIN
	["Collect Heroin"] = {
		location = vec3(-1907.5427246094,2117.8500976562,127.10972595215),
		action = function()
			FGS_server_callback("FGS-Drugs:HeroinCanCollect")
			if plat_hasPlat then
				exports.rprogress:Start("FGS", 7500)
				ClearPedTasks(playerPed)
				local amount = 4
				FGS_server_callback("FGS-Drugs:HeroinCollect", amount)
			else
				exports.rprogress:Start("FGS", 10000)
				ClearPedTasks(playerPed)
				local amount = 4
				FGS_server_callback("FGS-Drugs:HeroinCollect", amount)
            end
		end	
	},

	["Process Heroin"] = {
		location = vec3(2432.4343261719,4970.1743164062,42.347618103027),
		action = function()
			FGS_server_callback("FGS-Drugs:HeroinCanProcess")
			if plat_hasPlat then
				exports.rprogress:Start("FGS", 7500)
				ClearPedTasks(playerPed)
				local amount = 4
				FGS_server_callback("FGS-Drugs:HeroinProcess", amount)
			else
				exports.rprogress:Start("FGS", 10000)
				ClearPedTasks(playerPed)
				local amount = 4
				FGS_server_callback("FGS-Drugs:HeroinProcess", amount)
            end
		end	
	},
}

local cooldown = false
  
--Create Cooldown
--Citizen.CreateThread(function()
--	function FGS_Drugs_Cooldown()
--		
--	end
--end)

RegisterNetEvent("drugs:animation")
AddEventHandler("drugs:animation", function(task)
	local playerPed = PlayerPedId()
	TaskStartScenarioInPlace(playerPed, task, 0, true)
end)


Citizen.CreateThread(function()
	while true do 
		Citizen.Wait(10)
		local PlyCoords = GetEntityCoords(PlayerPedId())
		for k,v in pairs(drugs) do 
			if #(PlyCoords - v.location) <= 100.0 then 
				alert("Press ~INPUT_VEH_HORN~ to " .. k)
				if IsControlJustPressed(0, 51) then 
					v.action()
				end
			end
		end
	end
end)

local impacts = 0

RegisterNetEvent("Animation:pickaxe")
AddEventHandler("Animation:pickaxe", function()
    Citizen.CreateThread(function()
        while impacts < 4 do
            Citizen.Wait(1)
		local ped = PlayerPedId()	
            RequestAnimDict("melee@large_wpn@streamed_core")
            Citizen.Wait(100)
            TaskPlayAnim((ped), 'melee@large_wpn@streamed_core', 'ground_attack_on_spot', 8.0, 8.0, -1, 80, 0, 0, 0, 0)
            if impacts == 0 then
                pickaxe = CreateObject(GetHashKey("prop_tool_pickaxe"), 0, 0, 0, true, true, true) 
				AttachEntityToEntity(pickaxe, ped, GetPedBoneIndex(ped, 57005), 0.18, -0.02, -0.02, 350.0, 100.00, 140.0, true, true, false, true, 1, true)
            end  
            Citizen.Wait(1750)
            ClearPedTasks(ped)
            impacts = impacts+1
            if impacts == 4 then
                DetachEntity(pickaxe, 1, true)
                DeleteEntity(pickaxe)
                DeleteObject(pickaxe)
                impacts = 0
                break
            end        
        end
    end)
end)


RegisterNetEvent("Animation:cleaning")
AddEventHandler("Animation:cleaning", function()
	local ped = PlayerPedId()
	RequestAnimDict("amb@prop_human_bum_bin@idle_a")
	washingActive = true
	Citizen.Wait(100)
	FreezeEntityPosition(ped, true)
	TaskPlayAnim((ped), 'amb@prop_human_bum_bin@idle_a', 'idle_a', 8.0, 8.0, -1, 81, 0, 0, 0, 0)
	Citizen.Wait(15900)
	ClearPedTasks(ped)
	FreezeEntityPosition(ped, false)
end)

function CreateBlipCircleDrugs(coords, text, radius, color, sprite)
	local blip = AddBlipForRadius(coords, radius)
	SetBlipHighDetail(blip, true)
	SetBlipColour(blip, 1)
	SetBlipAlpha (blip, 128)
	blip = AddBlipForCoord(coords)
	SetBlipHighDetail(blip, true)
	SetBlipSprite (blip, sprite)
	SetBlipScale  (blip, 0.6)
	SetBlipColour (blip, color)
	SetBlipAsShortRange(blip, true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString(text)
	EndTextCommandSetBlipName(blip)
end
