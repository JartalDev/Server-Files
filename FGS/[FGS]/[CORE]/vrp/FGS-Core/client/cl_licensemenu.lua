RMenu.Add('LicenseMenu', 'menu', RageUI.CreateMenu("", "~b~Owned Licenses", 1300,100, "licencemenu", "licencemenu")) 

local hasweed = false
local hascoke = false
local hasecstasy = false
local hasmeth = false
local hasheroin = false
local haslarge = false
local hasrebel = false
local hasdiamond1 = false

RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('LicenseMenu', 'menu')) then
        RageUI.DrawContent({ header = true, glare = true, instructionalButton = true}, function()
            RageUI.Button("Drug Licenses" , "", {RightLabel = ""}, true, function(Hovered, Active, Selected)
            end)
            if hasweed then
                RageUI.Separator("Weed License", function() end)
            end
            if hascoke then
                RageUI.Separator("Coke License", function() end)
            end
            if hasdiamond1 then
                RageUI.Separator("Diamond License", function() end)
            end
            if hasecstasy then
                RageUI.Separator("Ecstasy License", function() end)
            end
            if hasmeth then
                RageUI.Separator("Meth License", function() end)
            end
            if hasheroin then
                RageUI.Separator("Heroin License", function() end)
            end
            RageUI.Button("Gun Licenses" , "", {RightLabel = ""}, true, function(Hovered, Active, Selected)
            end)
            if hasrebel then
                RageUI.Separator("Rebel License", function() end)
            end
       end)
    end
end)

RegisterNetEvent('FGS:OpenLicenseMenu')
AddEventHandler('FGS:OpenLicenseMenu', function(weed,coke,ecstasy,meth,heroin,rebel,diamond1)
    if weed then
        hasweed = true
    end
    if coke then
        hascoke = true
    end
    if diamond1 then
        hasdiamond1 = true
    end
    if ecstasy then
        hasecstasy = true
    end
    if meth then
        hasmeth = true
    end
    if heroin then
        hasheroin = true
    end
    if rebel then
        hasrebel = true
    end
    RageUI.Visible(RMenu:Get("LicenseMenu", "menu"), true)
end)

RegisterCommand('openlicensemenu',function()
    FGS_server_callback('FGS:OpenLicense')
end)

RegisterKeyMapping('openlicensemenu', 'Opens the License menu', 'keyboard', 'F7')