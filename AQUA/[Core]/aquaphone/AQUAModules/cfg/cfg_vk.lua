vk = {}

INTERIORS = {
    -- HOPITAL
    [1] = {id = 1, x = 359.82690429688, y = -584.85693359375, z = 28.818954467773,  name = "~d~Exit NHS", destination = {2}}, -- 359.82690429688, y = -584.85693359375, z = 28.818954467773
	[2] = {id = 2, x = 332.90893554688, y = -569.51391601563, z = 43.283973693848,  name = "~g~Enter NHS", destination = {1}},

    -- FIB
    [4] = {id = 4, x = 138.18788146973, y = -764.86633300781, z = 45.75199508667,  name = "~d~Exit FBI", destination = {5}},
    [5] = {id = 5, x = 138.18788146973, y = -764.86633300781, z = 45.75199508667,  name = "~g~Enter FBI", destination = {4}},

    -- FIB GARAGE
    [6] = {id = 6, x = 142.06883239746, y = -768.97241210938, z = 45.752010345459, h = 72.884956359863, name = "~d~FIB Building", destination = {7}},
    [7] = {id = 7, x = 176.67442321777, y = -728.77349853516, z = 39.403667449951, h = 248.2452545166, name = "~d~Garage", destination = {6}},

    -- VIP ISLAND
    [8] = {id = 8, x = -2171.9331054688, y = 5142.0014648438, z = 2.8199982643127, name = "~g~Enter VIP Island", destination = {9}}, 
    [9] = {id = 9, x =  -746.60528564453, y = 5807.9116210938, z = 17.602642059326, name = "~d~Exit VIP Island", destination = {8}}, -- -746.60528564453,5807.9116210938,17.602642059326



    [10] = {id = 8, x = -1950.9876708984, y = 3019.8894042969, z = 32.810291290283, name = "~b~Enter Police Training", destination = {10}}, 
    [11] = {id = 9, x =  470.83456420898, y = -984.7470703125, z = 30.689601898193, name = "~b~Exit Police Training", destination = {11}}, -- 470.83456420898,-984.7470703125,30.689601898193
}


vk.TP = {
    
} 