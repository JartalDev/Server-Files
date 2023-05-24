RMenu.Add('jsell', 'main', RageUI.CreateMenu("Jewelry", "~b~FGS Jewelry BlackMarket", 1250,100))

RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('jsell', 'main')) then
        RageUI.DrawContent({ header = true, glare = true, instructionalButton = true}, function()
            RageUI.Button("Sell Jewlery" , nil, { }, true, function(Hovered, Active, Selected)
                if Selected then
                    TriggerServerEvent("FGS:Sellj")
                end
            end)
        end)
    end
end)


local isInLicenseMenu = false
Citizen.CreateThread(function() 
    while true do
            local licensecoords = vector3(202.9670715332, -1854.2999267578, 27.00379447937)
            if licensecfg.marker == true then
                if isInArea(licensecoords, 10.0) then 
                    DrawMarker(27, licensecoords+1 - 0.98, 0, 0, 0, 0, 0, 0, 0.5, 0.5, 0.5, 255, 255, 255, 150, 0, 0, 0, 0, 0, 0, 0)
                end
            end
            if not isInLicenseMenu then
                if isInArea(licensecoords, 1.4) then 
                    alert('Press ~INPUT_VEH_HORN~ to access Jewelry Selling')
                    if IsControlJustPressed(0, 51) then 
                        currentLicenseShop = k
                        RageUI.Visible(RMenu:Get("jsell", "main"), true)
                        isInLicenseMenu = true
                    end
                end

            end
            if isInArea(licensecoords, 1.4) == false and isInLicenseMenu and k == currentLicenseShop then
                RageUI.ActuallyCloseAll()
                RageUI.Visible(RMenu:Get("jsell", "main"), false)
                isInLicenseMenu = false
            end
        Citizen.Wait(0)
    end
end)