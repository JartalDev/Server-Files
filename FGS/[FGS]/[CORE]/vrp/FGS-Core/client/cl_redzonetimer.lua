local inRedZone = false
local timeLeft = 30
local currentRedZone = nil
local scaleform = RequestScaleformMovie("MP_BIG_MESSAGE_FREEMODE")

zones = {
    {name = "Rebel", coords = vector3(1457.4250488281,6308.064453125,63.868026733398), blipWidth = 130.0, blipColour = 1},
    {name = "Heroin", coords = vector3(3529.4702148438,3726.9321289062,36.473175048828), blipWidth = 220.0, blipColour = 1},
    {name = "LSD", coords = vector3(2551.5266113281,-356.72958374023,93.11311340332), blipWidth = 125.0, blipColour = 1},
    {name = "Largearms1", coords = vector3(5131.583984375,-4620.9389648438,2.2606110572815), blipWidth = 110.0, blipColour = 1},
    {name = "Largearms2", coords = vector3(-1115.0303955078,4935.8471679688,218.36589050293), blipWidth = 110.0, blipColour = 1},
   -- {name = "Coke", coords = vector3(123.57997131348,-1294.9934082031,29.26953125), blipWidth = 25.0, blipColour = 1},
  --  {name = "Meth", coords = vector3(123.57997131348,-1294.9934082031,29.26953125), blipWidth = 100.0, blipColour = 1},   
}

Citizen.CreateThread(function()
    for k, v in pairs(zones) do
        local blip = AddBlipForRadius(v.coords, v.blipWidth)
        SetBlipHighDetail(blip, true)
        SetBlipColour(blip, v.blipColour)
        SetBlipAlpha(blip, 128)
    end

    while true do
        Citizen.Wait(0)
        for k, v in pairs(zones) do
            
            if isInArea(v.coords, v.blipWidth) and not inRedZone then
                timeLeft = 30
                inRedZone = true
                currentRedZone = k
            end

            if isInArea(v.coords, v.blipWidth) == false and inRedZone and currentRedZone == k then
                if timeLeft == 0 then
                    inRedZone = false
                else
                    TaskGoStraightToCoord(PlayerPedId(), v.coords, 2.0, 100.0, 307.0, 1.0)
                    if HasScaleformMovieLoaded(scaleform) then
                        PushScaleformMovieFunction(scaleform, "SHOW_SHARD_WASTED_MP_MESSAGE")
                        BeginTextComponent("STRING")
                        AddTextComponentString("~r~GET BACK IN THE REDZONE!")
                        EndTextComponent()
                        PopScaleformMovieFunctionVoid()
                        DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255)
                    end
                    SetTimeout(1000, function()
                        ClearPedTasks(PlayerPedId())
                    end)
                end
            end
        end

        if inRedZone then
            if IsPedShooting(PlayerPedId()) then
                timeLeft = 30
            end

            if timeLeft ~= 0 then
                DrawAdvancedText(0.931, 0.914, 0.005, 0.0028, 0.49, "Combat Timer: " .. timeLeft .. " seconds", 244, 11, 27, 255, 7, 0)
            elseif timeLeft == 0 then
                DrawAdvancedText(0.931, 0.914, 0.005, 0.0028, 0.49, "Combat Timer ended, you may leave.", 244, 11, 27, 255, 7, 0)
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        if inRedZone then
            if timeLeft > 0 then
                timeLeft = timeLeft - 1
            end
        end
    end
end)

function isInArea(v, dis) 
    if #(GetEntityCoords(PlayerPedId()) - v) <= dis then  
        return true
    else 
        return false
    end
end

function drawTxt(x, y, width, height, scale, text, r, g, b, a, outline)
    SetTextFont(7)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(255, 0, 0, 0, 255)
    SetTextEdge(255, 0, 0, 0, 255)
    SetTextDropShadow()
    if outline then
	    SetTextOutline()
	end
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end