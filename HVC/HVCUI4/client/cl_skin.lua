local isSkinCreatorOpened = false		
cam = nil							
local heading = 332.219879				
local zoom = "visage"				
local isCameraActive = false
local FirstSpawn     = true
local PlayerLoaded   = false
local PrevHat,PrevGlasses


Config = {}
Config.Locale = 'en'
Locales = {}
Locales['en'] = {
	['sex'] = 'sex',
	['face'] = 'face',
	['skin'] = 'skin',
	['wrinkles'] = 'wrinkles',
	['wrinkle_thickness'] = 'wrinkle thickness',
	['beard_type'] = 'beard type',
	['beard_size'] = 'beard size',
	['beard_color_1'] = 'beard color 1',
	['beard_color_2'] = 'beard color 2',
	['hair_1'] = 'hair 1',
	['hair_2'] = 'hair 2',
	['hair_color_1'] = 'hair color 1',
	['hair_color_2'] = 'hair color 2',
	['eye_color'] = 'eye color',
	['eyebrow_type'] = 'eyebrow type',
	['eyebrow_size'] = 'eyebrow size',
	['eyebrow_color_1'] = 'eyebrow color 1',
	['eyebrow_color_2'] = 'eyebrow color 2',
	['makeup_type'] = 'makeup type',
	['makeup_thickness'] = 'makeup thickness',
	['makeup_color_1'] = 'makeup color 1',
	['makeup_color_2'] = 'makeup color 2',
	['lipstick_type'] = 'lipstick type',
	['lipstick_thickness'] = 'lipstick thickness',
	['lipstick_color_1'] = 'lipstick color 1',
	['lipstick_color_2'] = 'lipstick color 2',
	['ear_accessories'] = 'ear accessories',
	['ear_accessories_color'] = 'ear accessories color',
	['tshirt_1'] = 't-Shirt 1',
	['tshirt_2'] = 't-Shirt 2',
	['torso_1'] = 'torso 1',
	['torso_2'] = 'torso 2',
	['decals_1'] = 'decals 1',
	['decals_2'] = 'decals 2',
	['arms'] = 'arms',
	['arms_2'] = 'arms 2',
	['pants_1'] = 'pants 1',
	['pants_2'] = 'pants 2',
	['shoes_1'] = 'shoes 1',
	['shoes_2'] = 'shoes 2',
	['mask_1'] = 'mask 1',
	['mask_2'] = 'mask 2',
	['bproof_1'] = 'bulletproof vest 1',
	['bproof_2'] = 'bulletproof vest 2',
	['chain_1'] = 'chain 1',
	['chain_2'] = 'chain 2',
	['helmet_1'] = 'helmet 1',
	['helmet_2'] = 'helmet 2',
	['watches_1'] = 'watches 1',
	['watches_2'] = 'watches 2',
	['bracelets_1'] = 'bracelets 1',
	['bracelets_2'] = 'bracelets 2',
	['glasses_1'] = 'glasses 1',
	['glasses_2'] = 'glasses 2',
	['bag'] = 'bag',
	['bag_color'] = 'bag color',
	['blemishes'] = 'blemishes',
	['blemishes_size']= 'blemishes thickness',
	['ageing'] = 'ageing',
	['ageing_1'] = 'ageing thickness',
	['blush'] = 'blush',
	['blush_1'] = 'blush thickness',
	['blush_color'] = 'blush color',
	['complexion'] = 'complexion',
	['complexion_1'] = 'complexion thickness',
	['sun'] = 'sun',
	['sun_1'] = 'sun thickness',
	['freckles'] = 'freckles',
	['freckles_1'] = 'freckles thickness',
	['chest_hair'] = 'chest hair',
	['chest_hair_1'] = 'chest hair thickness',
	['chest_color'] = 'chest hair color',
	['bodyb'] = 'body blemishes',
	['bodyb_size'] = 'body blemishes thickness'
  }
  

function _(str, ...) -- Translate string

	if Locales[Config.Locale] ~= nil then

		if Locales[Config.Locale][str] ~= nil then
			return string.format(Locales[Config.Locale][str], ...)
		else
			return 'Translation [' .. Config.Locale .. '][' .. str .. '] does not exist'
		end

	else
		return 'Locale [' .. Config.Locale .. '] does not exist'
	end

end

function _U(str, ...) -- Translate string first char uppercase
	return tostring(_(str, ...):gsub("^%l", string.upper))
