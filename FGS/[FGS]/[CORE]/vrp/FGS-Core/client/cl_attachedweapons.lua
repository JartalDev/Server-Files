local Weapons = {}
-----------------------------------------------------------
-----------------------------------------------------------
ConfigWeaponsAttached = {
	--[[
	{name = 'WEAPON_KNIFE', 			bone = 24818, x = 65536.0, y = 65536.0, z = 65536.0, xRot = 0.0, yRot = 0.0, zRot = 0.0, category = 'melee', 		model = 'prop_w_me_knife_01'},
	{name = 'WEAPON_NIGHTSTICK', 		bone = 24818, x = 65536.0, y = 65536.0, z = 65536.0, xRot = 0.0, yRot = 0.0, zRot = 0.0, category = 'melee', 		model = 'w_me_nightstick'},
	{name = 'WEAPON_HAMMER', 			bone = 24818, x = 65536.0, y = 65536.0, z = 65536.0, xRot = 0.0, yRot = 0.0, zRot = 0.0, category = 'melee', 		model = 'prop_tool_hammer'},
	{name = 'WEAPON_BAT', 				bone = 24818, x = 0.0, y = 0.0, z = 0.0, xRot = 320.0, yRot = 320.0, zRot = 320.0, category = 'melee', 		model = 'w_me_bat'},
	{name = 'WEAPON_GOLFCLUB', 			bone = 24818, x = 65536.0, y = 65536.0, z = 65536.0, xRot = 0.0, yRot = 0.0, zRot = 0.0, category = 'melee', 		model = 'w_me_gclub'},
	{name = 'WEAPON_CROWBAR', 			bone = 24818, x = 65536.0, y = 65536.0, z = 65536.0, xRot = 0.0, yRot = 0.0, zRot = 0.0, category = 'melee', 		model = 'w_me_crowbar'},
	{name = 'WEAPON_BOTTLE', 			bone = 24818, x = 65536.0, y = 65536.0, z = 65536.0, xRot = 0.0, yRot = 0.0, zRot = 0.0, category = 'melee', 		model = 'prop_w_me_bottle'},
	{name = 'WEAPON_KNUCKLE', 			bone = 24818, x = 65536.0, y = 65536.0, z = 65536.0, xRot = 0.0, yRot = 0.0, zRot = 0.0, category = 'melee', 		model = 'prop_w_me_dagger'},
	{name = 'WEAPON_HATCHET', 			bone = 24818, x = 65536.0, y = 65536.0, z = 65536.0, xRot = 0.0, yRot = 0.0, zRot = 0.0, category = 'melee', 		model = 'w_me_hatchet'},
	{name = 'WEAPON_MACHETE', 			bone = 24818, x = 65536.0, y = 65536.0, z = 65536.0, xRot = 0.0, yRot = 0.0, zRot = 0.0, category = 'melee', 		model = 'prop_ld_w_me_machette'},
	{name = 'WEAPON_SWITCHBLADE', 		bone = 24818, x = 65536.0, y = 65536.0, z = 65536.0, xRot = 0.0, yRot = 0.0, zRot = 0.0, category = 'melee', 		model = 'prop_w_me_dagger'},
	{name = 'WEAPON_FLASHLIGHT', 		bone = 24818, x = 0.0, y = 0.0, z = 0.0, xRot = 0.0, yRot = 0.0, zRot = 0.0, category = 'melee', 		model = 'prop_w_me_dagger'},

	{name = 'WEAPON_PISTOL', 			bone = 51826, x = -0.01, y = 0.10, z = 0.07,  xRot = -115.0, yRot = 0.0,  zRot = 0.0, category = 'handguns', 	model = 'w_pi_pistol'},
	{name = 'WEAPON_COMBATPISTOL', 		bone = 51826, x = -0.01, y = 0.10, z = 0.07,  xRot = -115.0, yRot = 0.0,  zRot = 0.0, category = 'handguns', 	model = 'w_pi_combatpistol'},
	{name = 'WEAPON_APPISTOL', 			bone = 51826, x = -0.01, y = 0.10, z = 0.07,  xRot = -115.0, yRot = 0.0,  zRot = 0.0, category = 'handguns', 	model = 'w_pi_appistol'},
	{name = 'WEAPON_PISTOL50', 			bone = 51826, x = -0.01, y = 0.10, z = 0.07,  xRot = -115.0, yRot = 0.0,  zRot = 0.0, category = 'handguns', 	model = 'w_pi_pistol50'},
	{name = 'WEAPON_VINTAGEPISTOL', 	bone = 51826, x = -0.01, y = 0.10, z = 0.07,  xRot = -115.0, yRot = 0.0,  zRot = 0.0, category = 'handguns', 	model = 'w_pi_vintage_pistol'},
	{name = 'WEAPON_HEAVYPISTOL', 		bone = 51826, x = -0.01, y = 0.10, z = 0.07,  xRot = -115.0, yRot = 0.0,  zRot = 0.0, category = 'handguns', 	model = 'w_pi_heavypistol'},
	{name = 'WEAPON_SNSPISTOL', 		bone = 58271, x = -0.01, y = 0.1,  z = -0.07, xRot = -55.0,  yRot = 0.10, zRot = 0.0, category = 'handguns', 	model = 'w_pi_sns_pistol'},
	{name = 'WEAPON_FLAREGUN', 			bone = 58271, x = -0.01, y = 0.1,  z = -0.07, xRot = -55.0,  yRot = 0.10, zRot = 0.0, category = 'handguns', 	model = 'w_pi_flaregun'},
	{name = 'WEAPON_MARKSMANPISTOL', 	bone = 58271, x = -0.01, y = 0.1,  z = -0.07, xRot = -55.0,  yRot = 0.10, zRot = 0.0, category = 'handguns', 	model = ''},
	{name = 'WEAPON_REVOLVER', 			bone = 58271, x = -0.01, y = 0.1,  z = -0.07, xRot = -55.0,  yRot = 0.10, zRot = 0.0, category = 'handguns', 	model = ''},
	{name = 'WEAPON_STUNGUN', 			bone = 58271, x = -0.01, y = 0.1,  z = -0.07, xRot = -55.0,  yRot = 0.10, zRot = 0.0, category = 'handguns', 	model = 'w_pi_stungun'},

	{name = 'WEAPON_MICROSMG', 			bone = 24818, x = 65536.0, y = 65536.0, z = 65536.0, xRot = 0.0, yRot = 0.0, zRot = 0.0, category = 'machine', 	model = 'w_sb_microsmg'},
	{name = 'WEAPON_SMG', 				bone = 24818, x = 65536.0, y = 65536.0, z = 65536.0, xRot = 0.0, yRot = 0.0, zRot = 0.0, category = 'machine', 	model = 'w_sb_smg'},
	{name = 'WEAPON_MG', 				bone = 24818, x = 65536.0, y = 65536.0, z = 65536.0, xRot = 0.0, yRot = 0.0, zRot = 0.0, category = 'machine', 	model = 'w_mg_mg'},
	{name = 'WEAPON_COMBATMG', 			bone = 24818, x = 65536.0, y = 65536.0, z = 65536.0, xRot = 0.0, yRot = 0.0, zRot = 0.0, category = 'machine', 	model = 'w_mg_combatmg'},
	{name = 'WEAPON_GUSENBERG', 		bone = 24818, x = 65536.0, y = 65536.0, z = 65536.0, xRot = 0.0, yRot = 0.0, zRot = 0.0, category = 'machine', 	model = 'w_sb_gusenberg'},
	{name = 'WEAPON_COMBATPDW', 		bone = 24818, x = 65536.0, y = 65536.0, z = 65536.0, xRot = 0.0, yRot = 0.0, zRot = 0.0, category = 'machine', 	model = ''},
	{name = 'WEAPON_MACHINEPISTOL', 	bone = 24818, x = 65536.0, y = 65536.0, z = 65536.0, xRot = 0.0, yRot = 0.0, zRot = 0.0, category = 'machine', 	model = ''},
	{name = 'WEAPON_ASSAULTSMG', 		bone = 24818, x = 65536.0, y = 65536.0, z = 65536.0, xRot = 0.0, yRot = 0.0, zRot = 0.0, category = 'machine', 	model = 'w_sb_assaultsmg'},
	{name = 'WEAPON_MINISMG', 			bone = 24818, x = 65536.0, y = 65536.0, z = 65536.0, xRot = 0.0, yRot = 0.0, zRot = 0.0, category = 'machine', 	model = ''},

	{name = 'WEAPON_ASSAULTRIFLE', 		bone = 24818, x = 65536.0, y = 65536.0, z = 65536.0, xRot = 0.0, yRot = 0.0, zRot = 0.0, category = 'assault', 	model = 'w_ar_assaultrifle'},
	{name = 'WEAPON_CARBINERIFLE', 		bone = 24818, x = 65536.0, y = 65536.0, z = 65536.0, xRot = 0.0, yRot = 0.0, zRot = 0.0, category = 'assault', 	model = 'w_ar_carbinerifle'},
	{name = 'WEAPON_ADVANCEDRIFLE', 	bone = 24818, x = 65536.0, y = 65536.0, z = 65536.0, xRot = 0.0, yRot = 0.0, zRot = 0.0, category = 'assault', 	model = 'w_ar_advancedrifle'},
	{name = 'WEAPON_SPECIALCARBINE', 	bone = 24818, x = 65536.0, y = 65536.0, z = 65536.0, xRot = 0.0, yRot = 0.0, zRot = 0.0, category = 'assault', 	model = 'w_ar_specialcarbine'},
	{name = 'WEAPON_BULLPUPRIFLE', 		bone = 24818, x = 65536.0, y = 65536.0, z = 65536.0, xRot = 0.0, yRot = 0.0, zRot = 0.0, category = 'assault', 	model = 'w_ar_bullpuprifle'},
	{name = 'WEAPON_COMPACTRIFLE', 		bone = 24818, x = 65536.0, y = 65536.0, z = 65536.0, xRot = 0.0, yRot = 0.0, zRot = 0.0, category = 'assault', 	model = ''},

	{name = 'WEAPON_PUMPSHOTGUN', 		bone = 24818, x = 0.1, y = -0.15, z = 0.0, xRot = 0.0, yRot = 135.0, zRot = 0.0, category = 'shotgun', 	model = 'w_sg_pumpshotgun'},
	{name = 'WEAPON_SAWNOFFSHOTGUN', 	bone = 24818, x = 0.1, y = -0.15, z = 0.0, xRot = 0.0, yRot = 0.0, zRot = 0.0, category = 'shotgun', 	model = ''},
	{name = 'WEAPON_BULLPUPSHOTGUN', 	bone = 24818, x = 0.1, y = -0.15, z = 0.0, xRot = 0.0, yRot = 135.0, zRot = 0.0, category = 'shotgun', 	model = 'w_sg_bullpupshotgun'},
	{name = 'WEAPON_ASSAULTSHOTGUN', 	bone = 24818, x = 0.1, y = -0.15, z = 0.0, xRot = 0.0, yRot = 0.0, zRot = 0.0, category = 'shotgun', 	model = 'w_sg_assaultshotgun'},
	{name = 'WEAPON_MUSKET', 			bone = 24818, x = 0.1, y = -0.15, z = 0.0, xRot = 0.0, yRot = 0.0, zRot = 0.0, category = 'shotgun', 	model = 'w_ar_musket'},
	{name = 'WEAPON_HEAVYSHOTGUN', 		bone = 24818, x = 0.1, y = -0.15, z = 0.0, xRot = 0.0, yRot = 225.0, zRot = 0.0, category = 'shotgun', 	model = 'w_sg_heavyshotgun'},
	{name = 'WEAPON_DBSHOTGUN', 		bone = 24818, x = 0.1, y = -0.15, z = 0.0, xRot = 0.0, yRot = 0.0, zRot = 0.0, category = 'shotgun', 	model = ''},
	{name = 'WEAPON_AUTOSHOTGUN', 		bone = 24818, x = 0.1, y = 0.15, z = 0.0, xRot = 0.0, yRot = 0.0, zRot = 0.0, category = 'shotgun', 	model = ''},

	{name = 'WEAPON_SNIPERRIFLE', 		bone = 24818, x = 65536.0, y = 65536.0, z = 65536.0, xRot = 0.0, yRot = 0.0, zRot = 0.0, category = 'sniper', 	model = 'w_sr_sniperrifle'},
	{name = 'WEAPON_HEAVYSNIPER', 		bone = 24818, x = 0.1, y = -0.15, z = 0.0, xRot = 0.0, yRot = 135.0, zRot = 0.0, category = 'sniper', 	model = 'w_sr_heavysniper'},
	{name = 'WEAPON_MARKSMANRIFLE', 	bone = 24818, x = 0.1, y = -0.15, z = 0.0, xRot = 0.0, yRot = 135.0, zRot = 0.0, category = 'sniper', 	model = 'w_sr_marksmanrifle'},

	{name = 'WEAPON_REMOTESNIPER', 		bone = 24818, x = 65536.0, y = 65536.0, z = 65536.0, xRot = 0.0, yRot = 0.0, zRot = 0.0, category = 'none', 		model = ''},
	{name = 'WEAPON_STINGER', 			bone = 24818, x = 65536.0, y = 65536.0, z = 65536.0, xRot = 0.0, yRot = 0.0, zRot = 0.0, category = 'none', 		model = ''},

	{name = 'WEAPON_GRENADELAUNCHER', 	bone = 24818, x = 65536.0, y = 65536.0, z = 65536.0, xRot = 0.0, yRot = 0.0, zRot = 0.0, category = 'heavy', 		model = 'w_lr_grenadelauncher'},
	{name = 'WEAPON_RPG', 				bone = 24818, x = 65536.0, y = 65536.0, z = 65536.0, xRot = 0.0, yRot = 0.0, zRot = 0.0, category = 'heavy', 		model = 'w_lr_rpg'},
	{name = 'WEAPON_MINIGUN', 			bone = 24818, x = 65536.0, y = 65536.0, z = 65536.0, xRot = 0.0, yRot = 0.0, zRot = 0.0, category = 'heavy', 		model = 'w_mg_minigun'},
	{name = 'WEAPON_FIREWORK', 			bone = 24818, x = 65536.0, y = 65536.0, z = 65536.0, xRot = 0.0, yRot = 0.0, zRot = 0.0, category = 'heavy', 		model = 'w_lr_firework'},
	{name = 'WEAPON_RAILGUN', 			bone = 24818, x = 65536.0, y = 65536.0, z = 65536.0, xRot = 0.0, yRot = 0.0, zRot = 0.0, category = 'heavy', 		model = 'w_ar_railgun'},
	{name = 'WEAPON_HOMINGLAUNCHER', 	bone = 24818, x = 65536.0, y = 65536.0, z = 65536.0, xRot = 0.0, yRot = 0.0, zRot = 0.0, category = 'heavy', 		model = 'w_lr_homing'},
	{name = 'WEAPON_COMPACTLAUNCHER', 	bone = 24818, x = 65536.0, y = 65536.0, z = 65536.0, xRot = 0.0, yRot = 0.0, zRot = 0.0, category = 'heavy', 		model = ''},

	{name = 'WEAPON_STICKYBOMB', 		bone = 24818, x = 65536.0, y = 65536.0, z = 65536.0, xRot = 0.0, yRot = 0.0, zRot = 0.0, category = 'thrown', 	model = 'prop_bomb_01_s'},
	{name = 'WEAPON_MOLOTOV', 			bone = 24818, x = 65536.0, y = 65536.0, z = 65536.0, xRot = 0.0, yRot = 0.0, zRot = 0.0, category = 'thrown', 	model = 'w_ex_molotov'},
	{name = 'WEAPON_FIREEXTINGUISHER', 	bone = 24818, x = 65536.0, y = 65536.0, z = 65536.0, xRot = 0.0, yRot = 0.0, zRot = 0.0, category = 'thrown', 	model = 'w_am_fire_exting'},
	{name = 'WEAPON_PETROLCAN', 		bone = 24818, x = 65536.0, y = 65536.0, z = 65536.0, xRot = 0.0, yRot = 0.0, zRot = 0.0, category = 'thrown', 	model = 'w_am_jerrycan'},
	{name = 'WEAPON_PROXMINE', 			bone = 24818, x = 65536.0, y = 65536.0, z = 65536.0, xRot = 0.0, yRot = 0.0, zRot = 0.0, category = 'thrown', 	model = ''},
	{name = 'WEAPON_SNOWBALL', 			bone = 24818, x = 65536.0, y = 65536.0, z = 65536.0, xRot = 0.0, yRot = 0.0, zRot = 0.0, category = 'thrown', 	model = 'w_ex_snowball'},
	{name = 'WEAPON_BALL', 				bone = 24818, x = 65536.0, y = 65536.0, z = 65536.0, xRot = 0.0, yRot = 0.0, zRot = 0.0, category = 'thrown', 	model = 'w_am_baseball'},
	{name = 'WEAPON_GRENADE', 			bone = 24818, x = 65536.0, y = 65536.0, z = 65536.0, xRot = 0.0, yRot = 0.0, zRot = 0.0, category = 'thrown', 	model = 'w_ex_grenadefrag'},
	{name = 'WEAPON_SMOKEGRENADE', 		bone = 24818, x = 65536.0, y = 65536.0, z = 65536.0, xRot = 0.0, yRot = 0.0, zRot = 0.0, category = 'thrown', 	model = 'w_ex_grenadesmoke'},
	{name = 'WEAPON_BZGAS', 			bone = 24818, x = 65536.0, y = 65536.0, z = 65536.0, xRot = 0.0, yRot = 0.0, zRot = 0.0, category = 'thrown', 	model = 'w_ex_grenadesmoke'},

	{name = 'WEAPON_DIGISCANNER', 		bone = 24818, x = 65536.0, y = 65536.0, z = 65536.0, xRot = 0.0, yRot = 0.0, zRot = 0.0, category = 'others', 	model = 'w_am_digiscanner'},
	{name = 'WEAPON_DAGGER', 			bone = 24818, x = 65536.0, y = 65536.0, z = 65536.0, xRot = 0.0, yRot = 0.0, zRot = 0.0, category = 'others', 	model = 'prop_w_me_dagger'},
	{name = 'WEAPON_GARBAGEBAG', 		bone = 24818, x = 65536.0, y = 65536.0, z = 65536.0, xRot = 0.0, yRot = 0.0, zRot = 0.0, category = 'others', 	model = ''},
	{name = 'WEAPON_HANDCUFFS', 		bone = 24818, x = 65536.0, y = 65536.0, z = 65536.0, xRot = 0.0, yRot = 0.0, zRot = 0.0, category = 'others', 	model = ''},
	{name = 'WEAPON_BATTLEAXE', 		bone = 24818, x = 65536.0, y = 65536.0, z = 65536.0, xRot = 0.0, yRot = 0.0, zRot = 0.0, category = 'others', 	model = 'prop_tool_fireaxe'},
	{name = 'WEAPON_PIPEBOMB', 			bone = 24818, x = 65536.0, y = 65536.0, z = 65536.0, xRot = 0.0, yRot = 0.0, zRot = 0.0, category = 'others', 	model = ''},
	{name = 'WEAPON_POOLCUE', 			bone = 24818, x = 65536.0, y = 65536.0, z = 65536.0, xRot = 0.0, yRot = 0.0, zRot = 0.0, category = 'others', 	model = 'prop_pool_cue'},
	{name = 'WEAPON_WRENCH', 			bone = 24818, x = 65536.0, y = 65536.0, z = 65536.0, xRot = 0.0, yRot = 0.0, zRot = 0.0, category = 'others', 	model = 'w_me_hammer'},
	{name = 'GADGET_NIGHTVISION', 		bone = 24818, x = 65536.0, y = 65536.0, z = 65536.0, xRot = 0.0, yRot = 0.0, zRot = 0.0, category = 'others', 	model = ''},
	{name = 'GADGET_PARACHUTE', 		bone = 24818, x = 65536.0, y = 65536.0, z = 65536.0, xRot = 0.0, yRot = 0.0, zRot = 0.0, category = 'others', 	model = 'p_parachute_s'}
	]]

	-- [[ Black Market ]]--
	{name = 'WEAPON_ACR1',    bone = 24818, x = -0.12,    y = -0.12,     z = -0.13,     xRot = 100.0, yRot = -3.0, zRot = 5.0, category = 'assault', 	model = 'w_ar_acr1'},
	{name = 'WEAPON_AKM', 		    bone = 24818, x = -0.12,    y = -0.12,     z = -0.13,     xRot = 100.0, yRot = -3.0, zRot = 5.0, category = 'assault', 	model = 'w_ar_akm'},
	{name = 'WEAPON_MOSIN', 		bone = 24818, x = -0.12,    y = -0.14,     z = -0.13,     xRot = 100.0, yRot = -3.0, zRot = 5.0, category = 'assault', 	model = 'w_ar_mosin'},
	{name = 'WEAPON_UMP45', 	        bone = 51826, x = 0.10,    y = 0.00,     z = 0.13,     xRot = -100.0, yRot = 0.0, zRot = 5.0, category = 'shotgun', 	model = 'w_sb_ump45'},
	{name = 'WEAPON_BLACKOPSSMG', 	        bone = 51826, x = 0.10,    y = 0.00,     z = 0.13,     xRot = -100.0, yRot = 0.0, zRot = 5.0, category = 'shotgun', 	model = 'w_sb_blackopssmg'},
	{name = 'WEAPON_MP5SDFGS', 	        bone = 51826, x = 0.10,    y = 0.00,     z = 0.13,     xRot = -100.0, yRot = 0.0, zRot = 5.0, category = 'shotgun', 	model = 'w_sb_mp5sdFGS'},
	{name = 'WEAPON_UWUDUBZYLILLI', 	        bone = 51826, x = 0.10,    y = 0.00,     z = 0.13,     xRot = -100.0, yRot = 0.0, zRot = 5.0, category = 'shotgun', 	model = 'w_sb_uwudubzylilli'},

	-- [[ Rebel ]]--
	{name = 'WEAPON_AK200', 		    bone = 24818, x = -0.12,    y = -0.12,     z = -0.13,     xRot = 100.0, yRot = -3.0, zRot = 5.0, category = 'assault', 	model = 'w_ar_ak200'},
	{name = 'WEAPON_M870', 		    bone = 24818, x = -0.12,    y = -0.14,     z = -0.13,     xRot = 100.0, yRot = -3.0, zRot = 5.0, category = 'assault', 	model = 'w_sr_m870'},
	{name = 'WEAPON_R700', 		    bone = 24818, x = -0.12,    y = -0.14,     z = -0.13,     xRot = 100.0, yRot = -3.0, zRot = 5.0, category = 'assault', 	model = 'w_sr_r700'},
	{name = 'WEAPON_BLACKOPSSNIPER', 		    bone = 24818, x = -0.12,    y = -0.14,     z = -0.13,     xRot = 100.0, yRot = -3.0, zRot = 5.0, category = 'assault', 	model = 'w_sr_blackopssniper'},
	{name = 'WEAPON_M16A4', 		    bone = 24818, x = -0.12,    y = -0.12,     z = -0.13,     xRot = 100.0, yRot = -3.0, zRot = 5.0, category = 'assault', 	model = 'w_ar_m16a4'},
	{name = 'WEAPON_SCAR', 		    bone = 24818, x = -0.12,    y = -0.12,     z = -0.13,     xRot = 100.0, yRot = -3.0, zRot = 5.0, category = 'assault', 	model = 'w_ar_scar'},
	{name = 'WEAPON_WINCHESTER12', 	bone = 24818, x = -0.22,    y = -0.15,     z = -0.13,     xRot = 100.0, yRot = -3.0, zRot = 5.0, category = 'shotgun', 	model = 'w_sg_winchester12'},
	{name = 'WEAPON_MP5X', 	bone = 24818, x = 0.00,    y = 0.25,     z = -0.03,     xRot = 165.0, yRot = 135.0, zRot = 5.0, category = 'assault', 	model = 'w_sb_mp5x'},
	{name = 'WEAPON_G36C', 	bone = 24818, x = 0.00,    y = 0.25,     z = -0.03,     xRot = 165.0, yRot = 135.0, zRot = 5.0, category = 'assault', 	model = 'w_ar_g36c'},
	{name = 'WEAPON_SIGMPX', 	bone = 24818, x = 0.00,    y = 0.25,     z = -0.03,     xRot = 165.0, yRot = 135.0, zRot = 5.0, category = 'assault', 	model = 'w_ar_sigmpx'},
	{name = 'WEAPON_SCARL', 	bone = 24818, x = -0.22,    y = -0.15,     z = -0.13,     xRot = 100.0, yRot = -3.0, zRot = 5.0, category = 'assault', 	model = 'w_ar_scarl'},
	{name = 'WEAPON_VESPER', 	        bone = 51826, x = 0.15,    y = 0.06,     z = 0.13,     xRot = -100.0, yRot = 0.0, zRot = 5.0, category = 'shotgun', 	model = 'w_sb_vesper'},
	{name = 'WEAPON_LIQUIDCARBINE', 	bone = 24818, x = -0.22,    y = -0.15,     z = -0.13,     xRot = 100.0, yRot = -3.0, zRot = 5.0, category = 'assault', 	model = 'w_ar_liquidcarbine'},
	{name = 'WEAPON_M4SICARIO', 	bone = 24818, x = -0.22,    y = -0.15,     z = -0.13,     xRot = 100.0, yRot = -3.0, zRot = 5.0, category = 'assault', 	model = 'w_ar_m4sicario'},
	{name = 'WEAPON_GAMBINO', 	bone = 24818, x = -0.22,    y = -0.15,     z = -0.13,     xRot = 100.0, yRot = -3.0, zRot = 5.0, category = 'assault', 	model = 'w_ar_gambino'},
	{name = 'WEAPON_ELDERVANDAL', 	bone = 24818, x = -0.22,    y = -0.15,     z = -0.13,     xRot = 100.0, yRot = -3.0, zRot = 5.0, category = 'assault', 	model = 'w_ar_eldervandal'},
	{name = 'WEAPON_M4A1SPURPLE', 	bone = 24818, x = -0.22,    y = -0.15,     z = -0.13,     xRot = 100.0, yRot = -3.0, zRot = 5.0, category = 'assault', 	model = 'w_ar_m4a1spurple'},
	{name = 'WEAPON_NSR', 	bone = 24818, x = 0.00,    y = 0.25,     z = -0.03,     xRot = 165.0, yRot = 135.0, zRot = 5.0, category = 'assault', 	model = 'w_ar_nsr'},
	{name = 'WEAPON_VANDAL', 	bone = 24818, x = -0.22,    y = -0.15,     z = -0.13,     xRot = 100.0, yRot = -3.0, zRot = 5.0, category = 'assault', 	model = 'w_ar_vandal'},
	{name = 'WEAPON_TX15', 	bone = 24818, x = 0.00,    y = 0.25,     z = -0.03,     xRot = 165.0, yRot = 135.0, zRot = 5.0, category = 'assault', 	model = 'w_ar_tx15'},
	{name = 'WEAPON_BLACKOPSAR', 	bone = 24818, x = 0.00,    y = 0.25,     z = -0.03,     xRot = 165.0, yRot = 135.0, zRot = 5.0, category = 'assault', 	model = 'w_ar_blackopsar'},
	{name = 'WEAPON_HK416A', 	bone = 24818, x = 0.00,    y = 0.25,     z = -0.03,     xRot = 165.0, yRot = 135.0, zRot = 5.0, category = 'assault', 	model = 'w_ar_hk416a'},
	
	-- [[VIP ISLAND]]--
	{name = 'WEAPON_m4a1whitenoise', 		   bone = 24818, x = -0.12,    y = -0.14,     z = -0.13,     xRot = 100.0, yRot = -3.0, zRot = 5.0, 	model = 'w_ar_m4a1whitenoise'},
	{name = 'WEAPON_ffarautotoon', 		    bone = 24818, x = -0.12,    y = -0.14,     z = -0.13,     xRot = 100.0, yRot = -3.0, zRot = 5.0, 	model = 'w_ar_ffarautotoon'},
	{name = 'WEAPON_lr300', 		   bone = 24818, x = -0.12,    y = -0.14,     z = -0.13,     xRot = 100.0, yRot = -3.0, zRot = 5.0, 	model = 'w_ar_lr300'},
	{name = 'WEAPON_reapervandal', 		  bone = 24818, x = -0.12,    y = -0.14,     z = -0.13,     xRot = 100.0, yRot = -3.0, zRot = 5.0, 	model = 'w_ar_reapervandal'},
	{name = 'WEAPON_m13redtiger', 		  bone = 24818, x = -0.12,    y = -0.14,     z = -0.13,     xRot = 100.0, yRot = -3.0, zRot = 5.0, 	model = 'w_ar_m13redtiger'},
	{name = 'WEAPON_awphyperbeast', 		  bone = 24818, x = -0.12,    y = -0.14,     z = -0.13,     xRot = 100.0, yRot = -3.0, zRot = 5.0, 	model = 'w_ar_awphyperbeast'},
	{name = 'WEAPON_graurainbow', 		 bone = 24818, x = -0.12,    y = -0.14,     z = -0.13,     xRot = 100.0, yRot = -3.0, zRot = 5.0, category = 'assault', 	model = 'w_ar_graurainbowcr'},
	{name = 'WEAPON_m13anime', 		    bone = 24818, x = -0.12,    y = -0.14,     z = -0.13,     xRot = 100.0, yRot = -3.0, zRot = 5.0, category = 'assault', 	model = 'w_ar_m13animecr'},
	{name = 'WEAPON_m4a4neva', 	bone = 24818, x = -0.22,    y = -0.15,     z = -0.13,     xRot = 100.0, yRot = -3.0, zRot = 5.0, category = 'assault', 	model = 'w_ar_m4a4neva'},
	{name = 'WEAPON_luxeoperator', 	bone = 24818, x = -0.22,    y = -0.15,     z = -0.13,     xRot = 100.0, yRot = -3.0, zRot = 5.0, category = 'sniper', 	model = 'w_sr_luxeoperator'},


}

