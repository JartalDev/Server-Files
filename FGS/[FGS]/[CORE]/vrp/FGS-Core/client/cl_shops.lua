
local shopitems = {}
local ShopLocation = {
    {373.800, 325.800, 102.5},
    {2557.40, 382.200, 107.6},
    {-3038.9, 585.900, 6.900},
    {-3241.9, 1001.40, 11.80},
    {547.400, 2671.70, 41.10},
    {1961.40, 3740.60, 31.30},
    {2678.90, 3280.60, 54.20},
    {1729.20, 6414.10, 34.00},
    {1135.80, -982.20, 45.40},
    {-1222.9, -906.90, 11.30},
    {-1487.5, -379.10, 39.10},
    {-2968.2, 390.900, 14.00},
    {1166.00, 2708.90, 37.10},
    {1392.50, 3604.60, 33.90},
    {127.800, -1284.7, 28.20}, 
    {-1393.4, -606.60, 29.30}, 
    {-559.90, 287.000, 81.10}, 
    {-48.500, -1757.5, 28.40},
    {1163.30, -323.80, 68.20},
    {-707.50, -914.20, 18.20},
    {-1820.5, 792.500, 137.1},
    {1698.30, 4924.40, 41.00},
    {12.860950469971,-1600.1079101562,29.375982284546}
}
local NearShop = false
local HasEnteredShop = false


RMenu.Add('vRPSHOPS', 'main', RageUI.CreateMenu("", "~b~ Items",1250,100, "shop", "shop"))
RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('vRPSHOPS', 'main')) then
        RageUI.DrawContent({ header = true, glare = true, instructionalButton = true}, function()

            for k,v in pairs(shopitems) do 
                RageUI.Button(v[2], v[3], {RightLabel = "£" .. comma_value(v[4])}, true, function(Hovered, Active, Selected)
                    if Selected then
                        TriggerServerEvent('Shop:brought', v[1], v[4])
                    end
                end)
            end

        end)
    end
end, 1)



RegisterNetEvent("Shop:items")
AddEventHandler("Shop:items", function(items)
    shopitems = items
end)


local function openshop()
    TriggerServerEvent("Shop:refresh")
    RageUI.Visible(RMenu:Get('vRPSHOPS', 'main'), true)
end

local function closeshop()
    RageUI.ActuallyCloseAll()
    RageUI.Visible(RMenu:Get('vRPSHOPS', 'main'), false)
end

local MenuOpen = false;
local inMarker = false;
Citizen.CreateThread(function()
    while true do 
        inMarker = false
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)
        for i,v in pairs(ShopLocation) do 
            local x, y, z = v[1], v[2], v[3]
            if #(coords - vec3(x,y,z)) <= 2.0 then
                inMarker = true 
                break
            end    
        end
        if not MenuOpen and inMarker then 
            MenuOpen = true 
            openshop()
            print("test")
        end
        if MenuOpen and not inMarker then 
            MenuOpen = false 
            closeshop()
        end
        Wait(250)
    end
end)

RegisterNetEvent("FGS:Drunk")
AddEventHandler("FGS:Drunk", function()
    local ped = PlayerPedId()
    DoScreenFadeOut(1000)
    Citizen.Wait(1000)
    SetTimecycleModifier("drug_wobbly")
    SetPedMotionBlur(ped, true)
    SetPedMovementClipset(ped, "MOVE_M@DRUNK@MODERATEDRUNK_HEAD_UP", true)
    SetPedIsDrunk(ped, true)
    SetPedAccuracy(ped, 0)
    DoScreenFadeIn(1000)            
    Citizen.Wait(120000)
    DoScreenFadeOut(1000)
    Citizen.Wait(1000)
    DoScreenFadeIn(1000)
    ClearTimecycleModifier()
    ResetScenarioTypesEnabled()
    ResetPedMovementClipset(ped, 0)
    SetPedIsDrunk(ped, false)
    SetPedMotionBlur(ped, false)
end)

function comma_value(amount)
    local formatted = amount
    while true do  
        formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
        if (k==0) then
            break
        end
    end
    return formatted
end