end

local Components = {
	{label = _U('sex'),						name = 'sex',				value = 0,		min = 0,	zoomOffset = 0.6,		camOffset = 0.65},
	{label = _U('face'),					name = 'face',				value = 0,		min = 0,	zoomOffset = 0.6,		camOffset = 0.65},
	{label = _U('skin'),					name = 'skin',				value = 0,		min = 0,	zoomOffset = 0.6,		camOffset = 0.65},
	{label = _U('hair_1'),					name = 'hair_1',			value = 0,		min = 0,	zoomOffset = 0.6,		camOffset = 0.65},
	{label = _U('hair_2'),					name = 'hair_2',			value = 0,		min = 0,	zoomOffset = 0.6,		camOffset = 0.65},
	{label = _U('hair_color_1'),			name = 'hair_color_1',		value = 0,		min = 0,	zoomOffset = 0.6,		camOffset = 0.65},
	{label = _U('hair_color_2'),			name = 'hair_color_2',		value = 0,		min = 0,	zoomOffset = 0.6,		camOffset = 0.65},
	{label = _U('tshirt_1'),				name = 'tshirt_1',			value = 0,		min = 0,	zoomOffset = 0.75,		camOffset = 0.15},
	{label = _U('tshirt_2'),				name = 'tshirt_2',			value = 0,		min = 0,	zoomOffset = 0.75,		camOffset = 0.15,	textureof	= 'tshirt_1'},
	{label = _U('torso_1'),					name = 'torso_1',			value = 0,		min = 0,	zoomOffset = 0.75,		camOffset = 0.15},
	{label = _U('torso_2'),					name = 'torso_2',			value = 0,		min = 0,	zoomOffset = 0.75,		camOffset = 0.15,	textureof	= 'torso_1'},
	{label = _U('decals_1'),				name = 'decals_1',			value = 0,		min = 0,	zoomOffset = 0.75,		camOffset = 0.15},
	{label = _U('decals_2'),				name = 'decals_2',			value = 0,		min = 0,	zoomOffset = 0.75,		camOffset = 0.15,	textureof	= 'decals_1'},
	{label = _U('arms'),					name = 'arms',				value = 0,		min = 0,	zoomOffset = 0.75,		camOffset = 0.15},
	{label = _U('arms_2'),					name = 'arms_2',			value = 0,		min = 0,	zoomOffset = 0.75,		camOffset = 0.15},
	{label = _U('pants_1'),					name = 'pants_1',			value = 0,		min = 0,	zoomOffset = 0.8,		camOffset = -0.5},
	{label = _U('pants_2'),					name = 'pants_2',			value = 0,		min = 0,	zoomOffset = 0.8,		camOffset = -0.5,	textureof	= 'pants_1'},
	{label = _U('shoes_1'),					name = 'shoes_1',			value = 0,		min = 0,	zoomOffset = 0.8,		camOffset = -0.8},
	{label = _U('shoes_2'),					name = 'shoes_2',			value = 0,		min = 0,	zoomOffset = 0.8,		camOffset = -0.8,	textureof	= 'shoes_1'},
	{label = _U('mask_1'),					name = 'mask_1',			value = 0,		min = 0,	zoomOffset = 0.6,		camOffset = 0.65},
	{label = _U('mask_2'),					name = 'mask_2',			value = 0,		min = 0,	zoomOffset = 0.6,		camOffset = 0.65,	textureof	= 'mask_1'},
	{label = _U('bproof_1'),				name = 'bproof_1',			value = 0,		min = 0,	zoomOffset = 0.75,		camOffset = 0.15},
	{label = _U('bproof_2'),				name = 'bproof_2',			value = 0,		min = 0,	zoomOffset = 0.75,		camOffset = 0.15,	textureof	= 'bproof_1'},
	{label = _U('chain_1'),					name = 'chain_1',			value = 0,		min = 0,	zoomOffset = 0.6,		camOffset = 0.65},
	{label = _U('chain_2'),					name = 'chain_2',			value = 0,		min = 0,	zoomOffset = 0.6,		camOffset = 0.65,	textureof	= 'chain_1'},
	{label = _U('helmet_1'),				name = 'helmet_1',			value = -1,		min = -1,	zoomOffset = 0.6,		camOffset = 0.65,	componentId	= 0 },
	{label = _U('helmet_2'),				name = 'helmet_2',			value = 0,		min = 0,	zoomOffset = 0.6,		camOffset = 0.65,	textureof	= 'helmet_1'},
	{label = _U('glasses_1'),				name = 'glasses_1',			value = 0,		min = 0,	zoomOffset = 0.6,		camOffset = 0.65},
	{label = _U('glasses_2'),				name = 'glasses_2',			value = 0,		min = 0,	zoomOffset = 0.6,		camOffset = 0.65,	textureof	= 'glasses_1'},
	{label = _U('watches_1'),				name = 'watches_1',			value = -1,		min = -1,	zoomOffset = 0.75,		camOffset = 0.15},
	{label = _U('watches_2'),				name = 'watches_2',			value = 0,		min = 0,	zoomOffset = 0.75,		camOffset = 0.15,	textureof	= 'watches_1'},
	{label = _U('bracelets_1'),				name = 'bracelets_1',		value = -1,		min = -1,	zoomOffset = 0.75,		camOffset = 0.15},
	{label = _U('bracelets_2'),				name = 'bracelets_2',		value = 0,		min = 0,	zoomOffset = 0.75,		camOffset = 0.15,	textureof	= 'bracelets_1'},
	{label = _U('bag'),						name = 'bags_1',			value = 0,		min = 0,	zoomOffset = 0.75,		camOffset = 0.15},
	{label = _U('bag_color'),				name = 'bags_2',			value = 0,		min = 0,	zoomOffset = 0.75,		camOffset = 0.15,	textureof	= 'bags_1'},
	{label = _U('eye_color'),				name = 'eye_color',			value = 0,		min = 0,	zoomOffset = 0.4,		camOffset = 0.65},
	{label = _U('eyebrow_size'),			name = 'eyebrows_2',		value = 0,		min = 0,	zoomOffset = 0.4,		camOffset = 0.65},
	{label = _U('eyebrow_type'),			name = 'eyebrows_1',		value = 0,		min = 0,	zoomOffset = 0.4,		camOffset = 0.65},
	{label = _U('eyebrow_color_1'),			name = 'eyebrows_3',		value = 0,		min = 0,	zoomOffset = 0.4,		camOffset = 0.65},
	{label = _U('eyebrow_color_2'),			name = 'eyebrows_4',		value = 0,		min = 0,	zoomOffset = 0.4,		camOffset = 0.65},
	{label = _U('makeup_type'),				name = 'makeup_1',			value = 0,		min = 0,	zoomOffset = 0.4,		camOffset = 0.65},
	{label = _U('makeup_thickness'),		name = 'makeup_2',			value = 0,		min = 0,	zoomOffset = 0.4,		camOffset = 0.65},
	{label = _U('makeup_color_1'),			name = 'makeup_3',			value = 0,		min = 0,	zoomOffset = 0.4,		camOffset = 0.65},
	{label = _U('makeup_color_2'),			name = 'makeup_4',			value = 0,		min = 0,	zoomOffset = 0.4,		camOffset = 0.65},
	{label = _U('lipstick_type'),			name = 'lipstick_1',		value = 0,		min = 0,	zoomOffset = 0.4,		camOffset = 0.65},
	{label = _U('lipstick_thickness'),		name = 'lipstick_2',		value = 0,		min = 0,	zoomOffset = 0.4,		camOffset = 0.65},
	{label = _U('lipstick_color_1'),		name = 'lipstick_3',		value = 0,		min = 0,	zoomOffset = 0.4,		camOffset = 0.65},
	{label = _U('lipstick_color_2'),		name = 'lipstick_4',		value = 0,		min = 0,	zoomOffset = 0.4,		camOffset = 0.65},
	{label = _U('ear_accessories'),			name = 'ears_1',			value = -1,		min = -1,	zoomOffset = 0.4,		camOffset = 0.65},
	{label = _U('ear_accessories_color'),	name = 'ears_2',			value = 0,		min = 0,	zoomOffset = 0.4,		camOffset = 0.65,	textureof	= 'ears_1'},
	{label = _U('chest_hair'),				name = 'chest_1',			value = 0,		min = 0,	zoomOffset = 0.75,		camOffset = 0.15},
	{label = _U('chest_hair_1'),			name = 'chest_2',			value = 0,		min = 0,	zoomOffset = 0.75,		camOffset = 0.15},
	{label = _U('chest_color'),				name = 'chest_3',			value = 0,		min = 0,	zoomOffset = 0.75,		camOffset = 0.15},
	{label = _U('bodyb'),					name = 'bodyb_1',			value = 0,		min = 0,	zoomOffset = 0.75,		camOffset = 0.15},
	{label = _U('bodyb_size'),				name = 'bodyb_2',			value = 0,		min = 0,	zoomOffset = 0.75,		camOffset = 0.15},
	{label = _U('wrinkles'),				name = 'age_1',				value = 0,		min = 0,	zoomOffset = 0.4,		camOffset = 0.65},
	{label = _U('wrinkle_thickness'),		name = 'age_2',				value = 0,		min = 0,	zoomOffset = 0.4,		camOffset = 0.65},
	{label = _U('blemishes'),				name = 'blemishes_1',		value = 0,		min = 0,	zoomOffset = 0.4,		camOffset = 0.65},
	{label = _U('blemishes_size'),			name = 'blemishes_2',		value = 0,		min = 0,	zoomOffset = 0.4,		camOffset = 0.65},
	{label = _U('blush'),					name = 'blush_1',			value = 0,		min = 0,	zoomOffset = 0.4,		camOffset = 0.65},
	{label = _U('blush_1'),					name = 'blush_2',			value = 0,		min = 0,	zoomOffset = 0.4,		camOffset = 0.65},
	{label = _U('blush_color'),				name = 'blush_3',			value = 0,		min = 0,	zoomOffset = 0.4,		camOffset = 0.65},
	{label = _U('complexion'),				name = 'complexion_1',		value = 0,		min = 0,	zoomOffset = 0.4,		camOffset = 0.65},
	{label = _U('complexion_1'),			name = 'complexion_2',		value = 0,		min = 0,	zoomOffset = 0.4,		camOffset = 0.65},
	{label = _U('sun'),						name = 'sun_1',				value = 0,		min = 0,	zoomOffset = 0.4,		camOffset = 0.65},
	{label = _U('sun_1'),					name = 'sun_2',				value = 0,		min = 0,	zoomOffset = 0.4,		camOffset = 0.65},
	{label = _U('freckles'),				name = 'moles_1',			value = 0,		min = 0,	zoomOffset = 0.4,		camOffset = 0.65},
	{label = _U('freckles_1'),				name = 'moles_2',			value = 0,		min = 0,	zoomOffset = 0.4,		camOffset = 0.65},
	{label = _U('beard_type'),				name = 'beard_1',			value = 0,		min = 0,	zoomOffset = 0.4,		camOffset = 0.65},
	{label = _U('beard_size'),				name = 'beard_2',			value = 0,		min = 0,	zoomOffset = 0.4,		camOffset = 0.65},
	{label = _U('beard_color_1'),			name = 'beard_3',			value = 0,		min = 0,	zoomOffset = 0.4,		camOffset = 0.65},
	{label = _U('beard_color_2'),			name = 'beard_4',			value = 0,		min = 0,	zoomOffset = 0.4,		camOffset = 0.65}
}

