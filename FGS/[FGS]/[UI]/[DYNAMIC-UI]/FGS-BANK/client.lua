local BANKS_List = {
	{ name="Royal Bank Of Scotland", id=272, x=150.2, y=-1040.2, z=29.3 },
	{ name="Halifax Bank", id=272, x=-1212.9, y=-330.8, z=37.7 },
	{ name="Santander Bank", id=272, x=-2962.5, y=482.6, z=15.7 },
	{ name="HSBC Bank", id=272, x=-112.2, y=6469.2, z=31.6 },
	{ name="Barclays Bank", id=272, x=314.1, y=-278.6, z=54.1 },
	{ name="NatWest Bank", id=272, x=-351.5, y=-49.5, z=49.0 },
	{ name="Lloyds Bank", id=272, x=241.7, y=220.7, z=106.2 },
	{ name="Bank Of FGS", id=272, x=1175.0, y=2706.6, z=38.0 },
	{ name="Bank Of CP", id=272, x=4476.9936523438, y=-4464.435546875, z=4.2520804405212 }
}

local ATMS_List = {
	{name="ATM", x=-4475.6293945313, y=-4469.2314453125, z=4.2343797683716},
	{name="ATM", x=-386.733, y=6045.953, z=31.501},
	{name="ATM", x=-284.037, y=6224.385, z=31.187},
	{name="ATM", x=-284.037, y=6224.385, z=31.187},
	{name="ATM", x=-135.165, y=6365.738, z=31.101},
	{name="ATM", x=-110.753, y=6467.703, z=31.784},
	{name="ATM", x=-94.9690, y=6455.301, z=31.784},
	{name="ATM", x=155.4300, y=6641.991, z=31.784},
	{name="ATM", x=174.6720, y=6637.218, z=31.784},
	{name="ATM", x=1703.138, y=6426.783, z=32.730},
	{name="ATM", x=1735.114, y=6411.035, z=35.164},
	{name="ATM", x=1702.842, y=4933.593, z=42.051},
	{name="ATM", x=1967.333, y=3744.293, z=32.272},
	{name="ATM", x=1821.917, y=3683.483, z=34.244},
	{name="ATM", x=1174.532, y=2705.278, z=38.027},
	{name="ATM", x=540.0420, y=2671.007, z=42.177},
	{name="ATM", x=2564.399, y=2585.100, z=38.016},
	{name="ATM", x=2558.683, y=349.6010, z=108.050},
	{name="ATM", x=2558.051, y=389.4817, z=108.660},
	{name="ATM", x=1077.692, y=-775.796, z=58.218},
	{name="ATM", x=1139.018, y=-469.886, z=66.789},
	{name="ATM", x=1168.975, y=-457.241, z=66.641},
	{name="ATM", x=1153.884, y=-326.540, z=69.245},
	{name="ATM", x=381.2827, y=323.2518, z=103.270},
	{name="ATM", x=236.4638, y=217.4718, z=106.840},
	{name="ATM", x=265.0043, y=212.1717, z=106.780},
	{name="ATM", x=285.2029, y=143.5690, z=104.970},
	{name="ATM", x=157.7698, y=233.5450, z=106.450},
	{name="ATM", x=-164.568, y=233.5066, z=94.919},
	{name="ATM", x=-1827.04, y=785.5159, z=138.020},
	{name="ATM", x=-1409.39, y=-99.2603, z=52.473},
	{name="ATM", x=-1205.35, y=-325.579, z=37.870},
	{name="ATM", x=-1215.64, y=-332.231, z=37.881},
	{name="ATM", x=-2072.41, y=-316.959, z=13.345},
	{name="ATM", x=-2975.72, y=379.7737, z=14.992},
	{name="ATM", x=-2962.60, y=482.1914, z=15.762},
	{name="ATM", x=-2955.70, y=488.7218, z=15.486},
	{name="ATM", x=-3044.22, y=595.2429, z=7.595},
	{name="ATM", x=-3144.13, y=1127.415, z=20.868},
	{name="ATM", x=-3241.10, y=996.6881, z=12.500},
	{name="ATM", x=-3241.11, y=1009.152, z=12.877},
	{name="ATM", x=-1305.40, y=-706.240, z=25.352},
	{name="ATM", x=-538.225, y=-854.423, z=29.234},
	{name="ATM", x=-711.156, y=-818.958, z=23.768},
	{name="ATM", x=-717.614, y=-915.880, z=19.268},
	{name="ATM", x=-526.566, y=-1222.90, z=18.434},
	{name="ATM", x=-256.831, y=-719.646, z=33.444},
	{name="ATM", x=-203.548, y=-861.588, z=30.205},
	{name="ATM", x=112.4102, y=-776.162, z=31.427},
	{name="ATM", x=112.9290, y=-818.710, z=31.386},
	{name="ATM", x=119.9000, y=-883.826, z=31.191},
	{name="ATM", x=149.4551, y=-1038.95, z=29.366},
	{name="ATM", x=-846.304, y=-340.402, z=38.687},
	{name="ATM", x=-1204.35, y=-324.391, z=37.877},
	{name="ATM", x=-1216.27, y=-331.461, z=37.773},
	{name="ATM", x=-56.1935, y=-1752.53, z=29.452},
	{name="ATM", x=-261.692, y=-2012.64, z=30.121},
	{name="ATM", x=-273.001, y=-2025.60, z=30.197},
	{name="ATM", x=314.187, y=-278.621, z=54.170},
	{name="ATM", x=-351.534, y=-49.529, z=49.042},
	{name="ATM", x=24.589, y=-946.056, z=29.357},
	{name="ATM", x=-254.112, y=-692.483, z=33.616},
	{name="ATM", x=-1570.197, y=-546.651, z=34.955},
	{name="ATM", x=-1415.909, y=-211.825, z=46.500},
	{name="ATM", x=-1430.112, y=-211.014, z=46.500},
	{name="ATM", x=33.232, y=-1347.849, z=29.497},
	{name="ATM", x=129.216, y=-1292.347, z=29.269},
	{name="ATM", x=287.645, y=-1282.646, z=29.659},
	{name="ATM", x=289.012, y=-1256.545, z=29.440},
	{name="ATM", x=295.839, y=-895.640, z=29.217},
	{name="ATM", x=1686.753, y=4815.809, z=42.008},
	{name="ATM", x=-302.408, y=-829.945, z=32.417},
	{name="ATM", x=5.134, y=-919.949, z=29.557},
	{name="ATM", x=348.14, y=-1397.87, z=32.52},
	{name="ATM", x=315.15, y=-593.81, z=43.0},
	{name="ATM", x=-866.99, y=-187.11, z=37.83},
	{name="ATM", x=1094.4755859375, y=244.0422668457,z=-50.440776824951},
	{name="ATM", x=-2172.5615234375, y=5196.3920898438,z=-16.849948883057},
	
	{name="ATM", x=-549.56884765625, y=-204.35092163086,z=38.223083496094}, -- licence
	{name="ATM", x=146.87498474121, y=-1035.5181884766,z=29.343891143799}, -- l bank
	
    {name="ATM", x=-2171.7548828125, y=5196.5864257813, z=16.824548721313}
	
	
}

