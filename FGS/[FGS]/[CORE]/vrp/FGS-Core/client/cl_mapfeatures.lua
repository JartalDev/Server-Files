function AddTextEntry(key, value)
	Citizen.InvokeNative(GetHashKey("ADD_TEXT_ENTRY"), key, value)
end

local config = {
    ["TITLE"] = "~b~FGS ~w~- discord.gg/FGS",
    ["SUBTITLE"] = "~w~Welcome to ~b~FGS,~w~ Make sure to read all rules before playing and have fun!",
    ["MAP"] = "Map",
    ["STATUS"] = "Status",
    ["GAME"] = "Game",
    ["INFO"] = "Info",
    ["SETTINGS"] = "Settings",
	["GALLERY"] = "Gallery",
	["DC"] = "~b~Disconnect Server",
	["QUIT"] = "~b~Leave Server",
    ["R*EDITOR"] = "~w~FGS Editor"
}

Citizen.CreateThread(function()
    while true do
    Citizen.Wait(0)
        N_0xb9449845f73f5e9c("SHIFT_CORONA_DESC")
        PushScaleformMovieFunctionParameterBool(true)
        PopScaleformMovieFunction()
        N_0xb9449845f73f5e9c("SET_HEADER_TITLE")
        PushScaleformMovieFunctionParameterString(config["TITLE"])
        PushScaleformMovieFunctionParameterBool(true)
        PushScaleformMovieFunctionParameterString(config["SUBTITLE"])
        PushScaleformMovieFunctionParameterBool(true)
        PopScaleformMovieFunctionVoid()
    end
end)

Citizen.CreateThread(function()
    AddTextEntry('PM_SCR_MAP', config["MAP"])
    AddTextEntry('PM_SCR_STA', config["STATUS"])
    AddTextEntry('PM_SCR_GAM', config["GAME"])
    AddTextEntry('PM_SCR_INF', config["INFO"])
    AddTextEntry('PM_SCR_SET', config["SETTINGS"])
	AddTextEntry('PM_SCR_GAL', config["GALLERY"])
    AddTextEntry('PM_SCR_RPL', config["R*EDITOR"])
	AddTextEntry('PM_PANE_QUIT', config["QUIT"])
	AddTextEntry('PM_PANE_LEAVE', config["DC"])

end)