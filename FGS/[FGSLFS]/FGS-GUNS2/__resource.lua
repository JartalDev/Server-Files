resource_manifest_version '77731fab-63ca-442c-a67b-abc70f28dfa5'
 
files {
	'meta/**/pedpersonality.meta',
	'meta/**/weaponanimations.meta',
	'meta/**/weaponarchetypes.meta',
	'meta/**/weapons.meta',
	'meta/**/weaponcomponents.meta',
	'meta/**/weaponNames.meta',
	}
--[[META]]
data_file 'WEAPONCOMPONENTSINFO_FILE' 'meta/**/weaponcomponents.meta'
data_file 'WEAPON_METADATA_FILE' 'meta/**/weaponarchetypes.meta'
data_file 'WEAPON_ANIMATIONS_FILE' 'meta/**/weaponanimations.meta'
data_file 'PED_PERSONALITY_FILE' 'meta/**/pedpersonality.meta'
data_file 'WEAPONINFO_FILE' 'meta/**/weapons.meta'
data_file 'WEAPON_NAMES_FILE' 'meta/**/weaponNames.meta'
--[[Client]]
client_scripts {
    'meta/**/cl_weaponNames.lua'
}