Citizen.CreateThread(function()
    for k,v in ipairs(BANKS_List)do
    local blip = AddBlipForCoord(v.x, v.y, v.z)
    SetBlipSprite(blip, v.id)
    SetBlipScale(blip, 0.6)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(tostring(v.name))
    EndTextCommandSetBlipName(blip)
    end
end)

inMenu			= false
local bankMenu	= true
local atbank	= false

function IsPlayerNearBank()
	local player = GetPlayerPed(-1)
	local playerloc = GetEntityCoords(player, 0)
	
	for _, search in pairs(BANKS_List) do
		local distance = GetDistanceBetweenCoords(search.x, search.y, search.z, playerloc['x'], playerloc['y'], playerloc['z'], true)
		
		if distance <= 2.5 then
			return true
		end
	end
end

function IsPlayerNearATM()
	local player = GetPlayerPed(-1)
	local playerloc = GetEntityCoords(player, 0)
	
	for _, search in pairs(ATMS_List) do
		local distance = GetDistanceBetweenCoords(search.x, search.y, search.z, playerloc['x'], playerloc['y'], playerloc['z'], true)
		
		if distance <= 2.5 then
			return true
		end
	end
end

function PlayCardAnimation()
	local dict = "amb@prop_human_atm@male@enter"
	RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
		Citizen.Wait(50)
	end
	TaskPlayAnim(GetPlayerPed(-1), dict, "enter", 1.5, -8.0, 2000, 1, 0, false, false, false)
end

function DisplayHelpText(text)
	SetTextComponentFormat("STRING")
	AddTextComponentString(text)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

Citizen.CreateThread(function()
	wait = 1769;
while true do
	wait = 1769;
		if IsPlayerNearBank() or IsPlayerNearATM() then
			DisplayHelpText("Press ~b~E ~w~to login to your ~b~bank account");
				wait = 0;
			if IsControlJustPressed(1, 38) then
				PlayCardAnimation();
				Citizen.Wait(2000);
				TriggerEvent("FGS-BANK-CORE:show");
				inMenu = true;
			end
		end
			
		if IsControlJustPressed(1, 322) then
			inMenu = false
			SendNUIMessage({ display = false })
			SetNuiFocus(false, false)
		end
		Citizen.Wait(wait)
	end
end)


RegisterNetEvent("FGS-BANK-CORE:show")
AddEventHandler("FGS-BANK-CORE:show", function()
	SendNUIMessage({
		display = true
	})
    TriggerServerEvent("FGS-BANK-CORE:checkBalance")
	SetNuiFocus(true, true)
end)

RegisterNetEvent("FGS-BANK-CORE:showNotification")
AddEventHandler("FGS-BANK-CORE:showNotification", function(type, message)
    SendNUIMessage({
        name = 'addNotification',
        type = type,
        message = message
    })
end)

RegisterNetEvent("FGS-BANK-CORE:updateBalance")
AddEventHandler("FGS-BANK-CORE:updateBalance", function(totalBalance, name, id)
    SendNUIMessage({type = "UpdateBalance", totalbalance = "£"..totalBalance, name = name, id = id})
end)

RegisterNUICallback('FGS-depositMoney', function(data)
    TriggerServerEvent("FGS-BANK-CORE:depositMoney", tonumber(data.amountDeposit))
    TriggerServerEvent("FGS-BANK-CORE:checkBalance")
end)

RegisterNUICallback('FGS-withdrawMoney', function(data)
    TriggerServerEvent("FGS-BANK-CORE:withdrawMoney", tonumber(data.amountWithdraw))
    TriggerServerEvent("FGS-BANK-CORE:checkBalance")
end)

RegisterNUICallback('FGS-transferMoney', function(data)
    TriggerServerEvent("FGS-BANK-CORE:transferMoney", data.receiver, data.amountTransfer)
    TriggerServerEvent("FGS-BANK-CORE:checkBalance")
end)


RegisterNUICallback('focusOff', function(data, cb)
	SetNuiFocus(false, false)
end)