local Character		= {}

for i=1, #Components, 1 do
	Character[Components[i].name] = Components[i].value
end

AddEventHandler("HVC:openBarbershop",function()
	if not isSkinCreatorOpened then
		isCameraActive = true
		SkinCreator(true)
	end
end)

function GetMaxVals()
	local playerPed = PlayerPedId()

	local data = {
		sex				= 1,
		face			= 45,
		skin			= 45,
		age_1			= GetNumHeadOverlayValues(3)-1,
		age_2			= 10,
		beard_1			= GetNumHeadOverlayValues(1)-1,
		beard_2			= 10,
		beard_3			= GetNumHairColors()-1,
		beard_4			= GetNumHairColors()-1,
		hair_1			= GetNumberOfPedDrawableVariations(playerPed, 2),
		hair_2			= GetNumberOfPedTextureVariations(playerPed, 2, Character['hair_1']),
		hair_color_1	= GetNumHairColors(),
		hair_color_2	= GetNumHairColors(),
		eye_color		= 31,
		eyebrows_1		= GetNumHeadOverlayValues(2)-1,
		eyebrows_2		= 10,
		eyebrows_3		= GetNumHairColors()-1,
		eyebrows_4		= GetNumHairColors()-1,
		makeup_1		= GetNumHeadOverlayValues(4)-1,
		makeup_2		= 10,
		makeup_3		= GetNumHairColors()-1,
		makeup_4		= GetNumHairColors()-1,
		lipstick_1		= GetNumHeadOverlayValues(8)-1,
		lipstick_2		= 10,
		lipstick_3		= GetNumHairColors()-1,
		lipstick_4		= GetNumHairColors()-1,
		blemishes_1		= GetNumHeadOverlayValues(0)-1,
		blemishes_2		= 10,
		blush_1			= GetNumHeadOverlayValues(5)-1,
		blush_2			= 10,
		blush_3			= GetNumHairColors()-1,
		complexion_1	= GetNumHeadOverlayValues(6)-1,
		complexion_2	= 10,
		sun_1			= GetNumHeadOverlayValues(7)-1,
		sun_2			= 10,
		moles_1			= GetNumHeadOverlayValues(9)-1,
		moles_2			= 10,
		chest_1			= GetNumHeadOverlayValues(10)-1,
		chest_2			= 10,
		chest_3			= GetNumHairColors()-1,
		bodyb_1			= GetNumHeadOverlayValues(11)-1,
		bodyb_2			= 10,
	}

	return data
