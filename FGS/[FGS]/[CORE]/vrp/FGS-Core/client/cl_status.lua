
local status = 1
local user_id = 0

RegisterNetEvent("get:players")
AddEventHandler("get:players", function(players, userid)
    status = players
	user_id = userid
end)


Citizen.CreateThread(function()
    while true do
        -- This is the Application ID (Replace this with you own)
        SetDiscordAppId(947271093259993129)

        -- Here you will have to put the image name for the "large" icon.
        SetDiscordRichPresenceAsset('logo')
        
        -- (11-11-2018) New Natives:

        -- Here you can add hover text for the "large" icon.
        SetDiscordRichPresenceAssetText('https://discord.gg/EKHpKQ8UG9')
       
        -- Here you will have to put the image name for the "small" icon.
        SetDiscordRichPresenceAssetSmall('logosmall')

        -- Here you can add hover text for the "small" icon.
        SetDiscordRichPresenceAssetSmallText('FGS RP')


        SetDiscordRichPresenceAction(0, "Discord", "https://discord.gg/EKHpKQ8UG9")
        SetDiscordRichPresenceAction(1, "Join FGS", "fivem://connect/p89l37")

        -- It updates every minute just in case.
        Citizen.Wait(60000)
    end
end)
