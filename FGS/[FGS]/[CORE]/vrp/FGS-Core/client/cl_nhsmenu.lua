RMenu.Add('FGSNHSMenu', 'main', RageUI.CreateMenu("", "~w~NHS Menu",1250,100, "nhsmenu", "nhsmenu"))

RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('FGSNHSMenu', 'main')) then
        RageUI.DrawContent({ header = true, glare = true, instructionalButton = true}, function()
            if IsPedInAnyVehicle(GetPlayerPed(-1), false) == false then

                RageUI.Button("Perform Cardiopulmonary Resuscitation" , "~b~Perform CPR on the nearest player", { RightLabel = '→'}, true, function(Hovered, Active, Selected) 
                    if Selected then 
                        FGS_server_callback('FGS:PerformCPR')
                    end
                end)

                RageUI.Button("Heal Nearest Player", "~g~Heal the nearest player", { RightLabel = '→'}, true, function(Hovered, Active, Selected) 
                  if Selected then 
                      FGS_server_callback('FGS:HealPlayer')
                  end
              end)
                

            end
        end)
    end
end)

RegisterCommand('nhs', function()
  if IsPedInAnyVehicle(GetPlayerPed(-1), false) == false then
    FGS_server_callback('FGS:OpenNHSMenu')
  end
end)

RegisterNetEvent("FGS:NHSMenuOpened")
AddEventHandler("FGS:NHSMenuOpened",function()
  RageUI.Visible(RMenu:Get('FGSNHSMenu', 'main'), not RageUI.Visible(RMenu:Get('FGSNHSMenu', 'main')))
end)

RegisterKeyMapping('nhs', 'Opens the NHS menu', 'keyboard', 'U')