end

AddEventHandler('skinchanger:getData', function(cb)
	local components = json.decode(json.encode(Components))

	for k,v in pairs(Character) do
		for i=1, #components, 1 do
			if k == components[i].name then
				components[i].value = v
			end
		end
	end

	cb(components, GetMaxVals())
end)


RegisterNUICallback('updateLeftWristComponent', function(data)
	data.componentID = math.floor(data.componentID + 0)
	SetPedPropIndex(PlayerPedId(), 6, data.componentID, 0, 2)
end)

RegisterNUICallback('updateLeftWristTexture', function(data)
	data.componentID = math.floor(data.componentID - 1)
	data.textureID = math.floor(data.textureID + 0)
	SetPedPropIndex(PlayerPedId(), 6, data.componentID, data.textureID, 2)
end)

RegisterNUICallback('updateRightWristComponent', function(data)
	data.componentID = math.floor(data.componentID + 0)
	SetPedPropIndex(PlayerPedId(), 7, data.componentID, 0, 2)
end)

RegisterNUICallback('updateRightWristTexture', function(data)
	data.componentID = math.floor(data.componentID - 1)
	data.textureID = math.floor(data.textureID + 0)
	SetPedPropIndex(PlayerPedId(), 7, data.componentID, data.textureID, 2)
end)

