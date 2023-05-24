local cashDisplay = 0
local bankDisplay = 0
local permDisplay = 0

function getMoneyStringFormatted(cashString)
	local i, j, minus, int, fraction = tostring(cashString):find('([-]?)(%d+)([.]?%d*)')

	-- reverse the int-string and append a comma to all blocks of 3 digits
	int = int:reverse():gsub("(%d%d%d)", "%1,")
  
	-- reverse the int-string back remove an optional comma and put the 
	-- optional minus and fractional part back
	return minus .. int:reverse():gsub("^,", "") .. fraction 
end

RegisterNetEvent("FGS:CashBankClient")
AddEventHandler("FGS:CashBankClient",function(bank,cash,userid)
	local cashString = tostring(cash)
    local bankString = tostring(bank)
	cashDisplay = getMoneyStringFormatted(cashString)
    bankDisplay = getMoneyStringFormatted(bankString)
    if permDisplay ~= nil then 
        permDisplay = userid
    end
end)

local playername = "Player"
local armour = "100"
local healt = "200"
local showhud = true
local IsHidden = false 
Citizen.CreateThread(function()
    while true do
        local sleep = 1000
        local topLeftAnchor = getMinimapAnchor()
        if showhud then
            IsHidden = false
            SendNUIMessage({
                action = "show",
                armor = armour,
                health = healt,
                cash = "£"..cashDisplay,
                bank = "£"..bankDisplay,
                name = permDisplay.." | "..playername,
                topLeftAnchor = topLeftAnchor[1]+topLeftAnchor[3],
                yAnchor = topLeftAnchor[2],
            })
            DisplayRadar(true)
        else
            sleep = 0
            if not IsHidden then 
                SendNUIMessage({
                    action = "hide",
                    armor = armour,
                    health = healt,
                    cash = "£"..cashDisplay,
                    bank = "£"..bankDisplay,
                    name = playername,
                    topLeftAnchor = topLeftAnchor[1]+topLeftAnchor[3],
                    yAnchor = topLeftAnchor[2],
                })
                IsHidden = true 
            end
            DisplayRadar(false)
        end
        Citizen.Wait(sleep)
    end
end)

function getMinimapAnchor()
  SetScriptGfxAlign(string.byte('L'), string.byte('B'))
  local minimapTopX, minimapTopY = GetScriptGfxPosition(-0.0045, 0.002 + (-0.188888))
  ResetScriptGfxAlign()
  local w, h = GetActiveScreenResolution()
  local aspect_ratio = GetAspectRatio(0)
  local xscale = 1.0 / w
  local yscale = 1.0 / h
  local Minimap = {}
  local width = xscale * (w / (4 * aspect_ratio))
  return { w * 2 * minimapTopX, (h * minimapTopY)+((width*0.61)*h), width * w}
end

local function GetMinimapAnchor()
  local safezone = GetSafeZoneSize()
  local safezone_x = 1.0 / 20.0
  local safezone_y = 1.0 / 20.0
  local aspect_ratio = GetAspectRatio(0)
  local res_x, res_y = GetActiveScreenResolution()
  local xscale = 1.0 / res_x
  local yscale = 1.0 / res_y
  local Minimap = {}
  Minimap.Width = xscale * (res_x / (4 * aspect_ratio))
  Minimap.height = yscale * (res_y / 5.674)
  Minimap.Left_x = xscale * (res_x * (safezone_x * ((math.abs(safezone - 1.0)) * 10)))
  Minimap.Bottom_y = 1.0 - yscale * (res_y * (safezone_y * ((math.abs(safezone - 1.0)) * 10)))
  Minimap.right_x = Minimap.Left_x + Minimap.Width
  Minimap.top_y = Minimap.Bottom_y - Minimap.height
  Minimap.x = Minimap.Left_x
  Minimap.y = Minimap.top_y
  Minimap.xunit = xscale
  Minimap.yunit = yscale
  return Minimap
end


RegisterCommand('showhud',function()
    showhud = not showhud
end)

Citizen.CreateThread(function()
    local minimap = RequestScaleformMovie("minimap")
    SetBigmapActive(true, false)
    Wait(0)
    SetBigmapActive(false, false)
    while true do
        Wait(0)
        BeginScaleformMovieMethod(minimap, "SETUP_HEALTH_ARMOUR")
        ScaleformMovieMethodAddParamInt(3)
        EndScaleformMovieMethod()
    end
end)




local function drawRct(x,y,Width,height,r,g,b,a)
    DrawRect(x+Width/2,y+height/2,Width,height,r,g,b,a,0)
end


Citizen.CreateThread(function()
    while true do
        TriggerServerEvent('FGS:BankCash')
        local ped = PlayerPedId()
        playername = GetPlayerName(PlayerId())
        armour = GetPedArmour(ped)
        healt = (GetEntityHealth(ped)-100)
        Citizen.Wait(1000)
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if showhud then 
            C_Hud()
        end
    end
end)

function C_Hud()
  local userid = PlayerPedId()
  local UI = GetMinimapAnchor()
  local health = (GetEntityHealth(userid) - 100) / 100.0
  if health < 0 then health = 0.0 end
  if health == 0.98 then health = 1.0 end
  local armor = GetPedArmour(userid) / 100.0
  if armor == 95 / 100.0 then armor = 100 / 100.0 end

  drawRct(UI.Left_x, UI.Bottom_y - 0.017, UI.Width, 0.028, 0, 0, 0, 50) -- [Transparent Backround]
  drawRct(UI.Left_x + 0.001 , UI.Bottom_y - 0.015, (UI.Width -0.002) * health , 0.009, 15, 252, 3 , 250) -- [Health Bat]
  drawRct(UI.Left_x + 0.001 , UI.Bottom_y - 0.002, (UI.Width - 0.002) * armor , 0.009, 0, 183, 255, 250) -- [Armour Bar]
end


RegisterNetEvent("FGS:showhud", function()
    showhud = not showhud
end)