Citizen.CreateThread(function()
	while true do
		local playerPed = GetPlayerPed(-1)

		for i=1, #ConfigWeaponsAttached, 1 do

    		local weaponHash = GetHashKey(ConfigWeaponsAttached[i].name)

    		if HasPedGotWeapon(playerPed, weaponHash, false) then
    			local onPlayer = false

				for k, entity in pairs(Weapons) do
				  if entity then
      				if entity.weapon == ConfigWeaponsAttached[i].name then
      					onPlayer = true
      					break
      				end
				  end
      			end
	      		
      			if not onPlayer and weaponHash ~= GetSelectedPedWeapon(playerPed) then
	      			SetGear(ConfigWeaponsAttached[i].name)
      			elseif onPlayer and weaponHash == GetSelectedPedWeapon(playerPed) then
	      			RemoveGear(ConfigWeaponsAttached[i].name)
      			end
			else
				RemoveGear(ConfigWeaponsAttached[i].name)
    		end
  		end
		Wait(500)
	end
end)
-----------------------------------------------------------
-----------------------------------------------------------
RegisterNetEvent('removeWeapon')
AddEventHandler('removeWeapon', function(weaponName)
	RemoveGear(weaponName)
end)
RegisterNetEvent('removeWeapons')
AddEventHandler('removeWeapons', function()
	RemoveGears()
end)
-----------------------------------------------------------
-----------------------------------------------------------
-- Remove only one weapon that's on the ped
function RemoveGear(weapon)
	local _Weapons = {}

	for i, entity in pairs(Weapons) do
		if entity.weapon ~= weapon then
			_Weapons[i] = entity
		else
			DeleteWeapon(entity.obj)
		end
	end

	Weapons = _Weapons