RegisterNUICallback('updateSkin', function(data)
	v = data.value
	dad = tonumber(data.dad)
	mum = tonumber(data.mum)
	dadmumpercent = tonumber(data.dadmumpercent)
	skin = tonumber(data.skin)
	eyecolor = tonumber(data.eyecolor)
	acne = tonumber(data.acne)
	skinproblem = tonumber(data.skinproblem)
	freckle = tonumber(data.freckle)
	wrinkle = tonumber(data.wrinkle)
	wrinkleopacity = tonumber(data.wrinkleopacity)
	hair = tonumber(data.hair)
	haircolor = tonumber(data.haircolor)
	eyebrow = tonumber(data.eyebrow)
	eyebrowopacity = tonumber(data.eyebrowopacity)
	beard = tonumber(data.beard)
	beardopacity = tonumber(data.beardopacity)
	beardcolor = tonumber(data.beardcolor)
	hats = tonumber(data.hats)
	hats_texture = tonumber(data.hats_texture)
	glasses = tonumber(data.glasses)
	glasses_texture = tonumber(data.glasses_texture)
	ears = tonumber(data.ears)
	tops = tonumber(data.tops)
	pants = tonumber(data.pants)
	shoes = tonumber(data.shoes)
	watches = tonumber(data.watches)
	lipstick = tonumber(data.lipstick)
	lipstickcolour = tonumber(data.lipstickcolour)
	eyeshadow = tonumber(data.eyeshadow)
	eyeshadowcolour = tonumber(data.eyeshadowcolour)

	if(v == true) then	
		CloseSkinCreator()
	else
		
		local currentGender = nil
		local model = GetEntityModel(PlayerPedId())
		if model == GetHashKey('mp_m_freemode_01') then
			currentGender = "mp_m_freemode_01"
			if dadmumpercent > 5 then
				local player = PlayerId()
				local model = GetHashKey('mp_f_freemode_01')

				RequestModel(model)
				while not HasModelLoaded(model) do
					Wait(100)
				end

				SetModelAsNoLongerNeeded(model)
			end
		elseif model == GetHashKey('mp_f_freemode_01') then
			currentGender = "mp_f_freemode_01"
			if dadmumpercent <= 5 then
				local player = PlayerId()
				local model = GetHashKey('mp_m_freemode_01')

				RequestModel(model)
				while not HasModelLoaded(model) do
					Wait(100)
				end
				SetModelAsNoLongerNeeded(model)
			end
		end

		dadmumpercent = tonumber(data.dadmumpercent)/10+0.0
		SetPedHeadBlendData(PlayerPedId(), dad, mum, 0, skin, skin, skin, dadmumpercent, dadmumpercent, 0.0, false)
		
		SetPedEyeColor				(PlayerPedId(), eyecolor)
		if acne == 0 then
			SetPedHeadOverlay		(PlayerPedId(), 0, acne, 0.0)
		else
			SetPedHeadOverlay		(PlayerPedId(), 0, acne, 1.0)
		end
		SetPedHeadOverlay			(PlayerPedId(), 6, skinproblem, 1.0)
		if freckle == 0 then
			SetPedHeadOverlay		(PlayerPedId(), 9, freckle, 0.0)
		else
			SetPedHeadOverlay		(PlayerPedId(), 9, freckle, 1.0)
		end
		
		SetPedHeadOverlay       	(PlayerPedId(), 3, wrinkle, wrinkleopacity * 0.1)
		SetPedComponentVariation	(PlayerPedId(), 2, hair, 0, 2)
		SetPedHairColor				(PlayerPedId(), haircolor, haircolor)
		SetPedHeadOverlay       	(PlayerPedId(), 2, eyebrow, eyebrowopacity * 0.1) 
		SetPedHeadOverlay       	(PlayerPedId(), 1, beard, beardopacity * 0.1)   
		SetPedHeadOverlayColor  	(PlayerPedId(), 1, 1, beardcolor, beardcolor) 
		SetPedHeadOverlayColor  	(PlayerPedId(), 2, 1, beardcolor, beardcolor)
	
		eyeShadowOpacity = 1.0
		if eyeshadow == 0 then 
			eyeShadowOpacity = 0.0 
		end
		lipstickOpacity = 1.0
		if lipstick == 0 then 
			lipstickOpacity = 0.0 
		end
		SetPedHeadOverlay       	(PlayerPedId(), 4, eyeshadow, eyeShadowOpacity)  
		SetPedHeadOverlay       	(PlayerPedId(), 8, lipstick, lipstickOpacity) 	
		SetPedHeadOverlayColor  	(PlayerPedId(), 4, 1, eyeshadowcolour, eyeshadowcolour)     
		SetPedHeadOverlayColor  	(PlayerPedId(), 8, 1, lipstickcolour, lipstickcolour)      
		SetPedComponentVariation	(PlayerPedId(), 1,  0,0, 2)

		faceSaveData = {}
		faceSaveData["dad"] = dad
		faceSaveData["mum"] = mum
		faceSaveData["skin"] = skin
		faceSaveData["dadmumpercent"] = dadmumpercent
		faceSaveData["eyecolor"] = eyecolor
		faceSaveData["acne"] = acne
		faceSaveData["skinproblem"] = skinproblem
		faceSaveData["freckle"] = freckle
		faceSaveData["wrinkle"] = wrinkle
		faceSaveData["wrinkleopacity"] = wrinkleopacity
		faceSaveData["hair"] = hair
		faceSaveData["haircolor"] = haircolor
		faceSaveData["eyebrow"] = eyebrow
		faceSaveData["eyebrowopacity"] = eyebrowopacity
		faceSaveData["beard"] = beard
		faceSaveData["beardopacity"] = beardopacity
		faceSaveData["beardcolor"] = beardcolor
		faceSaveData["eyeshadow"] = eyeshadow
		faceSaveData["lipstick"] = lipstick
		faceSaveData["eyeshadowcolour"] = eyeshadowcolour
		faceSaveData["lipstickcolour"] = lipstickcolour

		TriggerServerEvent("HVC:SavePedData",faceSaveData)
	end
end)

