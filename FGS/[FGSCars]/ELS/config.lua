outputLoading = false
playButtonPressSounds = true
printDebugInformation = false

vehicleSyncDistance = 150
environmentLightBrightness = 0.024
lightDelay = 10000 -- Time in MS
flashDelay = 10000

panelEnabled = false
panelType = "original"
panelOffsetX = 0.0
panelOffsetY = 0.0

allowedPanelTypes = {
    "original",
    "old"
}


shared = {
   -- horn = 86,
}

keyboard = {
    modifyKey = 132,
    stageChange = 85, -- Q
    guiKey = 199, -- P
    takedown = 83, -- =
    siren = {
		tone_one = 157, -- 1
		tone_two = 158, -- 2
		tone_three = 160, --3
		tone_four = 164, --4        -- Keys for all the Siren keys down here
		tone_five = 165, --5
		tone_six = 159, --6
		tone_seven = 161, --7
		tone_eight = 162,  --8
    },
    pattern = {
        primary = 163, -- 9
        secondary = 162, -- 8
        advisor = 161, -- 7
    },

    -- These are moved to Numpad
    primary = 118, -- 9 NUM      
    secondary = 111, -- 8 NUM
    advisor = 117, -- 7 NUM
}

controller = {
    modifyKey = 73,
    stageChange = 80,
    takedown = 74,
    siren = {
        tone_one = 173,
        tone_two = 85,
        tone_three = 172,
    },
}