end
-----------------------------------------------------------
-----------------------------------------------------------
-- Remove all weapons that are on the ped
function RemoveGears()
	for i, entity in pairs(Weapons) do
		DeleteWeapon(entity.obj)
	end
	Weapons = {}
end
-----------------------------------------------------------
-----------------------------------------------------------
function SpawnObject(model, coords, cb)

  local model = (type(model) == 'number' and model or GetHashKey(model))
  -- Thread: https://forum.fivem.net/t/low-fps-and-extremely-degradation-of-the-performance-overtime/99158/16
  if not IsModelInCdimage(model) then return 0 end -- This might fix FPS/Memory issue
  Citizen.CreateThread(function()

    RequestModel(model)

    while not HasModelLoaded(model) do
      Citizen.Wait(0)
    end

    local obj = CreateObject(model, coords.x, coords.y, coords.z, true, true, true)

    if cb ~= nil then
      cb(obj)
    end

  end)

end

function DeleteWeapon(object)
  SetEntityAsMissionEntity(object,  false,  true)
  DeleteObject(object)
end
-- Add one weapon on the ped
function SetGear(weapon)
	local bone       = nil
	local boneX      = 0.0
	local boneY      = 0.0
	local boneZ      = 0.0
	local boneXRot   = 0.0
	local boneYRot   = 0.0
	local boneZRot   = 0.0
	local playerPed  = GetPlayerPed(-1)
	local model      = nil
	local playerWeapons = tvRP.getWeapons()
		
	for i=1, #ConfigWeaponsAttached, 1 do
		if ConfigWeaponsAttached[i].name == weapon then
			bone     = ConfigWeaponsAttached[i].bone
			boneX    = ConfigWeaponsAttached[i].x
			boneY    = ConfigWeaponsAttached[i].y
			boneZ    = ConfigWeaponsAttached[i].z
			boneXRot = ConfigWeaponsAttached[i].xRot
			boneYRot = ConfigWeaponsAttached[i].yRot
			boneZRot = ConfigWeaponsAttached[i].zRot
			model    = ConfigWeaponsAttached[i].model
			break
		end
	end

	SpawnObject(model, {
		x = x,
		y = y,
		z = z
	}, function(obj)
		local playerPed = GetPlayerPed(-1)
		local boneIndex = GetPedBoneIndex(playerPed, bone)
		local bonePos 	= GetWorldPositionOfEntityBone(playerPed, boneIndex)
		AttachEntityToEntity(obj, playerPed, boneIndex, boneX, boneY, boneZ, boneXRot, boneYRot, boneZRot, false, false, false, false, 2, true)
		table.insert(Weapons,{weapon = weapon, obj = obj})
	end)
