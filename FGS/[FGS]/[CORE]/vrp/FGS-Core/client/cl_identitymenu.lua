RMenu.Add('IdentityMenu', 'main', RageUI.CreateMenu("New Identity", "~b~Identity Menu", 1250,100))

RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('IdentityMenu', 'main')) then
        RageUI.DrawContent({ header = true, glare = true, instructionalButton = true}, function()

            RageUI.Button("~b~New Identity" , nil, { RightLabel = "→" }, true, function(Hovered, Active, Selected)
                if Selected then
                    FGS_server_callback('IdentityMenu:NewIdentity')
                end
            end)

            
        end) 
    end
end)

isInIdentityMenu = false
currentIdentityMenuMenu = nil
Citizen.CreateThread(function() 
    while true do
            local x,y,z = -262.25286865234,-969.47399902344,31.223146438599
            local identitymenu = vector3(x,y,z)

            if isInArea(identitymenu, 100.0) then 
                DrawMarker(27, vector3(x,y,z-0.9), 0, 0, 0, 0, 0, 0, 0.8, 0.8, 0.8, 0, 140, 255, 150, 0, 0, 0, 0, 0, 0, 0)
            end
 
            if isInIdentityMenu == false then
            if isInArea(identitymenu, 1.4) then 
                alert('Press ~INPUT_VEH_HORN~ to open Identity Menu')
                if IsControlJustPressed(0, 51) then 
                    currentIdentityMenuMenu = k
                    RageUI.ActuallyCloseAll()
                    RageUI.Visible(RMenu:Get("IdentityMenu", "main"),true)
                    isInIdentityMenu = true
                    currentIdentityMenuMenu = k 
                end
            end
            end
            if isInArea(identitymenu, 1.4) == false and isInIdentityMenu and k == currentIdentityMenuMenu then
                RageUI.ActuallyCloseAll()
                isInIdentityMenu = false
                currentIdentityMenuMenu = nil
            end
        Citizen.Wait(0)
    end
end)