











fx_version 'cerulean'
games { 'gta5' }

server_scripts {
	'@vrp/lib/utils.lua',
	'config.lua',
	'source/fuel_server.lua'
}

client_scripts {
	'config.lua',
	'source/fuel_client.lua'
}

exports {
	'GetFuel',
	'SetFuel'
}