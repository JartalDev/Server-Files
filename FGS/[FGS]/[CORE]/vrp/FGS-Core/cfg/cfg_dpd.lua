
dpdcfg = {}

-- Delivery Base Location
dpdcfg.Base = {
	-- Blip coords
	coords  = {x = -314.0, y = -1035.21, z = 30.53},
	-- Truck mark
	truck   = {x = -326.75, y = -1029.23, z = 30.53},
	-- Return vehicle mark
	retveh  = {x = -271.3, y = -1009.66, z = 29.87},
	-- Delete vehicle mark
	deleter = {x = -338.26, y = -1023.18, z = 30.38},
	-- Heading
	heading = 245.0,
}

dpdcfg.DecorCode = 0

-- Min and max deliveries jobs
dpdcfg.Deliveries = {
	min = 5,
	max = 7,
}

-- The salary of jobs
dpdcfg.Rewards = {
	truck   = 1500,
}

-- Vehicle model
dpdcfg.Models = {
	truck   = 'pony',
	vehDoor = {
		-- If this value is true, it will open the vehicle trunk when player remove the goods from the vehicle.
		usingTrunkForVan   = true,  -- If you using original game vehicle, set this to false
		usingTrunkForTruck = true,
	},
}

-- Scale of the arrow, usually not modified it
dpdcfg.Scales = {
	truck   = 4.5,
}

-- Rental money of the vehicles
dpdcfg.Safe = {
	truck   = 8000,
}

-- Random parking locations
dpdcfg.ParkingSpawns = {
	{x = -310.50, y = -1011.08, z = 30.39, h = 252.00},
	{x = -309.35, y = -1008.24, z = 30.39, h = 251.15},
	{x = -311.53, y = -1013.72, z = 30.39, h = 252.00},
	{x = -305.17, y = -1013.04, z = 30.39, h = 70.78},
	{x = -307.33, y = -1002.65, z = 30.39, h = 248.33},
	{x = -322.99, y = -1000.16, z = 30.39, h = 73.11},
	{x = -329.65, y = -1004.10, z = 30.39, h = 253.11},
	{x = -324.65, y = -1006.08, z = 30.39, h = 69.82},
	{x = -326.87, y = -1011.45, z = 30.39, h = 73.49},
}

-- Random delivery locations of truck
dpdcfg.DeliveryLocationsTruck = {
	{Item1 = {x = -1395.82, y = -653.76, z = 28.91},	Item2 = {x = -1413.43, y = -635.47, z = 28.67}},
	{Item1 = {x = 164.18, y = -1280.21, z = 29.38},		Item2 = {x = 136.5, y = -1278.69, z = 29.36}},
	{Item1 = {x = 75.71, y = 164.41, z = 104.93},		Item2 = {x = 78.55, y = 180.44, z = 104.63}},
	{Item1 = {x = -226.62, y = 308.87, z = 92.4},		Item2 = {x = -229.54, y = 293.59, z = 92.19}},
	{Item1 = {x = -365.87, y = 297.27, z = 85.04},		Item2 = {x = -370.5, y = 277.98, z = 86.42}},
	{Item1 = {x = -403.95, y = 196.11, z = 82.67},		Item2 = {x = -395.17, y = 208.6, z = 83.59}},
	{Item1 = {x = -412.26, y = 297.95, z = 83.46},		Item2 = {x = -427.08, y = 294.19, z = 83.23}},
	{Item1 = {x = -606.23, y = -901.52, z = 25.39},		Item2 = {x = -592.48, y = -892.76, z = 25.93}},
	{Item1 = {x = -837.03, y = -1142.46, z = 7.44},		Item2 = {x = -841.89, y = -1127.91, z = 6.97}},
	{Item1 = {x = -1061.56, y = -1382.19, z = 5.44},	Item2 = {x = -1039.38, y = -1396.88, z = 5.55}},
	{Item1 = {x = 156.41, y = -1651.21, z = 29.53},		Item2 = {x = 169.11, y = -1633.38, z = 29.29}},
	{Item1 = {x = 168.13, y = -1470.07, z = 29.37},		Item2 = {x = 175.78, y = -1461.16, z = 29.24}},
	{Item1 = {x = 118.99, y = -1486.21, z = 29.38},		Item2 = {x = 143.54, y = -1481.18, z = 29.36}},
	{Item1 = {x = -548.34, y = 308.19, z = 83.34},		Item2 = {x = -546.6, y = 291.46, z = 83.02}},
}

-- Player outfit of van and truck
dpdcfg.OutfitVan = {
	[1]  = {drawables = 0, texture = 0},
	[3]  = {drawables = 66, texture = 0},
	[4]  = {drawables = 97, texture = 3},
	[5]  = {drawables = 0, texture = 0},
	[6]  = {drawables = 32, texture = 14},
	[7]  = {drawables = 0, texture = 0},
	[8]  = {drawables = 141, texture = 0},
	[9]  = {drawables = 0, texture = 0},
	[11] = {drawables = 230, texture = 3},
	[12] = {drawables = 45, texture = 7},
	[13] = {drawables = 1280, texture = 2},
}

-- Player outfit of van and truck (female)
dpdcfg.OutfitVanF = {
	[1]  = {drawables = 0, texture = 0},
	[3]  = {drawables = 14, texture = 0},
	[4]  = {drawables = 45, texture = 1},
	[5]  = {drawables = 0, texture = 0},
	[6]  = {drawables = 27, texture = 0},
	[7]  = {drawables = 0, texture = 0},
	[8]  = {drawables = 14, texture = 0},
	[9]  = {drawables = 0, texture = 0},
	[11] = {drawables = 14, texture = 3},
	[12] = {drawables = 18, texture = 7},
	[13] = {drawables = 1280, texture = 2},
}

-- Random van goods
dpdcfg.VanGoodsPropNames = {
	"prop_crate_11e",
    "prop_cardbordbox_02a",
}

return dpdcfg