RMenu.Add('LicenseCentre', 'main', RageUI.CreateMenu("", "~b~FGS License Shop", 1250,100, "licencecentre", "licencecentre"))
RMenu.Add('LicenseCentre', 'confirmationscreen', RageUI.CreateMenu("", "~b~Confirm Purchase", 1250,100, "licencecentre", "licencecentre"))
RMenu.Add('LicenseCentre', 'gunconfirmationscreen', RageUI.CreateMenu("", "~b~Confirm Purchase", 1250,100, "licencecentre", "licencecentre"))

local licensename = nil
local licenseprice = nil
local licenseshownprice = nil
local licensegroupname = nil

RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('LicenseCentre', 'main')) then
        RageUI.DrawContent({ header = true, glare = true, instructionalButton = true}, function()
            RageUI.Separator("Licenses", function() end)
            for i , p in pairs(licensecfg.licenses.drugs) do 
                RageUI.Button(p.name.." ["..licensecfg.currency .. tostring(p.shownprice).."]" , nil, { }, true, function(Hovered, Active, Selected)
                    if Selected then
                        licensename = p.name
                        licenseprice = p.price
                        licenseshownprice = p.shownprice
                        licensegroupname = i
                        FGS_server_callback('LicenseCentre:BuyGroup', p.price, i)
                    end
                end, RMenu:Get('LicenseCentre', 'main'))
            end
        end)
    end
end)



RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('LicenseCentre', 'confirmationscreen')) then
        RageUI.DrawContent({ header = true, glare = false, instructionalButton = true}, function()
            RageUI.Separator("License Price: £"..licenseshownprice, function() end)
            RageUI.Separator("Are you sure you want to purchase a "..licensename.."?", function() end)
            RageUI.Button("Yes" , "", {RightLabel = ">>>"}, true, function(Hovered, Active, Selected)
                if Selected then 
                    FGS_server_callback('LicenseCentre:BuyGroup', licenseprice, licensegroupname)
                    RageUI.ActuallyCloseAll()
                end
            end, RMenu:Get('LicenseCentre', 'main'))
            RageUI.Button("No" , "", {RightLabel = ">>>"}, true, function(Hovered, Active, Selected)
                if Selected then
                    notify("~r~Purchase Cancelled")
                    RageUI.ActuallyCloseAll()
                end
            end, RMenu:Get('LicenseCentre', 'main'))
        end)
    end
end)


local isInLicenseMenu = false
Citizen.CreateThread(function() 
    while true do
            local licensecoords = licensecfg.coords
            if licensecfg.marker == true then
                if isInArea(licensecoords, 100.0) then 
                    DrawMarker(27, licensecoords+1 - 0.98, 0, 0, 0, 0, 0, 0, 0.5, 0.5, 0.5, 255, 255, 255, 150, 0, 0, 0, 0, 0, 0, 0)
                end
            end
            if not isInLicenseMenu then
                if isInArea(licensecoords, 1.4) then 
                    alert('Press ~INPUT_VEH_HORN~ to access License Shop')
                    if IsControlJustPressed(0, 51) then 
                        currentLicenseShop = k
                        RageUI.Visible(RMenu:Get("LicenseCentre", "main"), true)
                        isInLicenseMenu = true
                    end
                end

            end
            if isInArea(licensecoords, 1.4) == false and isInLicenseMenu and k == currentLicenseShop then
                RageUI.ActuallyCloseAll()
                RageUI.Visible(RMenu:Get("LicenseCentre", "main"), false)
                isInLicenseMenu = false
            end
        Citizen.Wait(0)
    end
end)