RegisterNUICallback('rotateleftheading', function(data)
	local currentHeading = GetEntityHeading(PlayerPedId())
	SetEntityHeading(PlayerPedId(),currentHeading-10)
end)

RegisterNUICallback('rotaterightheading', function(data)
	local currentHeading = GetEntityHeading(PlayerPedId())
	SetEntityHeading(PlayerPedId(),currentHeading+10)
end)

RegisterNUICallback('zoom', function(data)
	zoom = data.zoom
	local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
	if zoom == "visage" or zoom == "pilosite" then
		SetCamCoord(cam, x+0.2, y+0.5, z+0.7)
		SetCamRot(cam, 0.0, 0.0, 150.0)
	elseif zoom == "vetements" then
		SetCamCoord(cam, x+0.3, y+2.0, z+0.3)
		SetCamRot(cam, 0.0, 0.0, 170.0)
	end
end)

RegisterNUICallback('zoomin', function(data)
	local x,y,z = table.unpack(GetCamCoord(cam))
	SetCamFov(cam, GetCamFov(cam)-1.0)
end)

RegisterNUICallback('zoomout', function(data)
	local x,y,z = table.unpack(GetCamCoord(cam))
	SetCamFov(cam, GetCamFov(cam)+1.0)
end)

function CloseSkinCreator()
	local ped = PlayerPedId()
	isSkinCreatorOpened = false
	ShowSkinCreator(false)
	isCameraActive = false
	SetCamActive(cam, false)
	RenderScriptCams(false, true, 500, true, true)
	cam = nil
	SetPlayerInvincible(ped, false)
