
local seconds = 1000
Config = {}

Config.checkForUpdates = true -- Check for updates?

Config.DiscordInfo = {
    botToken = 'MTA2NzQwOTY2MzIzNjI1OTg5MA.GEe5ho.to1bfbDH9eSfCHBzZG4jaa3HjIR-LKULRix_wA', -- Your Discord bot token here
    guildID = '1040005267246559322', -- Your Discord's server ID here(Aka Guild ID)
}

Config.DiscordWhitelist = { -- Restrict if someone can fly in if they lack specific Discord role(s)
    enabled = true, -- Enable?
    deniedMessage = 'https://discord.gg/EKHpKQ8UG9  : Make Sure To Join & Get The Verify Role To Play!', -- Message for those who lack whitelisted role(s)
    whitelistedRoles = {
      --'ROLE_ID_HERE',  
        '1066351596629405776', -- Maybe like a civilian role or whitelisted role(can add multiple to table)
    }
}

Config.DiscordQueue = {
    enabled = true, -- Enable? Requires
    refreshTime = 4.0 * seconds, -- How long between queue refreshes(Default: 2.5 * seconds)
    maxConnections = 64, -- How many slots do you have avaliable in total for server
    title = 'FGS', -- Maybe server name here?

    image = { -- Image shown on adaptive card
        link = 'https://i.imgur.com/bGC0A78.png', -- Link to image, maybe like a server logo?
        width = '512px', -- Width of image(would not go much higher than this)
        height = '300px' -- Height
    },

    currentQueueText = 'Current Queue', -- Title above queue but below image

    currentSpotText = 'Current Queue: %s | Total Online: %s/%s', -- Current queue place text

    footerText = 'Visit our web store to reserve a priority queue!', -- The text right above the buttons on the adaptive card

    overflowQueueText = 'And %s more players!\n',

    buttons = { -- The little buttons at the bottom of the screen
        button1 = { -- Webstore button config
            title = 'Webstore',
            iconUrl = 'https://i.imgur.com/8msLEGN.png', -- Little button icon image link
            url = 'https://' -- Link button goes to
        },
        button2 = {
            title = 'Discord',
            iconUrl = 'https://i.imgur.com/4a1Rdgf.png',
            url = 'https://discord.gg/EKHpKQ8UG9'
        }
    },
    roles = {

        { -- This ones provided by default are purely for example
            name = '[Verified]', -- Name you want displayed as role on queue card
            roleId = '979490130303811634', -- Role ID of role
            points = 0 -- Points to add to queue(Higher the number, higher the queue)
        },

        {
            name = '[Streamer]',
            roleId = '979484797695053834',
            points = 10
        },

        {
            name = '[Staff]',
            roleId = '980230381808807946',
            points = 60
        },

    }
}

strings = {
    verifyConnection = '[FGS] Verifying connection...',
    verifyLauncher = '[FGS] Verifying Launcher...',
    verifyDiscord = '[FGS] Verifying Discord...',
    verifyQueue = '[FGS] Adding to queue...',
    notInDiscord = '[FGS] You must join the discord: https://discord.gg/EKHpKQ8UG9 to fly in! Only Takes a Click :)',
    noDiscord = '[FGS] You must have Discord downloaded, installed, and running to connect!',
    error = '[FGS] An error has occured, please try again!'

}
