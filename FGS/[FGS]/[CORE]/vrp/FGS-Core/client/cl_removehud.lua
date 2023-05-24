Citizen.CreateThread(function()
    while true do
      Citizen.Wait(0)
      HideHudComponentThisFrame( 7 ) -- Area Name
      HideHudComponentThisFrame( 9 ) -- Street Name
      HideHudComponentThisFrame( 3 ) -- SP Cash display 
      HideHudComponentThisFrame( 4 )  -- MP Cash display
      HideHudComponentThisFrame( 13 ) -- Cash changes
      HideHudComponentThisFrame( 6 ) -- Veh Name
      HideHudComponentThisFrame( 8 ) -- Veh Class
    end
  end)