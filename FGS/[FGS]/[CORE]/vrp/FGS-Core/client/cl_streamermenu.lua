RMenu.Add('Streamer', 'main', RageUI.CreateMenu("", "~o~Streamer",1300,100))
RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('Streamer', 'main')) then
        RageUI.DrawContent({ header = true, glare = true, instructionalButton = true}, function()
            RageUI.Button("Mute VC", "", { RightLabel = ">" }, true, function(Hovered, Active, Selected) 
                if Selected then 
                    NetworkSetVoiceActive(false)
                end
            end)
            RageUI.Button("Unmute VC", "", { RightLabel = ">" }, true, function(Hovered, Active, Selected) 
                if Selected then 
                    NetworkSetVoiceActive(true) 
                end
            end)
            RageUI.Button("Cinematic Cam", "", { RightLabel = ">" }, true, function(Hovered, Active, Selected) 
                if Selected then 
                    TriggerEvent('CinematicCam:start')
                end
            end)
            RageUI.Button("Hide/Show Chat", "Not finished", { RightLabel = ">" }, true, function(Hovered, Active, Selected) 
                if Selected then 
                   TriggerEvent("GG:HIDE_CHAT") 
                end
            end)
            RageUI.Button("Hide/Show Hud", "Not finished", { RightLabel = ">" }, true, function(Hovered, Active, Selected) 
                if Selected then 
                    TriggerEvent("FGS:showhud")
                end
            end)
        end)
    end
end)


RegisterNetEvent("GG:ToggleStreamerMenu", function()
    RageUI.Visible(RMenu:Get("Streamer", "main"), not RageUI.Visible(RMenu:Get("Streamer", "main")))
end)
