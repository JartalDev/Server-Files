RMenu.Add('JobSelector', 'main', RageUI.CreateMenu("Job Selector", "~b~Job Selector Menu", 1250,100))

RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('JobSelector', 'main')) then
        RageUI.DrawContent({ header = true, glare = true, instructionalButton = true}, function()

            RageUI.Button("~b~DPD" , nil, { RightLabel = "→" }, true, function(Hovered, Active, Selected)
                if Selected then
                    FGS_server_callback('JobSelector:SelectJob', "DPD")
                end
            end)

            RageUI.Button("~r~Unemployed" , nil, { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
                if Selected then
                    FGS_server_callback('JobSelector:Unemployed')

                end
            end)
        end) 
    end
end)

isInJobSelector = false
currentJobSelectorMenu = nil
Citizen.CreateThread(function() 
    while true do
            local x,y,z = 212.13414001465,349.56680297852,105.64709472656
            local jobmenu = vector3(x,y,z)

            if isInArea(jobmenu, 100.0) then 
                DrawMarker(27, vector3(x,y,z-0.9), 0, 0, 0, 0, 0, 0, 0.8, 0.8, 0.8, 0, 140, 255, 150, 0, 0, 0, 0, 0, 0, 0)
            end
 
            if isInJobSelector == false then
            if isInArea(jobmenu, 1.4) then 
                alert('Press ~INPUT_VEH_HORN~ to open Job Selector')
                if IsControlJustPressed(0, 51) then 
                    currentJobSelectorMenu = k
                    RageUI.ActuallyCloseAll()
                    RageUI.Visible(RMenu:Get("JobSelector", "main"),true)
                    isInJobSelector = true
                    currentJobSelectorMenu = k 
                end
            end
            end
            if isInArea(jobmenu, 1.4) == false and isInJobSelector and k == currentJobSelectorMenu then
                RageUI.ActuallyCloseAll()
                isInJobSelector = false
                currentJobSelectorMenu = nil
            end
        Citizen.Wait(0)
    end
end)