end

function ShowSkinCreator(enable)
	local elements    = {}
	TriggerEvent('skinchanger:getData', function(components, maxVals)
		local _components = {}

		for i=1, #components, 1 do
			_components[i] = components[i]
		end

		-- Insert elements
		for i=1, #_components, 1 do
			local value       = _components[i].value
			local componentId = _components[i].componentId

			if componentId == 0 then
				value = GetPedPropIndex(playerPed,  _components[i].componentId)
			end

			local data = {
				label     = _components[i].label,
				name      = _components[i].name,
				value     = value,
				min       = _components[i].min,
			}

			for k,v in pairs(maxVals) do
				if k == _components[i].name then
					data.max = v
					break
				end
			end

			table.insert(elements, data)
		end
	end)
	
	SetNuiFocus(enable, enable)
	SendNUIMessage({
		openSkinCreator = enable,
	})
	
	for index, data in ipairs(elements) do
		local name, Valmax

		for key, value in pairs(data) do
			if key == 'name' then
				name = value
			end
			if key == 'max' then
				Valmax = value
			end
		end
		
		SendNUIMessage({
			type = "updateMaxVal",
			classname = name,
			maxVal = Valmax
		})
	end
end

function SkinCreator(enable)
	local ped = PlayerPedId()
	ShowSkinCreator(enable)

	if enable == true then
		DisableControlAction(2, 14, true)
		DisableControlAction(2, 15, true)
		DisableControlAction(2, 16, true)
		DisableControlAction(2, 17, true)
		DisableControlAction(2, 30, true)
		DisableControlAction(2, 31, true)
		DisableControlAction(2, 32, true)
		DisableControlAction(2, 33, true)
		DisableControlAction(2, 34, true)
		DisableControlAction(2, 35, true)
		DisableControlAction(0, 25, true)
		DisableControlAction(0, 24, true)

		if IsDisabledControlJustReleased(0, 24) or IsDisabledControlJustReleased(0, 142) then -- MeleeAttackAlternate
			SendNUIMessage({type = "click"})
		end

		SetPlayerInvincible(ped, true)

		RenderScriptCams(false, false, 0, 1, 0)
		Citizen.CreateThread(function()
			cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
			SetCamCoord(cam, GetEntityCoords(PlayerPedId()))
			SetCamRot(cam, 0.0, 0.0, 0.0)
			SetCamActive(cam,  true)
			RenderScriptCams(true,  false,  0,  true,  true)
			SetCamCoord(cam, GetEntityCoords(PlayerPedId()))
			local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
			if zoom == "visage" or zoom == "pilosite" then
				SetCamCoord(cam, x+0.2, y+0.5, z+0.7)
				SetCamRot(cam, 0.0, 0.0, 150.0)
			elseif zoom == "vetements" then
				SetCamCoord(cam, x+0.3, y+2.0, z-1.0)
				SetCamRot(cam, 0.0, 0.0, 170.0)
			end
		end)
	else
		FreezeEntityPosition(ped, false)
		SetPlayerInvincible(ped, false)
	end
end


Citizen.CreateThread(function() 
	while true do
		if isSkinCreatorOpened then
			InvalidateIdleCam()
		end
		Wait(1000)
	end 
end)