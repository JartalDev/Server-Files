--Skrypt By Ruski, Contact Information @Ruski#0001 on Discord, Made For PlanetaRP  Si tradus de radu pt vrp

local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}




local arrst					= false		-- Zostaw na False innaczej bedzie aresztowac na start Skryptu                         --- Astea sa le traduca pula mea
local arest_on				= false		-- Zostaw na False innaczej bedziesz Arresztowany na start Skryptu
 
local variabila3			= 'mp_arrest_paired'	-- Sekcja Katalogu Animcji
local variabila2 			= 'cop_p2_back_left'	-- Animacja Aresztujacego
local variabila1			= 'crook_p2_back_left'	-- Animacja Aresztowanego
--local Ostatnioarest_on		= 0						-- Mozna sie domyslec ;) 



RegisterNetEvent('mita:arrestonway')
AddEventHandler('mita:arrestonway', function(target)             -- sa fac rost de asta in server side
	arest_on = true

	local playerPed = GetPlayerPed(-1)
	local targetPed = GetPlayerPed(GetPlayerFromServerId(target))

	RequestAnimDict(variabila3)

	while not HasAnimDictLoaded(variabila3) do
		Citizen.Wait(10)
	end

	AttachEntityToEntity(GetPlayerPed(-1), targetPed, 11816, -0.1, 0.45, 0.0, 0.0, 0.0, 20.0, false, false, false, false, 20, false)
	TaskPlayAnim(playerPed, variabila3, variabila1, 8.0, -8.0, 5500, 33, 0, false, false, false)

	Citizen.Wait(950)
	DetachEntity(GetPlayerPed(-1), true, false)

	arest_on = false
end) 


RegisterNetEvent('radu:arrest')
AddEventHandler('radu:arrest', function()
	local playerPed = GetPlayerPed(-1)

	RequestAnimDict(variabila3)

	while not HasAnimDictLoaded(variabila3) do
		Citizen.Wait(10)
	end

	TaskPlayAnim(playerPed, variabila3, variabila2, 8.0, -8.0, 5500, 33, 0, false, false, false)

	Citizen.Wait(3000)

	arrst = false

end)