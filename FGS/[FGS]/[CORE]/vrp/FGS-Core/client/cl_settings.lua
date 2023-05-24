RMenu.Add('SettingsMenu', 'MainMenu', RageUI.CreateMenu("", "FGS Settings Menu", 1300,100,"settings","settings")) 


local statusr = "~r~[Off]"
local hitsounds = false

local statusc = "~r~[Off]"
local compass = false

local statusT = "~r~[Off]"
local toggle = false

local df = {
    {"10%", 0.1},
    {"20%", 0.2},
    {"30%", 0.3},
    {"40%", 0.4},
    {"50%", 0.5},
    {"60%", 0.6},
    {"70%", 0.7},
    {"80%", 0.8},
    {"90%", 0.9},
    {"100%", 1.0},
    {"150%", 1.5},
    {"200%", 2.0},
    {"250%", 2.5},
    {"300%", 3.0},
    {"350%", 3.5},
    {"400%", 4.0},
    {"450%", 4.5},
    {"500%", 5.0},
    {"600%", 6.0},
    {"700%", 7.0},
    {"800%", 8.0},
    {"900%", 9.0},
    {"1000%", 10.0},
}

local d = {"10%", "20%", "30%", "40%", "50%", "60%", "70%", "80%", "90%", "100%", "150%", "200%", "250%", "300%", "350%", "400%", "450%", "500%", "600%", "700%", "800%", "900%", "1000%"}
local dts = 9

RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('SettingsMenu', 'MainMenu')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = true}, function()
            RageUI.Button("Toggle Rust Hit Sounds " .. statusr, nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                if Selected then
                    if not hitsounds then 
                        statusr = "~g~[On]"
                        ExecuteCommand("hs")
                        hitsounds = true
                    else 
                        ExecuteCommand("hs")
                        statusr = "~r~[Off]"
                        hitsounds = false
                    end
                end
            end)
    
            RageUI.Button("Toggle Compass " .. statusc, nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                if Selected then
                    if not compass then 
                        statusc = "~g~[On]"
                        ExecuteCommand("compass")
                        compass = true
                    else 
                        ExecuteCommand("compass")
                        statusc = "~r~[Off]"
                        compass = false
                    end
                end
            end)

            RageUI.Checkbox("Street Names", "Enable / Disable Street Names", streetnames, { Style = RageUI.CheckboxStyle.Tick }, function(Hovered, Selected, Active, Checked)
                streetnames = Checked;
            end)


            RageUI.List("Modify Render Distance", d, dts, nil, {}, true, function(a,b,c,d)
                if c then
    
                end
    
                dts = d
            end)

       end)
    end
end)

RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('adminmenu', 'settings')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = true}, function()
            RageUI.Button("Toggle Rust Hit Sounds " .. statusr, nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                if Selected then
                    if not hitsounds then 
                        statusr = "~g~[On]"
                        ExecuteCommand("hs")
                        hitsounds = true
                    else 
                        ExecuteCommand("hs")
                        statusr = "~r~[Off]"
                        hitsounds = false
                    end
                end
            end)
    
            RageUI.Button("Toggle Compass " .. statusc, nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                if Selected then
                    if not compass then 
                        statusc = "~g~[On]"
                        ExecuteCommand("compass")
                        compass = true
                    else 
                        ExecuteCommand("compass")
                        statusc = "~r~[Off]"
                        compass = false
                    end
                end
            end)

            RageUI.Checkbox("Street Names", "Enable / Disable Street Names", streetnames, { Style = RageUI.CheckboxStyle.Tick }, function(Hovered, Selected, Active, Checked)
                streetnames = Checked;
            end)

    
            RageUI.List("Modify Render Distance", d, dts, nil, {}, true, function(a,b,c,d)
                if c then
    
                end
    
                dts = d
            end)


       end)
    end
end)

RegisterNetEvent('FGS:OpenSettingsMenu')
AddEventHandler('FGS:OpenSettingsMenu', function(admin)
    if not admin then
        RageUI.Visible(RMenu:Get("adminmenu", "main"), false)
        RageUI.Visible(RMenu:Get("SettingsMenu", "MainMenu"), true)
    else
        --
    end
end)

RegisterCommand('opensettingsmenu',function()
    TriggerServerEvent('FGS:OpenSettings')
end)

RegisterKeyMapping('opensettingsmenu', 'Opens the Settings menu', 'keyboard', 'F2')

Citizen.CreateThread(function() 
    while true do
        Citizen.InvokeNative(0xA76359FC80B2438E, df[dts][2])      
                
        Citizen.Wait(0)
    end
end)

Citizen.CreateThread(function()
    while true do
        CheckPlayerPosition()
        Citizen.Wait(1000)
    end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if IsControlJustReleased(0, 20) then -- 20 is z
			Citizen.Wait(25)
			if not isRadarExtended then
				SetRadarBigmapEnabled(true, false)
				LastGameTimer = GetGameTimer()
				isRadarExtended = true
			elseif isRadarExtended then
				SetRadarBigmapEnabled(false, false)
				LastGameTimer = 0
				isRadarExtended = false
			end
		end
	end
end)

Citizen.CreateThread(function()
    while true do
        while streetnames do
            disableHud()
            local UI = GetMinimapAnchor()

            drawTxt(UI.Left_x + 0.003 , UI.Bottom_y - 0.227 , 0.4, "~b~"..Zone.." / ~w~"..GetStreetNameFromHashKey(rua), 255, 255, 255, 255, 0) -- Street
            Citizen.Wait(1)
        end
        Citizen.Wait(1)
    end
end)
CreateThread(function()
    while true do
        Wait(0)
        SetPlayerLockon(PlayerId(), false)
        SetPedConfigFlag(PlayerPedId(), 149, true)
        SetPedConfigFlag(PlayerPedId(), 438, true)
    end
end)
 
function CheckPlayerPosition()
    pos = GetEntityCoords(PlayerPedId())
    rua, cross = GetStreetNameAtCoord(pos.x, pos.y, pos.z)
    Zone = GetLabelText(GetNameOfZone(pos.x, pos.y, pos.z))
end
 
function drawRct(x,y,Width,height,r,g,b,a)
   DrawRect(x+Width/2,y+height/2,Width,height,r,g,b,a, 0)
end
 
function drawTxt(x,y,scale,text,r,g,b,a,font)
    SetTextFont(font)
    SetTextScale(scale,scale)
    SetTextColour(r,g,b,a)
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x,y)
end
 
function disableHud()
    HideHudComponentThisFrame(6)
    HideHudComponentThisFrame(7)   
    HideHudComponentThisFrame(8)   
    HideHudComponentThisFrame(9)
end
 
function GetMinimapAnchor()
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

local function Bool(num) 
    return num == 1 or num == true
end