end

local weapon_types = {
  "WEAPON_BERETTA",
  "WEAPON_M1911",
  "WEAPON_UMP45",
  "WEAPON_PT92",
  "WEAPON_AKM",
  "WEAPON_AK74",
  "WEAPON_UMP45",
  "WEAPON_MOSIN",
  "WEAPON_AK200",
  "WEAPON_SCAR",
  "WEAPON_BORA",
  "WEAPON_WINCHESTER12",
  "WEAPON_M16A4",
}

-----------------------------------------------------------
-----------------------------------------------------------
-- Add all the weapons in the xPlayer's loadout
-- on the ped
function SetGears()
	local bone       = nil
	local boneX      = 0.0
	local boneY      = 0.0
	local boneZ      = 0.0
	local boneXRot   = 0.0
	local boneYRot   = 0.0
	local boneZRot   = 0.0
	local playerPed  = GetPlayerPed(-1)
	local model      = nil
	local playerWeapons = tvRP.getWeapons()
	local weapon 	 = nil
	
	for k,v in pairs(playerWeapons) do
		
		for j=1, #ConfigWeaponsAttached, 1 do
			if ConfigWeaponsAttached[j].name == k then
				
				bone     = ConfigWeaponsAttached[j].bone
				boneX    = ConfigWeaponsAttached[j].x
				boneY    = ConfigWeaponsAttached[j].y
				boneZ    = ConfigWeaponsAttached[j].z
				boneXRot = ConfigWeaponsAttached[j].xRot
				boneYRot = ConfigWeaponsAttached[j].yRot
				boneZRot = ConfigWeaponsAttached[j].zRot
				model    = ConfigWeaponsAttached[j].model
				weapon   = ConfigWeaponsAttached[j].name 
				
				break

			end
		end

		local _wait = true

		SpawnObject(model, {
			x = x,
			y = y,
			z = z
		}, function(obj
		)
			
			local playerPed = GetPlayerPed(-1)
			local boneIndex = GetPedBoneIndex(playerPed, bone)
			local bonePos 	= GetWorldPositionOfEntityBone(playerPed, boneIndex)

			AttachEntityToEntity(obj, playerPed, boneIndex, boneX, boneY, boneZ, boneXRot, boneYRot, boneZRot, false, false, false, false, 2, true)						

			table.insert(Weapons,{weapon = weapon, obj = obj})

			_wait = false

		end)

		while _wait do
			Wait(0)
		end
    end

end